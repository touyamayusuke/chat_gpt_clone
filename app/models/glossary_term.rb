class GlossaryTerm < ApplicationRecord
  validates :term, presence: true, uniqueness: true
  validates :description, presence: true

  def self.matching_prompt(prompt)
    return { exact: [], candidates: [] } if prompt.blank?

    # 1. 完全一致を探す
    exact_matches = all.select { |glossary_term| prompt.include?(glossary_term.term) }
    return { exact: exact_matches, candidates: [] } if exact_matches.present?

    # 2. 完全一致がない場合、共通文字がある用語を含まれるもの（「もしかして」候補）
    prompt_chars = prompt.chars.to_set
    candidates = all.select do |glossary_term|
      term_chars = glossary_term.term.chars.to_set
      (prompt_chars & term_chars).present?  # 共通文字がある
    end
    
    { exact: [], candidates: candidates }
  end
end