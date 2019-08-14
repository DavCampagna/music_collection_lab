require_relative('../db/sql_runner')
require_relative('./album')

class Artist

  attr_reader(:id)
  attr_accessor(:name)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = "INSERT INTO artists (name)
    VALUES
    ($1)
    RETURNING id"
    values = [@name]
    artists = Sqlrunner.run(sql, values)
    @id = artists[0]["id"].to_i
  end

  def Artist.all
    sql = "SELECT * FROM artists"
    artists = Sqlrunner.run(sql)
    return artists.map { |artist| Artist.new(artist) }
  end

  def albums
    sql = "SELECT * FROM albums
          WHERE artist_id = $1"
    values = [@id]
    array_of_hashes = Sqlrunner.run(sql, values)
    array_of_album_objects = array_of_hashes.map { |hash| Album.new(hash) }
    return array_of_album_objects
  end

end
