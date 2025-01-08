class Config:
    SECRET_KEY = 'your-secret-key'  # Change this in production
    SQLALCHEMY_DATABASE_URI = 'sqlite:///db.sqlite'
    SQLALCHEMY_TRACK_MODIFICATIONS = False