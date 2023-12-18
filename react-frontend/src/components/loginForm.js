import React , { useState } from "react";
import jwt_decode from "jwt-decode";



const login = async (info) => {
    try {

        // const res = await fetch('http://34.254.249.127:5000/login',{
        //     method: "POST",
        //     headers:{
        //         "Content-Type" : "application/json",
        //     },
        //     body: JSON.stringify(info)
        // });
        // const data = await res.json();
        // var token = data.token;

        // var decoded = jwt_decode(token);
        // console.log(decoded);
        // var id = decoded.user_id;

        // if(decoded.is_admin === 1){

        // localStorage.setItem("token",token)
        // localStorage.setItem("user_id",id);
        // console.log("Logged in succesfully");
        window.location.href= '/adminPanel'
    // }else {alert('this is only for admins')}
        
        
    } catch (error){
        console.log(error)
    }
};




const LoginPage = () => {

            
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    
    const onSubmit = (e) => {
        e.preventDefault();
        console.log(email, password)
        login({ email, password});
      };

    return ( 
        <form className="loginForm" onSubmit={onSubmit}>
            <div className="inputsWrapper">
                <h1 className="text">Lets Start The Burning</h1>
                <input placeholder="Email"
                value={email} onChange={(e)=>setEmail(e.target.value)}></input>
                <input placeholder="Password" value={password} onChange={(e)=>setPassword(e.target.value)}type="password"></input>
                <input type={"submit"} value="Login" className="loginButton" />
            </div> 
        </form>
    );

}

 
export default LoginPage;