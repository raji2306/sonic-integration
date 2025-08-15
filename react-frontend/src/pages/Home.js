import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Link, useParams } from 'react-router-dom';

export default function Home() {
    const [users, setUsers] = useState([]);
    const { id } = useParams();

    useEffect(() => {
        loadUsers();
    }, []);

    const loadUsers = async () => {
        try {
            const result = await axios.get(`${process.env.REACT_APP_SPRING_BOOT_URL}/user-data`);
            setUsers(result.data);
        } catch (error) {
            // Handle errors here
            console.error(error);
        }
    };

    const deleteUser = async (id) => {
        try {
            await axios.delete(`${process.env.REACT_APP_SPRING_BOOT_URL}/user/${id}`);
            loadUsers();
        } catch (error) {
            // Handle errors here
            console.error(error);
        }
    };

    return (
        <div className='container'>
            <div class="py-4">
                <table className="table border shadow">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Name</th>
                            <th scope="col">UserName</th>
                            <th scope="col">Email</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        {
                            users.map((user, index) => (
                                <tr key={user.id}>
                                    <th scope="row">{index + 1}</th>
                                    <td>{user.name}</td>
                                    <td>{user.username}</td>
                                    <td>{user.email}</td>
                                    <td>
                                        <Link className="btn btn-primary mx-2" to={`/viewuser/${user.id}`}>View</Link>
                                        <Link className='btn btn-outline-primary mx-2' to={`/edituser/${user.id}`}>Edit</Link>
                                        <button className='btn btn-danger mx-2' onClick={() => deleteUser(user.id)}>Delete</button>
                                    </td>
                                </tr>
                            ))
                        }
                    </tbody>
                </table>
            </div>
        </div>
    );
}
