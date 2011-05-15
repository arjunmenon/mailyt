class Folder < ActiveRecord::Base
  # Associations
  has_many :emails
  belongs_to :parent, :class_name => 'Folder'
  belongs_to :email_account

  # Scopes
  scope :synced, where(:synced => true)
  scope :subscribed, where(:subscribed => true)
  
  # IMAP
  protected
    delegate :imap_connection, :to => :email_account

  public
  
  # Constructors
  def self.build_from_imap(imap_folder)
    folder = Folder.new
    
    folder.title = imap_folder.name
    return folder
  end

  # Accessors
  def email_count(sync = false)
    cached_count = read_attribute(:email_count)
    # Sync if requested or never done before
    do_sync = sync || cached_count.nil?
    
    notmuch_sync_counts if do_sync
    
    return read_attribute(:email_count)
  end

  def unseen_count(sync = false)
    cached_count = read_attribute(:unseen_count)
    # Sync if requested or never done before
    do_sync = sync || cached_count.nil?
    
    notmuch_sync_counts if do_sync
    
    return read_attribute(:unseen_count)
  end

  # Sync
  def notmuch_sync_counts
    email = Notmuch.call("count", "folder:#{title}").first.to_i
    unseen = Notmuch.call("count", "folder:#{title}", "tag:unread").first.to_i

    update_attributes(:email_count => email, :unseen_count => unseen)
  end
  
  def imap_sync_counts
    counts = imap_connection.status(title, ['UNSEEN', 'MESSAGES'])
    unseen = counts['UNSEEN']
    email = counts['MESSAGES']
    
    update_attributes(:email_count => email, :unseen_count => unseen)
  end
end
