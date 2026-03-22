module TurboStreamActionsHelper
  def show_modal(&block)
    action(:show_modal, nil, nil, allow_inferred_rendering: false, &block)
  end
end

Turbo::Streams::TagBuilder.prepend(TurboStreamActionsHelper)