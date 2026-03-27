class GlossaryTerm < ApplicationRecord
  validates :term, presence: true, uniqueness: true
  validates :description, presence: true

  def self.matching_prompt(prompt)
    return [] if prompt.blank?

    all.select { |glossary_term| prompt.include?(glossary_term.term) }
  end
end