<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = (String)request.getAttribute("username");
    String buffer = username;
    if(username != null && (username.length() > 16)) {
        username = "";
    }
%>
<%@include file="header.jsp"%>
    <!-- Add code here -->
    <div id="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-xs-12 col-sm-6">
            <%if(username == null) {%>
            <h1>Login</h1> <br>
            <h4>Fill out the fields below with your username and password in order to login and view/update your account information. If you are a new user, use the "Register" button below to create an account. If you forgot your password, use the "Forgot Password" button below to be send an email with instructions on how to recover your password. Have fun gaming!</h4> <br>
            <%}%>
            <%if(username != null && buffer.equals("error: invalid credentials")) {%>
            <h1>Login Error: Invalid password combination</h1> <br>
            <h4>Please re-enter your credentials below</h4> <br>
            <%}%>
            <%if(username != null && buffer.equals("error: user does not exist")) {%>
            <h1>Login Error: User does not exist</h1> <br>
            <h4>Please register as a new user to use that username</h4> <br>
            <%}%>
            <%if(username != null && !buffer.equals("error: invalid credentials") && !buffer.equals("error: user does not exist")) {%>
            <h1>Login</h1> <br>
            <h4>You have been logged out. Fill out the fields below with your username and password in order to login and view/update your account information. If you are a new user, use the "Register" button below to create an account. If you forgot your password, use the "Forgot Password" button below to be send an email with instructions on how to recover your password. Have fun gaming!</h4> <br>
            <%}%>
          </div>
        </div>
        <div class="row">
          <div class="col-xs-12 col-sm-6">
            <form id="loginForm" action="UserServlet" method="POST">
                <input type="hidden" name="action" value="validate">
                <h4><strong>Username:</strong></h4>
                <input name="username" type="text" size="24" required /> <br><br>
                <h4><strong>Password:</strong></h4>
                <input name="password" type="password" size="24" required /> <br><br>
                <div align="right">
                <input id="form_submit" type="submit" value="Login">
                </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>