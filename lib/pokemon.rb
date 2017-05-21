require "pry"
class Pokemon
  attr_accessor :id, :name, :type, :hp, :db

  def initialize(args = {})
    @id = args['id']
    @name = args['name']
    @type = args['type']
    @db = args['db']
    if args['hp']
      @hp = args['hp']
    else
      @hp = 60
    end
  end

  def self.save(name, type, db)
    db.prepare("INSERT INTO pokemon (name, type) VALUES ('#{name}', '#{type}');").execute
  end

  def self.find(id, db)
    db.results_as_hash = true
    result = db.prepare("SELECT * FROM pokemon WHERE id = #{id};").execute.first
    result['db'] = db
    Pokemon.new(result)
  end

  def alter_hp(hp, db)
    db.prepare("UPDATE pokemon SET hp = #{hp} WHERE id = #{self.id};").execute
  end
end
