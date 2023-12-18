import { Link } from "react-router-dom";
import '../styles/components.css'

const SideBar = () => {
    return ( 
        <div className="sideBar">
            <h2 className="text" >ADMIN PANEL</h2>
            <Link to='/adminPanel'>Add New System</Link>
            <Link to='viewSystems'>View All Systems</Link>
            <Link to='viewUsers'>View All Users</Link>
        </div>
    );
}
 
export default SideBar;