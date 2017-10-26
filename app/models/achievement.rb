class Achievement < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: {
      scope: :user_id,
      message: "you can't have two achievements withe the same title"
  }
  validates :user, presence: true
  enum privacy: [ :public_access, :private_access, :friends_access ]

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end

  def silly_title
    "#{title} by #{user.email}"
  end
end
