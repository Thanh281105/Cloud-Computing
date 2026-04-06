from flask import Flask, jsonify
import json
import os

app = Flask(__name__)

# Phase 1: GET /hello
@app.route('/hello')
def hello():
    return jsonify({
        "message": "Hello from MyMiniCloud!",
        "service": "application-backend-server",
        "status": "running"
    })

# Phase 2: GET /student
@app.route('/student')
def get_students():
    students = [
        {
            "id": 1,
            "student_id": "SV001",
            "fullname": "Nguyen Van A",
            "dob": "2002-01-15",
            "major": "Computer Science"
        },
        {
            "id": 2,
            "student_id": "SV002",
            "fullname": "Tran Thi B",
            "dob": "2001-06-20",
            "major": "Information Technology"
        },
        {
            "id": 3,
            "student_id": "SV003",
            "fullname": "Le Van C",
            "dob": "2003-03-10",
            "major": "Software Engineering"
        },
        {
            "id": 4,
            "student_id": "SV004",
            "fullname": "Pham Thi D",
            "dob": "2002-09-05",
            "major": "Data Science"
        },
        {
            "id": 5,
            "student_id": "SV005",
            "fullname": "Hoang Van E",
            "dob": "2001-12-25",
            "major": "Cyber Security"
        }
    ]
    return jsonify(students)

# Phase 2: GET /secure (Keycloak protected - basic demo)
@app.route('/secure')
def secure():
    return jsonify({
        "message": "This is a secured endpoint",
        "info": "In production, this would be protected by Keycloak"
    })

# Health check for Prometheus
@app.route('/health')
def health():
    return jsonify({"status": "healthy"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
