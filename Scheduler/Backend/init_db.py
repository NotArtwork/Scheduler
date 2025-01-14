import sqlite3
from datetime import datetime

# Path to your SQLite database file
db_file = 'app.db'

# SQL statements to create tables based on your models
create_users_table = """
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL
);
"""

create_classes_table = """
CREATE TABLE IF NOT EXISTS classes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    capacity INTEGER NOT NULL,
    date TEXT NOT NULL,
    start_time TEXT NOT NULL,
    end_time TEXT NOT NULL,
    location TEXT NOT NULL,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);
"""

def create_tables(db_file):
    """
    Creates the SQLite database and the required tables if they do not already exist.
    """
    try:
        # Connect to the database (it will create it if it doesn't exist)
        conn = sqlite3.connect(db_file)
        cursor = conn.cursor()

        # Create the tables using SQL commands from models
        cursor.execute(create_users_table)
        cursor.execute(create_classes_table)

        # Commit the changes and close the connection
        conn.commit()
        conn.close()

        print("Database and tables created successfully!")

    except sqlite3.Error as e:
        print(f"Error creating database/tables: {e}")

def insert_default_data(db_file):
    """
    Insert default data into the tables if they're empty.
    """
    try:
        # Connect to the database
        conn = sqlite3.connect(db_file)
        cursor = conn.cursor()

        # Insert a default user if no users exist
        cursor.execute("SELECT * FROM users LIMIT 1")
        if cursor.fetchone() is None:
            cursor.execute("INSERT INTO users (username, password_hash) VALUES (?, ?)",
                           ('admin', 'admin123'))  # Replace with real hashed password in production
            print("Default user added.")

        # Insert some classes if the classes table is empty
        cursor.execute("SELECT * FROM classes LIMIT 1")
        if cursor.fetchone() is None:
            cursor.execute("""
                INSERT INTO classes (title, description, capacity, date, start_time, end_time, location, created_at, updated_at)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, ('Kickboxing Morning', 'Morning Kickboxing class', 20, '2025-01-10', '10:00', '11:00', 'Main Gym',
                  datetime.now().isoformat(), datetime.now().isoformat()))
            cursor.execute("""
                INSERT INTO classes (title, description, capacity, date, start_time, end_time, location, created_at, updated_at)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, ('Muay Thai Evening', 'Evening Muay Thai class', 15, '2025-01-12', '20:00', '21:00', 'Main Gym',
                  datetime.now().isoformat(), datetime.now().isoformat()))

            print("Default classes added.")

        # Commit the changes and close the connection
        conn.commit()
        conn.close()

    except sqlite3.Error as e:
        print(f"Error inserting default data: {e}")

if __name__ == "__main__":
    # Create the database and tables
    create_tables(db_file)

    # Insert default data into tables if they're empty
    insert_default_data(db_file)
