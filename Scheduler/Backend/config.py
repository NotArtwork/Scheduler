class Config:
    SECRET_KEY = 'your-secret-key'  # Change this in production
    SQLALCHEMY_DATABASE_URI = 'sqlite://app.db'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
