require 'uri'
class Link < ActiveRecord::Base
  before_save :url_valid?
  validates :title, presence: true
  validates :url, presence: true
  belongs_to :user

  def url_valid?
    url = self.url
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
    false
  end

  def status_output
    if self.status == false
      'Unread'
    else
      'Read'
    end
  end

end
