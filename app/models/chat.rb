class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  validates :uuid, presence: true, uniqueness: true
  UUID_REGEX = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i
  validates :uuid, format: { with: UUID_REGEX }

  MODELS = [
    {
      provider: "gemini",
      id: "gemini-2.5-flash",
      name: "gemini-2.5-flash",
      description: "次世代の機能と強化された機能を提供",
      access_token: Rails.application.credentials.dig(:gemini, :api_key),
      uri_base: "https://generativelanguage.googleapis.com/v1beta/openai/"
    },
    {
      provider: "openai",
      id: "gpt-4o",
      name: "gpt-4o",
      description: "汎用性と知能に優れたフラッグシップモデル",
      access_token: Rails.application.credentials.dig(:openai, :api_key),
      uri_base: nil # 指定不要
    }
  ]
end
