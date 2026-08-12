module AutoTranslatable
  extend ActiveSupport::Concern

  included do
    attr_accessor :skip_auto_translate
    after_commit :enqueue_auto_translate_job, on: [:create, :update], unless: :skip_auto_translate
  end

  private

  def enqueue_auto_translate_job
    AutoTranslateJob.perform_later(self.class.name, self.id)
  end
end
