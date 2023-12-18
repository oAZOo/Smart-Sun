import LoginButton from "./buttons/loginButton";
import '../styles/components.css';

const Navbar = () => {
    return ( 
        <div className="navBar">
            <h1 className="navBarr">SMART SUN CONTROLLER</h1>
            <LoginButton/>
        </div>
     );
}
 
export default Navbar;