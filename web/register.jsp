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
            <h1>Register</h1>
            <br>
            <h4>Fill out the fields below with a chosen username and password in order to register for an account.</h4>
            <br>
            <%}%>
            <%if(username != null && buffer.equals("error: password mismatch")) {%>
            <h2>Registration Error: The passwords you entered don't match</h2>
            <h4>Please re-enter your information below</h4>
            <%}%>
            <%if(username != null && buffer.equals("error: username already in use")) {%>
            <h2>Registration Error: The username you entered is already taken. Please select a different username</h2>
            <h4>Please re-enter your information below</h4>
            <%}%>
            <%if(username != null && buffer.equals("error: username is too long")) {%>
            <h1>Registration Error: The username you entered is too long</h1> <br>
            <h4>Please select a username shorter than 16 characters long</h4> <br>
            <%}%>
            <%if(username != null && buffer.equals("error: password is too long")) {%>
            <h1>Registration Error: The password you entered is too long</h1> <br>
            <h4>Please select a password shorter than 24 characters long</h4> <br>
            <%}%>
          </div>
        </div>
        <div class="row">
          <div class="col-xs-12 col-sm-6">
            <form id="registerForm" action="UserServlet" method="POST">
                <input type="hidden" name="action" value="new_user">
                <h2>Necessary Information</h2> <br>
                <h4><strong>Name:</strong> Enter your real name. This will not be displayed to other users</h4>
                <input name="name" type="text" required /> <br><br>
                <h4><strong>Email:</strong> Enter your email. This will not be displayed to other users</h4>
                <input name="email" type="text" required /> <br><br>
                <h4><strong>Age:</strong> Enter your age. This will not be displayed to other users</h4>
                <input name="age" type="number" required /> <br><br>
                <h4><strong>Username:</strong> Choose a username less than 16 characters long. This is the name that will be displayed to other users and will be required for when you login.</h4>
                <input name="username" type="text" size="16" required /> <br><br>
                <h4><strong>Password:</strong> Choose a password less than 24 characters long.</h4>
                <input name="password" type="password" size="24" required /> <br><br>
                <h4><strong>Confirm Password:</strong></h4>
                <input name="confirm" type="password" size="24" required /> <br><br>
                <h2>Optional Information</h2> <br>
                <h4><strong>Profile Picture:</strong> Select a profile picture that will be displayed with your profile information.</h4>
                <br>
                <h4><strong>Personal Bio:</strong> Write a synopsis of yourself that will be displayed with your profile information.</h4>
                <input type="text" name="bioText"><br><br>
                <input id="form_submit" type="submit" value="Register">
            </form>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>