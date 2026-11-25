require 'sqlite3'
require_relative '../config'

db = SQLite3::Database.new(DB_PATH)

puts "Använder databasen: #{DB_PATH}"
puts "🧹 Tar bort gamla tabeller..."
db.execute('DROP TABLE IF EXISTS todos')
db.execute('DROP TABLE IF EXISTS users')

puts "🧱 Skapar tabeller..."
db.execute('CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT NOT NULL UNIQUE,
          email TEXT,
          password TEXT NOT NULL )')


db.execute('CREATE TABLE todos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL, 
            description TEXT,
            completed INTEGER DEFAULT 0,
            user_id INTEGER,
            FOREIGN KEY (user_id) REFERENCES users(id) )')

puts "🍎 Fyller på med data..."
db.execute("INSERT INTO users ( username, email, password) VALUES ('jacob', 'jacobfinndin@example.com', 'jacob1')")
db.execute("INSERT INTO users ( username, email, password) VALUES ('hugo', 'hugograhn@example.com', 'hugo2')")

db.execute('INSERT INTO todos (name, description, completed, user_id) VALUES ("Köp mjölk", "3 lite mellanmjölk, eko", 1, 1)')
db.execute('INSERT INTO todos (name, description, completed, user_id) VALUES ("Köp julgran", "En rödgran", 0, 2)')
db.execute('INSERT INTO todos (name, description, completed, user_id) VALUES ("Pynta gran", "Glöm inte lamporna i granen och tomten", 0, 3)')

puts "✅ Databasen är seedad!"