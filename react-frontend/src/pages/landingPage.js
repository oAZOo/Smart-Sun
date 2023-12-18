import image from '../images/appScreenshot.png'
import '../styles/pages.css'

const LandingPage = () => {
    return ( 
        <div className="landingPage">
            <div className="textBoxesWrapper">
                <div className="aboutUs">
                    <h2 className="text">ABOUT US:</h2>
                    <ul>
                        <li className="text">Lebanese Startup, looking to optimize the use of clean energy and make it affordable for everyone.</li> 
                    </ul>

                    <ul>
                        <li className="text"> Our goal is to let you benefit from the middle and small sized solar systems during the day so you can save the power stored in your  battery bank for the night time.</li>  
                    </ul>
                </div>
                <div className='howItWorks'>
                    <h2 className="text">HOW IT WORKS ?</h2>
                    <p className="text">It is an independent component that can be connected to any system and helps you monitor and control your consumption remotely from our mobile app. </p>
                </div>
            </div>
            <div className="mobileScreenshot">
                <img src={image} width="555"/>
            </div>
        </div>
    );
}
 
export default LandingPage;