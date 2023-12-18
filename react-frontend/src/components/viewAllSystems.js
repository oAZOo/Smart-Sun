import { useState, useEffect } from 'react';
const ViewSystems = () => {


    const [solarData, setData] = useState([]);

    const getSystems = async () => {
        const adminToken =localStorage.getItem('token');

        try {
            const res = await fetch("http://34.254.249.127:5000/admin/allSystems",{
                method: "GET",
                headers:{
                    "Content-Type" : "application/json",
                    "authorization": `Bearer ${adminToken}`,
            },
        });
            const data = await res.json();
            setData(data)
        } catch (error) {
            console.log("error", error);
        }
    };
    useEffect(() => {    
        getSystems();
        
    }, []);
   
    return ( 
        <div className="viewSystems">
            <h1 className="pageTitle">View Systems</h1>
            <table className="allSystems table">
                <thead>
                    <th>System Id</th>
                    <th>System Name</th>
                    <th>Address</th>
                    <th>Power Rating (W)</th>
                </thead>
                <tbody>
                {solarData.map(soldata=>(<tr>
                    <td key={soldata._id}>{soldata._id}</td>
                    <td>{soldata.name}</td>
                    <td>{soldata.address}</td>
                    <td>{soldata.pv_power_rating}</td>
                </tr>))}       
                </tbody>         
            </table>
        </div>
     );
}
 
export default ViewSystems;