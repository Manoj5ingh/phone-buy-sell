import React from "react";
import axios from "axios";
import {BrowserRouter, Switch, Route, Redirect} from "react-router-dom";
import Home from "./Home";
import Login from "./Login";
const HOME_URL = "/";
const LOGIN_URL = "/login";
class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = { 
      isLoggedIn: null,
      user: {}
     };
  }
  componentWillMount() {
  	console.log("yoyo Manoj")
    this.loginStatus();
  }
  loginStatus = () => {
    axios.get("/logged_in", {withCredentials: true})
    .then((response) => {
      if (response.data.logged_in) {
        this.handleLogin(response);
      } else {
        this.handleLogout();
      }
    });
  }
  handleLogin = (data) => {
    this.setState({
      isLoggedIn: true,
      user: data.user
    });
  }
  handleLogout = () => {
    this.setState({
    isLoggedIn: false,
    user: {}
    });
  }
  render() {
    return (
      <BrowserRouter>
        <Switch>
          <Route exact path={HOME_URL} render={() => {
            return(
                <Home handleLogout={this.handleLogout} loggedInStatus={this.state.isLoggedIn}/>
            );
          }} />
          <Route exact path={LOGIN_URL} render={() => {
            return (
                <Login handleLogin={this.handleLogin} loggedInStatus={this.state.isLoggedIn}/>
            );
          }} />
        </Switch>
        { this.state.isLoggedIn === true? <Redirect to={HOME_URL}/> : null }
        { this.state.isLoggedIn === false? <Redirect to={LOGIN_URL}/> : null }
      </BrowserRouter>
    );
  }
}
export default App;