from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime

app = Flask(__name__)

# ✅ Configure your PostgreSQL Database URL
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://aldricanto:smartpay123@localhost:5432/bank_app'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# --- Models ---
class User(db.Model):
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
    transaction_type = db.Column(db.String(10), nullable=False)  # 'transfer'
    created_at = db.Column(db.DateTime, server_default=db.func.now())

# --- Routes ---

# 🚀 Root Route
@app.route('/')
def home():
    return "Welcome to the Banking App!"

# 🚀 Register Route
@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()

    username = data.get('username')
    email = data.get('email')
    password = data.get('password')

    # Validation: Ensure all fields are provided
    if not username or not email or not password:
        return jsonify({"error": "Please provide username, email, and password."}), 400

    # Check if the username or email already exists
    existing_user = User.query.filter(
        (User.username == username) | (User.email == email)
    ).first()

    if existing_user:
        return jsonify({"error": "Username or Email already exists."}), 400

    # Hash the password before saving it
    hashed_password = generate_password_hash(password)

    # Create a new user
    new_user = User(username=username, email=email, password=hashed_password)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({"message": "User registered successfully!"}), 201

# 🚀 Login Route
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()

    email = data.get('email')
    password = data.get('password')

    user = User.query.filter_by(email=email).first()

    # If the user doesn't exist or the password doesn't match
    if not user or not check_password_hash(user.password, password):
        return jsonify({"error": "Invalid credentials."}), 401

    return jsonify({"message": "Successfully logged in!"}), 200

# 🚀 Link Account Route
@app.route('/link_account', methods=['POST'])
def link_account():
    data = request.get_json()

    user_id = data.get('user_id')
    account_number = data.get('account_number')

    user = User.query.get(user_id)
    if not user:
        return jsonify({"error": "User not found."}), 404

    # Check if the account already exists
    existing_account = Account.query.filter_by(account_number=account_number).first()
    if existing_account:
        return jsonify({"error": "Account already linked."}), 400

    # Create and link a new account
    new_account = Account(user_id=user_id, account_number=account_number)
    db.session.add(new_account)
    db.session.commit()

    return jsonify({"message": "Account linked successfully!"}), 201

# 🚀 Transfer Money Route
@app.route('/transfer', methods=['POST'])
def transfer():
    data = request.get_json()

    sender_account_id = data.get('sender_account_id')
    receiver_account_number = data.get('receiver_account_number')
    amount = data.get('amount')

    if not sender_account_id or not receiver_account_number or not amount:
        return jsonify({"error": "Please provide sender_account_id, receiver_account_number, and amount."}), 400

    sender_account = Account.query.get(sender_account_id)
    if not sender_account:
        return jsonify({"error": "Sender account not found."}), 404

    receiver_account = Account.query.filter_by(account_number=receiver_account_number).first()
    if not receiver_account:
        return jsonify({"error": "Receiver account not found."}), 404

    # Check if sender has enough balance
    if sender_account.balance < amount:
        return jsonify({"error": "Insufficient funds."}), 400

    # Deduct amount from sender's account
    sender_account.balance -= amount

    # Add amount to receiver's account
    receiver_account.balance += amount

    # Create transaction record
    new_transaction = Transaction(
        sender_account_id=sender_account.id,
        receiver_account_id=receiver_account.id,
        amount=amount,
        transaction_type='transfer'
    )
    db.session.add(new_transaction)
    db.session.commit()

    return jsonify({
        "message": "Transfer successful!",
        "sender_balance": str(sender_account.balance),
        "receiver_balance": str(receiver_account.balance)
    }), 200

# 🚀 Transaction History Route
@app.route('/transaction_history', methods=['GET'])
def transaction_history():
    user_id = request.args.get('user_id')
    if not user_id:
        return jsonify({"error": "Please provide user_id."}), 400

    user = User.query.get(user_id)
    if not user:
        return jsonify({"error": "User not found."}), 404

    # Get all accounts linked to the user
    accounts = Account.query.filter_by(user_id=user.id).all()
    account_ids = [account.id for account in accounts]

    transactions = Transaction.query.filter(
        (Transaction.sender_account_id.in_(account_ids)) | (Transaction.receiver_account_id.in_(account_ids))
    ).all()

    transaction_list = [{
        "sender_account_id": txn.sender_account_id,
        "receiver_account_id": txn.receiver_account_id,
        "amount": str(txn.amount),
        "transaction_type": txn.transaction_type,
        "created_at": txn.created_at
    } for txn in transactions]

    return jsonify({"transactions": transaction_list}), 200

# --- Start the server ---
if __name__ == '__main__':
    with app.app_context():
        db.create_all()  # Create all tables from your models (if not already created)
    app.run(debug=True)
