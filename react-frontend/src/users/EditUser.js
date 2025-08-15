import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate, useParams } from 'react-router-dom';
import { Link } from 'react-router-dom';

export default function EditUser() {
    let navigate = useNavigate();
    const { id } = useParams();

    const [user, setUser] = useState({
        name: "",
        username: "",
        email: "",
    });

    const { name, username, email } = user;

    const onInputChange = (e) => {
        setUser({ ...user, [e.target.name]: e.target.value });
    };

    useEffect(() => {
        loadUser();
    }, []);

    const onSubmit = async (e) => {
        e.preventDefault();
        try {
            await axios.put(`${process.env.REACT_APP_SPRING_BOOT_URL}/user/${id}`, user);
            navigate("/");
        } catch (error) {
            // Handle errors here
            console.error('Error updating user:', error);
        }
    };

    const loadUser = async () => {
        try {
            const result = await axios.get(`${process.env.REACT_APP_SPRING_BOOT_URL}/user/${id}`);
            setUser(result.data);
        } catch (error) {
            // Handle errors here
            console.error('Error loading user data:', error);
        }
    };

    return (
        <div className='container'>
            <div className='row'>
                <div className='col-md-6 offset-md-3 border rounded p-4 mt-2 shadow'>
                    <h2 className='text-center m-3'>Edit User</h2>
                    <form onSubmit={(e) => onSubmit(e)}>
                        <div className='mb-3'>
                            <label htmlFor='Name' className='form-label'> Name </label>
                            <input type={"text"} className='form-control' placeholder='Enter your name' name="name" value={name} onChange={(e) => onInputChange(e)}></input>
                        </div>
                        <div className='mb-3'>
                            <label htmlFor='UserName' className='form-label'> Username </label>
                            <input type={"text"} className='form-control' placeholder='Enter your UserName' name="username" value={username} onChange={(e) => onInputChange(e)}></input>
                        </div>
                        <div className='mb-3'>
                            <label htmlFor='Email' className='form-label'> Email </label>
                            <input type={"email"} className='form-control' placeholder='Enter your Email' name="email" value={email} onChange={(e) => onInputChange(e)}></input>
                        </div>
                        <div>
                            <small id="emailHelp" className="form-text text-muted" color='grey'>We'll never share your data with anyone else.</small>
                        </div>
                        <div className='d-flex align-items-center mb-3 mt-3'>
                            <input type='checkbox' className='mr-2' id='exampleCheck1' style={{ float: 'left' }} required></input>
                            <label htmlFor='exampleCheck1' style={{ marginBottom: '0', textIndent: '7px' }}>
                                Check this box to proceed
                            </label>
                        </div>
                        <button type="submit" className='btn btn-outline-primary'>Submit</button>
                        <Link type="submit" className='btn btn-outline-danger mx-2' to='/'>Cancel</Link>
                    </form>
                </div>
            </div>
        </div>
    );
}
