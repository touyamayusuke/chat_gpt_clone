# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.find_or_create_by!(email_address: "user@example.com") do |user|
  user.password = "password"
end

[
  {
    term: "MVP",
    description: "最小限の機能で価値検証を行うための最初の製品。"
  },
  {
    term: "RAG",
    description: "外部知識を検索してから生成モデルに渡し、回答精度を上げる手法。"
  },
  {
    term: "Kamal",
    description: "Docker イメージを使ってサーバーへアプリをデプロイするためのツール。"
  }
].each do |attributes|
  glossary_term = GlossaryTerm.find_or_initialize_by(term: attributes[:term])
  glossary_term.description = attributes[:description]
  glossary_term.save!
end