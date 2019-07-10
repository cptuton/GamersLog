<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
    <!-- Add code here -->
    <div id="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-12">
            <%
              String found;
              int count = 1;
              if(request.getParameter("start") != null && request.getParameter("start") != "") {
                  count = Integer.parseInt(request.getParameter("start"));
              }
              int total;
              if(request.getParameter("total") != null && request.getParameter("total") != "") {
                  total = Integer.parseInt(request.getParameter("total"));
              }
              else {
                  total = (int)request.getAttribute("total");
              }
              int end;
              if((count + 99) < total) {
                  end = count + 99;
              }
              else {
                  end = total;
              }
            %>
            <h1>Showing: <%=end%> out of <%=total%></h1><br>
            <%
                if(count != 1) {
            %>
            <div class="col-xs-6">
              <form id="requestLessForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="games">
                <input type="hidden" name="start" value="<%=count - 100%>">
                <input type="hidden" name="total" value="<%=total%>">
                <input type="hidden" name="username" value="<%=username%>">
                <input type="hidden" name="user" value="<%=request.getParameter("user")%>">
                <input id="form_submit" type="submit" value="Previous 100 Users">
              </form>
            </div>
            <%}%>
            <%
                if(end < total) {
            %>
            <div class="col-xs-6">
              <form id="requestMoreForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="games">
                <input type="hidden" name="start" value="<%=count + 100%>">
                <input type="hidden" name="total" value="<%=total%>">
                <input type="hidden" name="username" value="<%=username%>">
                <input type="hidden" name="user" value="<%=request.getParameter("user")%>">
                <input id="form_submit" type="submit" value="Next 100 Users">
              </form>
            </div>
            <%}%>
            <br><br>
            <div class="panel panel-default">
              <table class="table table-bordered">
                <thead id="head_bar">
                  <tr>
                    <th>Username</th>
                    <th>Profile Picture</th>
                    <th>Bio</th>
                  </tr>
                </thead>
                <tbody>
                  <%
                      while((found = (String)request.getAttribute(Integer.toString(count))) != null) {
                          UserInfo user = userInfo.getUser(found);
                  %>
                  <tr>
                    <td id="entry_medium"><%=user.getUsername()%></td>
                    <td id="entry_large" align="center"><img src="<%=user.getPicture()%>" alt="<%=user.getUsername()%>" id="entry_medium"></td>
                    <%
                        String bio;
                        if(user.getBio() == null || user.getBio().equals("") || user.getBio().equals("null")) {
                            bio = "This user did not enter any bio information.";
                        }
                        else {
                            bio = user.getBio();
                        }
                    %>
                    <td><%=bio%></td>
                  </tr>
                  <%count++;}%>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
