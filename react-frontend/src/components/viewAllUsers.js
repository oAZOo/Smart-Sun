import { useState, useEffect } from 'react';



const ViewUsers = () => {
    const [solarData, setData] = useState([]);

    const getUsers = async () => {
        const adminToken =localStorage.getItem('token');
        try {
            const response = await fetch("http://34.254.249.127:5000/admin/allUsers",{
                method: "GET",
                headers:{
                    "Content-Type" : "application/json",
                    "authorization": `Bearer ${adminToken}`,
            },
        });

            const data = await response.json();
            setData(data)
        } catch (error) {
            console.log("error", error);
        }
    };
    useEffect(() => {    
        getUsers();
    },[]);
   
    return ( 
        <div className="viewUsers">
            <h1 className="pageTitle">View Users</h1>
            <table className="allUsers table">
                <thead>
                    <th>User Id</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone Number</th>
                </thead>
                <tbody>
                {solarData.map(soldata=>(<tr>
                    <td key={soldata.system_id}>{soldata._id}</td>
                    <td>{soldata.name}</td>
                    <td>{soldata.email}</td>
                    <td>{soldata.phone}</td>
                </tr>))}       
                </tbody>         
            </table>
        </div>
     );
}
 
export default ViewUsers;