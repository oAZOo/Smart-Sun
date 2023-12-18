import '../../styles/buttons.css'
import { useNavigate } from 'react-router-dom';

const LoginButton = () => {
    const navigate = useNavigate();

  const navigateToLogin = () => {
    navigate('/adminLogin');
    logout()
  };
    
  const logout = () => {
    localStorage.setItem('token', '');
    localStorage.setItem('user_id', '');

  }
  
    let auth = {'token':localStorage.getItem('token')}
    return ( 
      auth.token ?
        <div className="loginButton" onClick={navigateToLogin}>
            <p>Logout</p>
        </div>
        :
    <div className="loginButton" onClick={navigateToLogin}>
        <p>Login</p>
    </div>
    );
}
 
export default LoginButton;