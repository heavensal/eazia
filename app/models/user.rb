class User < ApplicationRecord

  before_validation :capitalize_names
  after_create :user_thread, :initialize_instagram

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
  :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one :instagram_account, dependent: :destroy

  # after_create -> { add_tokens(10) }
  # validates :tokens, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :company, presence: true
  # validates :status, inclusion: { in: %w(admin premium freemium) }

  STATUSES = [
    ['Freemium', 'freemium'],
    ['Beginner', 'beginner'],
    ['Premium', 'premium'],
    ['Admin', 'admin']
  ].freeze

  def self.status_options
    STATUSES
  end

  def user_thread
    # creation d'une conversation entre un USER et CHATGPT
    thread_creator = Faraday.new(
      url: 'https://api.openai.com/v1/threads',
      headers: {'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{ENV['GPT_ANAIS']}",
      'OpenAI-Beta' => 'assistants=v1'}
      )

      response = thread_creator.post
      data = JSON.parse(response.body)
      self.update!(thread: data['id'])
    end

    def initialize_instagram
      create_instagram_account
    end

    ##################################################
    # STATUS
    def admin?
      self.status == "admin"
    end

    def premium?
      self.status == "premium"
    end

    def beginner?
      self.status == "beginner"
    end

    def freemium?
      self.status == "freemium"
    end

    def admin!
      self.update!(status: "admin")
    end

    def premium!
      self.gold_for_premium
      self.update!(status: "premium") unless self.admin?
    end

    def beginner!
      self.update!(status: "beginner")
    end

    def freemium!
      self.update!(status: "freemium")
    end
    ##################################################


    ##################################################
    # WALLET
    def wallet_empty?
      self.wallet.zero?
    end

    def add_gold(amount)
      self.update!(wallet: self.wallet + amount)
    end

    def remove_gold(amount)
      self.update!(wallet: self.wallet - amount)
    end

    def enough_gold?(amount)
      self.wallet >= amount
    end

    def gold_for_freemium
      add_gold(10)
    end

    def gold_for_premium
      add_gold(100)
    end

    def force_gold(amount)
      self.update!(wallet: amount)
    end
    ##################################################

    private

    def capitalize_names
      self.first_name = first_name.capitalize if first_name.present?
      self.last_name = last_name.capitalize if last_name.present?
    end

  end

  # POST

  # https://api.openai.com/v1/threads

  # https://api.openai.com/v1/threads/runs
  # a la creation d'un compte, assign un thread au user
  # envoyer le 1er message contenant user.information

  # une fois que tu fetch la réponse, assign le thread_id a user.thread
  # data.id

  # GET
  # https://api.openai.com/v1/threads/thread_bVsW5qarBwC4AXnYiSMwVma4/messages
  # quand tu fetch la reponse, data.data[-2]

# POST
# https://api.openai.com/v1/threads/thread_bVsW5qarBwC4AXnYiSMwVma4/messages
# en body: {
#   "role": "user",
#   "content": "quelque chose"
# }

# il interagit avec chatgpt et dall e sur ce thread
