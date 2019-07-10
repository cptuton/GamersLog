<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="gameInfo" class="beans.GameInfo" scope="request"/>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
    <!-- Add code here -->
    <div id="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-12">
            <%
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
                <input type="hidden" name="title" value="<%=request.getParameter("title")%>">
                <input type="hidden" name="publisher" value="<%=request.getParameter("publisher")%>">
                <input type="hidden" name="studio" value="<%=request.getParameter("studio")%>">
                <input type="hidden" name="platform" value="<%=request.getParameter("platform")%>">
                <input type="hidden" name="min_score" value="<%=request.getParameter("min_score")%>">
                <input type="hidden" name="max_score" value="<%=request.getParameter("max_score")%>">
                <input id="form_submit" type="submit" value="Previous 100 Games">
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
                <input type="hidden" name="title" value="<%=request.getParameter("title")%>">
                <input type="hidden" name="publisher" value="<%=request.getParameter("publisher")%>">
                <input type="hidden" name="studio" value="<%=request.getParameter("studio")%>">
                <input type="hidden" name="platform" value="<%=request.getParameter("platform")%>">
                <input type="hidden" name="min_score" value="<%=request.getParameter("min_score")%>">
                <input type="hidden" name="max_score" value="<%=request.getParameter("max_score")%>">
                <input id="form_submit" type="submit" value="Next 100 Games">
              </form>
            </div>
            <%}%>
            <br><br><br>
            <div class="panel panel-default">
              <table class="table table-bordered">
                <thead id="head_bar">
                  <tr>
                    <th>Number</th>
                    <th>Title</th>
                    <th>Image</th>
                    <th>Description</th>
                    <th>Score</th>
                    <th>Members</th>
                    <th>Rating</th>
                    <th>Platform</th>
                  </tr>
                </thead>
                <tbody>
                  <%
                      int id;
                      while(count <= end) {
                          id = (int)request.getAttribute(Integer.toString(count));
                          GameInfo game = gameInfo.getGameById((int)request.getAttribute(Integer.toString(count)));
                          if(game == null) {
                              break;
                          }
                  %>
                  <tr>
                    <td id="entry_small"><%=count%></td>
                    <td id="entry_medium">
                        <form id="gameForm<%=count%>" action="GameServlet" method="POST">
                            <input type="hidden" name="action" value="game">
                            <input type="hidden" name="username" value="<%=username%>">
                            <input type="hidden" name="gameid" value="<%=game.getId()%>">
                            <a href="#" align="center" onclick="document.getElementById('gameForm<%=count%>').submit();"><%=game.getTitle()%></a>
                        </form>
                    </td>
                    <td id="entry_medium"><img src="<%=game.getImage()%>" alt="No game image" id="entry_medium"/></td>
                    <td>
                      <%
                        if(game.getDescription() == null) {
                            %>No game description.<%
                        }
                        else if(game.getDescription().length() < 500) {
                            %><%=game.getDescription()%><%
                        }
                        else {
                            %><%=game.getDescription().substring(0, 500)%>...<%
                        }
                      %>
                    </td>
                    <td id="entry_medium"><%=game.getScore()%></td>
                    <td id="entry_medium"><%=game.getMembers()%></td>
                    <td id="entry_medium"><img src="<%=game.getEsrb()%>" alt="Unknown ESRB rating" id="entry_medium"/></td>
                    <td id="entry_large"><%=game.getPlatform()%></td>
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
