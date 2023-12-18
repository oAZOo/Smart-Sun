import Navbar from './components/navbar.js';
import LandingPage from './pages/landingPage.js';
import AdminLogin from './pages/adminLogin.js';
import AddSystem from './components/addSystem.js';
import ViewSystems from './components/viewAllSystems.js';
import ViewUsers from './components/viewAllUsers.js';
import { BrowserRouter, Route, Routes } from 'react-router-dom';

import AdminPanel from './pages/adminPanel.js';
const App = () => {
  return (
  <div className='App'>
      <BrowserRouter>
      <Navbar/>
        <Routes>
          <Route index element={<LandingPage/>}/>
          <Route path='adminLogin' element={<AdminLogin/>}/>
          <Route path='adminPanel' element={<AdminPanel/>}>
            <Route index element={<AddSystem/>}/>
            <Route path='viewSystems' element={<ViewSystems/>}/>
            <Route path='viewUsers' element={<ViewUsers/>}/>
          </Route>
          
        </Routes>
      </BrowserRouter>

  </div>
  );
}

export default App;
