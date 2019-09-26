class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save (name, type, db)
        sql = <<-SQL
          INSERT INTO pokemon (name, type) VALUES (?, ?)
        SQL
        result = db.execute(sql, name, type)
        id = db.execute("SELECT last_insert_rowid() FROM pokemon")
        self.new(id: id, name: name, type: type, db: db)
    end

    def self.find(id, db)
        pokemon_row = db.execute("SELECT * FROM pokemon WHERE id = ?", id).first
        self.new(id: pokemon_row[0], name: pokemon_row[1], type: pokemon_row[2], db: db)
    end
end
