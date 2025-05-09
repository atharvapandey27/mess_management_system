import React, { useState } from "react";
import Food from "./assets/Food.png";
import "./SignupStudent.css";
import { Link, useNavigate } from "react-router-dom";
import { SignupUser } from "./api/api.js"; // Ensure this API call works correctly with your backend

const SignupStudent = () => {
  const navigate = useNavigate();
  const [role, setRole] = useState("Student");
  const [form, setForm] = useState({
    full_name: "",
    roll_no: "",
    email: "",
    phone_number: "",
    hostel: "",
    password: "",
  });
  const [error, setError] = useState("");
  const [successMessage, setSuccessMessage] = useState("");

  const handleChange = (e) => {
    const { name, value } = e.target; // Dynamically update the form state
    setForm((prevForm) => ({ ...prevForm, [name]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      // Validate Roll No for Students
      if (role === "Student" && !form.roll_no) {
        setError("Roll number is required for students");
        return;
      }

      // Prepare Payload
      const payload = {
        ...form,
        role,
        roll_no: form.roll_no ? parseInt(form.roll_no, 10) : null, // Ensure roll_no is an integer
      };

      // API Call
      const response = await SignupUser(payload);
      if (response.data.success) {
        setSuccessMessage("Account successfully created!");
        setError(""); // Clear previous errors
        navigate("/Login"); // Redirect to Login page
      } else {
        setError(response.data.message || "Signup failed");
      }
    } catch (err) {
      console.error("Signup error:", err);
      setError(err.response?.data?.message || "An error occurred during signup.");
    }
  };

  const handlestudent = () => {
    setRole("Student");
    setError(""); // Clear any errors
    document.getElementById("student").style.backgroundColor="#C3D09A"
    document.getElementById("student").style.color="#4F622E"
    document.getElementById("staff").style.backgroundColor="#EFEDE4"
    document.getElementById("staff").style.color="#4F622E"

  };

  const handlestaff = () => {
    setRole("Staff");
    setError(""); // Clear any errors
    setForm((prevForm) => ({ ...prevForm, roll_no: "" })); // Clear roll_no for staff
    document.getElementById("staff").style.backgroundColor="#C3D09A"
    document.getElementById("staff").style.color="#4F622E"
    document.getElementById("student").style.backgroundColor="#EFEDE4"
    document.getElementById("student").style.color="#4F622E"

  };

  return (
    <div className="container">
      <div className="image-section">
        <img className="IMG" alt="Img" src={Food} />
      </div>
      <div className="form-section">
        <h1>WELCOME TO MEXX</h1>
        <p className="subtitle">Create Your Account</p>

        <div className="toggle-buttons">
          <button
            onClick={handlestudent}
            id="student"
            className={`Student ${role === "Student" ? "active" : ""}`}
          >
            Student
          </button>
          <div className="separator-line"></div>
          <button
            onClick={handlestaff}
            id="staff"
            className={`Staff ${role === "Staff" ? "active" : ""}`}
          >
            Staff
          </button>
        </div>

        <form onSubmit={handleSubmit}>
          <div id="form1" className="form-row">
            <input
              className="name"
              type="text"
              name="full_name"
              placeholder="Name"
              value={form.full_name}
              onChange={handleChange}
              required
            />
            {role === "Student" && (
              <input
                className="name"
                id="rollno"
                type="text"
                name="roll_no"
                placeholder="Roll No."
                value={form.roll_no}
                onChange={handleChange}
                required
              />
            )}
          </div>
          <div className="form-row">
            <input
              className="name"
              type="text"
              name="phone_number"
              placeholder="Contact No."
              value={form.phone_number}
              onChange={handleChange}
              required
            />
            <input
              className="name"
              type="text"
              name="hostel"
              placeholder="Hostel"
              value={form.hostel}
              onChange={handleChange}
              required
            />
          </div>
          <input
            className="email"
            type="email"
            name="email"
            placeholder="Email"
            value={form.email}
            onChange={handleChange}
            required
          />
          <input
            className="password"
            type="password"
            name="password"
            placeholder="Password"
            value={form.password}
            onChange={handleChange}
            required
          />

          <button type="submit" className="submit-btn">
            Create Account
          </button>
          {error && <div className="error-message">{error}</div>}
          {successMessage && <div className="success-message">{successMessage}</div>}
          <p className="login-link">
            Already have an Account? <Link className="Signup-link" to="/Login">Log In</Link>
          </p>
        </form>
      </div>
    </div>
  );
};

export default SignupStudent;
