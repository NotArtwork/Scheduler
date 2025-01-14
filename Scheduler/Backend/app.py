from flask import Flask, request, jsonify
from datetime import datetime, timedelta
from flask_jwt_extended import JWTManager, create_access_token
from flask_sqlalchemy import SQLAlchemy
from models import db, User, Class
from config import Config
from flask_cors import CORS



app = Flask(__name__)
app.config.from_object(Config)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///127.0.0.1:5000'  # Example for SQLite
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False  # Disable modification tracking (optional)

db = SQLAlchemy(app)
JWTManager(app)
CORS(app)


with app.app_context():
    db.create_all()
    print("Database tables created successfully!")

@app.route('/register', methods=['POST'])
def register():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    if not username or not password:
        return jsonify({"error": "Missing username or password"}), 400

    if User.query.filter_by(username=username).first():
        return jsonify({"error": "User already exists"}), 400

    new_user = User(username=username)
    new_user.set_password(password)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({"message": "User registered successfully"}), 201

@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    if not username or not password:
        return jsonify({"error": "Missing username or password"}), 400

    user = User.query.filter_by(username=username).first()
    if user and user.check_password(password):
        access_token = create_access_token(identity={"username": username})
        return jsonify({"token": access_token}), 200

    return jsonify({"error": "Invalid credentials"}), 401

if __name__ == '__main__':
    app.run(debug=True)

@app.route('/classes', methods=['GET'])
def get_classes_by_date():
    # Extract the date from the query parameters
    date_str = request.args.get('date')  # Expecting format: 'YYYY-MM-DD'
    if not date_str:
        return jsonify({"error": "Date parameter is required"}), 400

    try:
        query_date = datetime.strptime(date_str, '%Y-%m-%d').date()
    except ValueError:
        return jsonify({"error": "Invalid date format. Use YYYY-MM-DD"}), 400

    # Query classes for the given date
    classes = Class.query.filter_by(date=query_date).all()
    if not classes:
        return jsonify({"message": "No classes found for the selected date"}), 404

    # Serialize classes as JSON
    class_list = [
        {
            "id": c.id,
            "title": c.title,
            "description": c.description,
            "capacity": c.capacity,
            "start_time": c.start_time.strftime('%H:%M'),
            "end_time": c.end_time.strftime('%H:%M'),
            "location": c.location
        }
        for c in classes
    ]
    return jsonify(class_list), 200

@app.route('/signup', methods=['POST'])
def signup_for_class():
    data = request.get_json()
    user_id = data.get('user_id')
    class_id = data.get('class_id')

    if not user_id or not class_id:
        return jsonify({"error": "user_id and class_id are required"}), 400

    # Check if the user and class exist
    user = User.query.get(user_id)
    class_ = Class.query.get(class_id)
    if not user or not class_:
        return jsonify({"error": "User or Class not found"}), 404

    # Check if the user is already signed up
    if class_ in user.classes:
        return jsonify({"message": "User is already signed up for this class"}), 200

    # Add the user to the class
    user.classes.append(class_)
    db.session.commit()

    return jsonify({"message": f"User {user.username} signed up for class {class_.title}"}), 200
    

# Helper function to generate recurring classes
def create_recurring_classes(title, description, start_time, end_time, days, start_date, end_date, location, capacity):
    classes = []
    current_date = start_date
    while current_date <= end_date:
        if current_date.strftime("%A") in days:  # Check if the day is in the desired days of the week
            classes.append(
                Class(
                    title=title,
                    description=description,
                    capacity=capacity,
                    date=current_date,
                    start_time=start_time,
                    end_time=end_time,
                    location=location
                )
            )
        current_date += timedelta(days=1)
    return classes

# Define the schedule
with app.app_context():
    db.create_all()  # Ensure tables are created

    start_date = datetime(2025, 1, 8).date()  # Define start date
    end_date = datetime(2026, 2, 28).date()  # Define end date

    # Add classes to the database
    classes = []

    # Kickboxing mornings
    classes += create_recurring_classes(
        title="Kickboxing",
        description="Morning Kickboxing Class",
        start_time=datetime.strptime("10:00", "%H:%M").time(),
        end_time=datetime.strptime("11:00", "%H:%M").time(),
        days=["Monday", "Wednesday", "Friday"],
        start_date=start_date,
        end_date=end_date,
        location="Main Gym",
        capacity=20
    )

    # Muay Thai mornings
    classes += create_recurring_classes(
        title="Muay Thai",
        description="Morning Muay Thai Class",
        start_time=datetime.strptime("10:00", "%H:%M").time(),
        end_time=datetime.strptime("11:00", "%H:%M").time(),
        days=["Tuesday", "Thursday"],
        start_date=start_date,
        end_date=end_date,
        location="Main Gym",
        capacity=20
    )

    # Muay Thai nights
    classes += create_recurring_classes(
        title="Muay Thai",
        description="Night Muay Thai Class",
        start_time=datetime.strptime("20:00", "%H:%M").time(),
        end_time=datetime.strptime("21:00", "%H:%M").time(),
        days=["Tuesday", "Thursday"],
        start_date=start_date,
        end_date=end_date,
        location="Main Gym",
        capacity=20
    )

    # Kickboxing nights
    classes += create_recurring_classes(
        title="Kickboxing",
        description="Night Kickboxing Class",
        start_time=datetime.strptime("20:00", "%H:%M").time(),
        end_time=datetime.strptime("21:00", "%H:%M").time(),
        days=["Monday", "Wednesday", "Friday"],
        start_date=start_date,
        end_date=end_date,
        location="Main Gym",
        capacity=20
    )

    # Kids classes
    classes += create_recurring_classes(
        title="Kids Class",
        description="Kids Martial Arts Class",
        start_time=datetime.strptime("15:00", "%H:%M").time(),
        end_time=datetime.strptime("16:00", "%H:%M").time(),
        days=["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
        start_date=start_date,
        end_date=end_date,
        location="Kids Room",
        capacity=15
    )

    # Add all classes to the database
    db.session.add_all(classes)
    db.session.commit()

    print("Template data added successfully.")

    
def seed_data():
    # Check if the database already has data
    if not User.query.first() and not Class.query.first():
        # Create a default user
        user = User(username="admin")
        user.set_password("admin123")
        db.session.add(user)

        # Create some classes
        classes = [
            Class(
                title="Kickboxing Morning",
                description="Morning Kickboxing class",
                capacity=20,
                date=datetime(2025, 1, 10).date(),
                start_time=datetime.strptime("10:00", "%H:%M").time(),
                end_time=datetime.strptime("11:00", "%H:%M").time(),
                location="Main Gym"
            ),
            Class(
                title="Muay Thai Evening",
                description="Evening Muay Thai class",
                capacity=15,
                date=datetime(2025, 1, 12).date(),
                start_time=datetime.strptime("20:00", "%H:%M").time(),
                end_time=datetime.strptime("21:00", "%H:%M").time(),
                location="Main Gym"
            ),
        ]

        db.session.add_all(classes)
        db.session.commit()
        print("Seed data added successfully!")

# Call the seed_data function
with app.app_context():
    seed_data()
    print('seed imported')