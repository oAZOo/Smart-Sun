
import React , { useState } from "react";

const createSystem = async (info,adminToken) => {
    try {
        const adminToken =localStorage.getItem('token');

        const res = await fetch("http://34.254.249.127:5000/admin/addSystem",{
            method: "POST",
            headers:{
                "Content-Type" : "application/json",
                "authorization": `Bearer ${adminToken}`,
            },
            body: JSON.stringify(info)
        });
        console.log(res)
        const data = await res.json();
        if(res.headers.status === 200) {
        console.log("System Added succesfully");
    }
    } catch (error){
        console.log(error)
    }
};

const AddSystem = () => {

    const [name, setName] = useState('');
    const [address, setAddress] = useState('');
    const [pvPowerRating , setPvPowerRating] = useState('');
    let [applianceName, setApplianceName] = useState('');
    const token = localStorage.getItem('token');

    let [appliances, setAppliances] = useState([]);


    const addAppliance = () => {
        setAppliances([...appliances,{
            name: applianceName}])
        console.log(appliances);
    }

    
    const Submit = () => {
        console.log(name, address)
        createSystem({ name, address, pvPowerRating, appliances }, token);
        window.location.href= 'adminPanel/viewSystems'
      };
    
    return ( 
        <div className="addSystem">
            <h1 className="pageTitle">Create New System</h1>
            <label>System Name</label>
            <input placeholder="System Name" onChange={(e)=>setName(e.target.value)}></input>
            <label>System Address</label>
            <input placeholder="System Address" onChange={(e)=>setAddress(e.target.value)}></input>
            <label>PV Power Rating (W)</label>
            <input placeholder="PV Power Rating (W)" onChange={(e)=>setPvPowerRating(e.target.value)}></input>
            <h2 className="pageTitle">Add Switches</h2>
            <label>Add Switch</label>
            <input placeholder="Switch Name" onChange={(e)=>setApplianceName(e.target.value)}></input>
            <p className="wrapper">
                {appliances.map((item)=>(<p>{item.name}</p>),)}
            </p>
            <button class="button" onClick={addAppliance}>Add Switch</button>
            <button class="button" onClick={Submit}>Create System</button>
        </div>
    );
}
 
export default AddSystem;