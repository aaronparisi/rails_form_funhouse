# == Schema Information
#
# Table name: people
#
#  id                  :integer          not null, primary key
#  birthday            :date
#  country             :string
#  desc_ext            :string
#  email               :string
#  name                :string
#  photo_ext           :string
#  rating              :integer
#  subscribe_to_emails :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Person < ApplicationRecord
  DESC_FORMATS = ["txt"]
  PHOTO_FORMATS = ["jpg", "pdf", "gif"]
  NATIONS = {
    "United States of America" => "USA",
    "Canada" => "Canada",
    "Mexico" => "Mexico",
    "United Kingdom" => "UK",
    "China" => "China"
  }
  # constants have to be defined before they are used?
  # notice in the OutsideIn people app, the constants are not used until the helper methods use them

  after_save :store_photo, :store_desc

  validates_presence_of :birthday, message: " is required"
  validates_inclusion_of :birthday, in: Date.civil(1990, 1, 1)..Date.today, message: " must be a date between 1/1/1990 and today"
  validates_inclusion_of :country, in: NATIONS.values, message: " was not in collection"
  with_options if: :subscribed? do # |p|
    validates_presence_of :email, message: " required in order to subscribe"
    validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: " must be valid"
    validates_uniqueness_of :email, message: " is already taken"
  end
  validates_presence_of :name, message: " can't be blank"
  # validates_inclusion_of :photo_ext, in: Person::PHOTO_FORMATS, allow_nil: true, message: " #{self.desc_ext} not an accepted photo format"
  validates_inclusion_of :rating, in: 1..5, message: " must be between 1 and 5"

  def subscribed?
    self.subscribe_to_emails
  end

  ###########################################
  #### File Stuff ##########################
  ###########################################

  PHOTO_STORE = File.join Rails.root, 'public', 'photo_store'
  DESC_STORE = File.join Rails.root, 'public', 'desc_store'

  def photo=(photo_data)
    unless photo_data.nil?
      @photo_data = photo_data

      self.photo_ext = @photo_data.original_filename.split('.').last.downcase
    end
  end

  def desc=(desc_data)
    unless desc_data.nil?
      @desc_data = desc_data

      self.desc_ext = @desc_data.original_filename.split('.').last.downcase
    end
  end
  
  def photo_filename
    File.join PHOTO_STORE, "#{id}_photo.#{photo_ext}"
  end
  
  def desc_filename
    File.join DESC_STORE, "#{id}_desc.#{desc_ext}"
  end

  def photo_path
    "/photo_store/#{id}_photo.#{photo_ext}"
  end
  
  def desc_path
    "/desc_store/#{id}_desc.#{desc_ext}"
  end

  def has_photo?
    File.exists? photo_filename
  end

  def has_desc?
    File.exists? desc_filename
  end
  

  private

  def store_photo
    if @photo_data  
      FileUtils.mkdir_p PHOTO_STORE
      File.open(self.photo_filename, 'wb') do |f|
        f.write(@photo_data.read)
      end
    end
    @photo_data=nil
  end

  def store_desc
    if @desc_data  
      FileUtils.mkdir_p DESC_STORE
      File.open(self.desc_filename, 'wb') do |f|
        f.write(@desc_data.read)
      end
    end
    @desc_data=nil
  end

  # TODO make helper method
  
end
