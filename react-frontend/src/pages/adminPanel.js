import SideBar from "../components/sideBar";
import { Outlet, Navigate} from 'react-router-dom';


const AdminPanel = () => {
    // let auth = {'token':localStorage.getItem('token')}
    return ( 
        // auth.token ?
        <div className="adminPanel">
            <SideBar/>
            <Outlet/>
        </div> 
        
        
        // : <Navigate to='/'/>
     );
}
 
export default AdminPanel;