<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<%
    String username = request.getParameter("username");
    String buffer = (String)request.getAttribute("username");
    UserInfo user = userInfo.getUser(username);
%>
<%@include file="header.jsp"%>
    <!-- Add code here -->
    <div id="content">
      <div class="container-fluid">
        <div class="row">
        <div class="col-xs-6">
          <div class="row" align="left">
            <%if(username != null && (buffer == null || buffer.equals(""))) {%>
            <h1>Edit Profile Information</h1>
            <br>
            <h4>Fill out any of the fields below to replace the fields of your profile information. Click "Submit Changes" once you are done editing your information.</h4>
            <br>
            <%}%>
            <%if(buffer != null && buffer.equals("error: password mismatch")) {%>
            <h2>Edit Profile Error: The passwords you entered don't match</h2>
            <h4>Please re-enter your information below</h4>
            <%}%>
            <%if(buffer != null && buffer.equals("error: username already in use")) {%>
            <h2>Edit Profile Error: The username you entered is already taken. Please select a different username</h2>
            <h4>Please re-enter your information below</h4>
            <%}%>
            <%if(buffer != null && buffer.equals("error: username is too long")) {%>
            <h1>Edit Profile Error: The username you entered is too long</h1> <br>
            <h4>Please select a username shorter than 16 characters long</h4> <br>
            <%}%>
            <%if(buffer != null && buffer.equals("error: password is too long")) {%>
            <h1>Edit Profile Error: The password you entered is too long</h1> <br>
            <h4>Please select a password shorter than 24 characters long</h4> <br>
            <%}%>
            <form id="changeUserForm" action="UserServlet" method="POST" enctype="multipart/form-data">
              <input type="hidden" name="action" value="submit_edit">
              <input type="hidden" name="username" value="<%=username%>">
              <table class="table">
                <tr>
                  <th><h4>Name</h4></th>
                  <th><input name="name" type="text" placeholder="<%=user.getName()%>"></th>
                </tr>
                <tr>
                  <th><h4>Username</h4></th>
                  <th><input name="user" type="text" size="16" placeholder="<%=user.getUsername()%>"></th>
                </tr>
                <tr>
                  <th><h4>Password</h4></th>
                  <th><input name="password" type="password" size="24" placeholder="<%=user.getPassword()%>"></th>
                </tr>
                <tr>
                  <th><h4>Confirm Password</h4></th>
                  <th><input name="confirm" type="password" size="24"></th>
                </tr>
                <tr>
                  <th><h4>Email</h4></th>
                  <th><input name="email" type="text"  placeholder="<%=user.getEmail()%>"></th>
                </tr>
                <tr>
                  <th><h4>Update Profile Picture</h4></th>
                  <!--<th><input type="file" name="pic" accept="image/*"></th>-->
                  <th><input type="checkbox" name="pic" value="update"> Get a new random profile picture</th>
                </tr>
                <tr>
                  <th><h4>Bio</h4></th>
                  <th><textarea name="bio" form="changeUserForm" style="min-width: 100%;min-height: 250px;" placeholder="<%=user.getBio()%>"></textarea></th>
                </tr>
              </table>
            <input id="form_submit" type="submit" value="Submit Changes">
          </form>
          </div>
        </div>
        </div>
      </div>
    </div>
  </body>
</html>