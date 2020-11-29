import React from 'react';
import axios from 'axios'
import {Link, BrowserRouter as Router, Route, Switch} from 'react-router-dom'
import Signup from "./Signup";
import Login from "./Login";
const Home = (props) => {
const handleClick = () => {
    axios.delete('/logout', {withCredentials: true})
    .then(response => {
      props.handleLogout()
      props.history.push('/')
    })
    .catch(error => console.log(error))
  }
return (
   
    <Router>
      <Switch>
        <Route
          path="/login"
          render={(props) => (
            <Login {...props} ref={this.child} />
          )}
        />
        <Route
          path="/signup"
          render={(props) => <Signup/>}
        />
      </Switch>
      <Link to='/login'>Log In</Link>
      <br></br>
      <Link to='/signup'>Sign Up</Link>
      <br></br>
      { 
        props.loggedInStatus ? 
        <Link to='/logout' onClick={handleClick}>Log Out</Link> : 
        null
      }
    </Router>
  );
};
export default Home;