require "pry"

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    self.all << self.new
    self.all.last
  end

  def self.new_by_name(song_name)
    new_song = self.new
    new_song.name = song_name
    new_song
  end

  def self.create_by_name(song_name)
    self.all << self.new_by_name(song_name)
    self.all.last
  end

  def self.find_by_name(song_name)
    self.all.detect {|song| song.name == song_name}
  end

  def self.find_or_create_by_name(song_name)
    return self.find_by_name(song_name) || self.create_by_name(song_name)
  end

  def self.alphabetical
    self.all.sort {|x,y| x.name <=> y.name}
  end

  def self.new_from_filename(filename)
    file_arr = filename.split(" - ")
    artist_name = file_arr[0]
    song_name = file_arr[1].slice(0...file_arr[1].index(".mp"))
    new_song = self.create_by_name(song_name)
    new_song.artist_name = artist_name
    new_song
  end

  def self.create_from_filename(filename)
    self.all << self.new_from_filename(filename)
    self.all.last
  end

  def self.destroy_all
    self.all.clear
  end
  
end
