from app import app
from models import db, User, Class
from datetime import datetime, timedelta
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
    # db.create_all()  # Ensure tables are created

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