from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from datetime import datetime

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# --- Database Configuration ---
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://aldricanto:smartpay123@localhost:5432/bank_app'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# --- Models ---
class User(db.Model):
    __tablename__ = 'user'  # Explicitly set the table name to 'user' (lowercase)

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.String(200), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    created_at = db.Column(db.DateTime, server_default=db.func.now())

class Account(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    account_number = db.Column(db.String(20), unique=True, nullable=False)
    balance = db.Column(db.Numeric(12, 2), default=0.00)
    created_at = db.Column(db.DateTime, server_default=db.func.now())

class Transaction(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    sender_account_id = db.Column(db.Integer, db.ForeignKey('account.id'), nullable=False)
    receiver_account_id = db.Column(db.Integer, db.ForeignKey('account.id'), nullable=False)
    amount = db.Column(db.Numeric(12, 2), nullable=False)
    transaction_type = db.Column(db.String(10), nullable=False)  # Example: 'transfer'
    created_at = db.Column(db.DateTime, server_default=db.func.now())

# --- Routes ---
@app.route('/')
def home():
    return "Welcome to the Banking App!"

# --- User Registration ---
@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    username = data.get('username')
    email = data.get('email')
    password = data.get('password')

    if not username or not email or not password:
        return jsonify({"error": "Please provide username, email, and password."}), 400

    # Check if username or email already exists in the database
    existing_user = User.query.filter(
        (User.username == username) | (User.email == email)
    ).first()

    if existing_user:
        return jsonify({"error": "Username or Email already exists."}), 400

    # Create a new user if validation passes
    new_user = User(username=username, email=email, password=password)

    # Add to database and commit changes
    db.session.add(new_user)
    db.session.commit()

    # Send response to client
    return jsonify({"message": "User registered successfully!"}), 201

# --- User Login ---
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return jsonify({"error": "Email and password are required."}), 400

    user = User.query.filter_by(email=email).first()

    if not user:
        return jsonify({"error": "Email not registered."}), 401

    if user.password != password:
        return jsonify({"error": "Incorrect password."}), 401

    return jsonify({
        "message": "Successfully logged in!",
        "user": {
            "id": user.id,
            "username": user.username,
            "email": user.email
        }
    }), 200

# --- Run Server ---
if __name__ == '__main__':
    with app.app_context():
        db.create_all()  # Create tables if they don't exist
    app.run(debug=True, host='0.0.0.0', port=5000)  # Make sure Flask is accessible externally
