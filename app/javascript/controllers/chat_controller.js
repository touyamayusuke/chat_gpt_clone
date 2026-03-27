import { Controller } from "@hotwired/stimulus"
import { marked } from "marked"
import DOMPurify from "dompurify"

const DEFAULT_CHAT_MODEL = "gemini-2.5-flash";

// Connects to data-controller="chat"
export default class extends Controller {
  static targets = ["prompt", "conversation", "scroll", "greeting"]
  connect() {
  }

  generateResponse(event) {
    event.preventDefault()

    if (this.hasGreetingTarget) {
      this.greetingTarget.remove();
    }

    const template = document.getElementById("chat-message");
    if (!template) return;

    const clone = template.content.cloneNode(true);
    clone.firstElementChild.setAttribute('data-role', 'user');
    const message = clone.querySelector(".message");
    message.innerHTML = this.promptTarget.value;
    this.conversationTarget.appendChild(clone);

    const assistantClone = template.content.cloneNode(true);
    assistantClone.firstElementChild.setAttribute('data-role', 'assistant');
    const assistantMessage = assistantClone.querySelector(".message");
    this.assistantMessage = assistantMessage;
    this.conversationTarget.appendChild(assistantClone);

    this.#streamAssistantResponse();

    this.promptTarget.value = "";
  }

  async #streamAssistantResponse() {
    const prompt = this.promptTarget.value;
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");

    const chatModel = document.cookie.split("; ").find(row => row.startsWith("chat_model="))?.split("=")[1] || DEFAULT_CHAT_MODEL;

    let uuid
    let newRecord = false;
    if (window.location.pathname === "/") {
      uuid = crypto.randomUUID();
      window.history.replaceState({}, "", `/chats/${uuid}`);
      newRecord = true;
    } else {
      uuid = window.location.pathname.split("/").pop();
    }
    const body = { prompt, uuid, chat_model: chatModel }


    const response = await fetch("/chats", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify(body)
    });

    if (!response.ok) {
      const errorText = await response.text();
      if (this.assistantMessage) {
        this.assistantMessage.textContent = `エラー: ${response.status} ${response.statusText}`;
      }
      console.error("Chat request failed:", response.status, errorText);
      return;
    }

    if (!response.body) {
      if (this.assistantMessage) {
        this.assistantMessage.textContent = "レスポンスを受信できませんでした。";
      }
      return;
    }

    const reader = response.body.getReader();
    const decoder = new TextDecoder();

    let rawContent = "";

    while (true) {
      const { done, value } = await reader.read();
      if (done) {
        if (newRecord) {
          fetch(`/chats/${uuid}`, {
            headers: {
              "X-CSRF-Token": csrfToken,
              "Accept": "text/vnd.turbo-stream.html",
            },
          }).then(response => response.text()).then(html => {
            Turbo.renderStreamMessage(html);
          });
        }
        break;
      }
      if (!value) continue;

      const lines = decoder.decode(value).trim().split("\n");
      console.log("lines:", lines);
      for (const line of lines) {
        if (line.startsWith("data: ")) {
          const raw = line.slice(6);
          try {
            const { message } = JSON.parse(raw);
            rawContent += message;
            this.assistantMessage.innerHTML = DOMPurify.sanitize(marked.parse(rawContent));
            this.scrollTarget.scrollIntoView({ behavior: "smooth", block: "end" });
          } catch (error) {
            console.error("Failed to parse JSON:", error, "Raw data:", raw);
            continue;
          }
        }
      }
    }
  }
}
