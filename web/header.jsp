<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gamer's Log</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <form id="searchForm" action="SearchServlet" method="POST">
        <input type="hidden" name="action" value="search">
        <input type="hidden" name="username" value="<%=username%>">
    </form>
  </head>
  <body>
    <div id="menu">
      <nav class="navbar">
        <div class="container-fluid">
          <div class="navbar-header">
            <ul class="nav navbar-nav">
              <li>
                <form id="indexForm" action="GameServlet" method="POST">
                    <input type="hidden" name="action" value="index">
                    <input type="hidden" name="username" value="<%=username%>">
                    <a href="#" onclick="document.getElementById('indexForm').submit();">
                        <img id="logo" src="images/gamersloglogo.png" alt="Gamer's Log">
                        <!--<h2>Gamer's Log</h2>-->
                    </a>
                </form>
              </li>
              <li>
                  <br>
              </li>
              <li class="dropdown" id="menu_item">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><h4><br>Games</h4></a>
                <ul class="dropdown-menu" id="dropdown">
                  <li>
                      <form id="topForm" action="GameServlet" method="POST">
                        <input type="hidden" name="action" value="top">
                        <input type="hidden" name="username" value="<%=username%>">
                        <input id="menu_submit" type="submit" value="Top Rated Games">
                      </form>
                  </li>
                  <li>
                      <form id="popularForm" action="GameServlet" method="POST">
                        <input type="hidden" name="action" value="popular">
                        <input type="hidden" name="username" value="<%=username%>">
                        <input id="menu_submit" type="submit" value="Popular Games">
                      </form>
                  </li>
                </ul>
              </li>
              <li class="dropdown" id="menu_item">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><h4><br>Me</h4></a>
                <ul class="dropdown-menu" id="dropdown">
                  <%
                      if(username == null || username.equals("") || username.equals("null")) {
                  %>
                    <li>
                        <form id="loginForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="login">
                            <input id="menu_submit" type="submit" value="Login">
                        </form>
                    </li>
                    <li>
                        <form id="registerForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="register">
                            <input id="menu_submit" type="submit" value="Register">
                        </form>
                    </li>
                  <%
                      } else {
                  %>
                    <li>
                        <form id="logbookForm" action="GameServlet" method="POST">
                            <input type="hidden" name="action" value="logbook">
                            <input type="hidden" name="username" value="<%=username%>">
                            <input id="menu_submit" type="submit" value="Logbook">
                        </form>
                    </li>
                    <li>
                        <form id="profileForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="profile">
                            <input type="hidden" name="username" value="<%=username%>">
                            <input id="menu_submit" type="submit" value="Profile">
                        </form>
                    </li>
                    <li>
                        <form id="logoutForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="logout">
                            <input id="menu_submit" type="submit" value="Logout">
                        </form>
                    </li>
                  <%}%>
                </ul>
              </li>
              <li class="dropdown" id="menu_item">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><h4><br>Help</h4></a>
                <ul class="dropdown-menu" id="dropdown">
                    <li>
                        <form id="aboutForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="about">
                            <input type="hidden" name="username" value="<%=username%>">
                            <input id="menu_submit" type="submit" value="About">
                        </form>
                    </li>
                    <li>
                        <form id="contactForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="contact">
                            <input type="hidden" name="username" value="<%=username%>">
                            <input id="menu_submit" type="submit" value="Contact">
                        </form>
                    </li>
                    <li>
                        <form id="problemForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="problem">
                            <input type="hidden" name="username" value="<%=username%>">
                            <input id="menu_submit" type="submit" value="Problem?">
                        </form>
                    </li>
                </ul>
              </li>
              <li class="dropdown" id="menu_item">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" onclick="document.getElementById('searchForm').submit();"><h4><br>Search</h4></a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </div>
