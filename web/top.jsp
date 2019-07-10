<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="topGame" class="beans.TopGame" scope="request"/>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
    <!-- Add code here -->
    <div id="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-12">
            <h1>Top Rated Games</h1><br>
            <div class="panel panel-default">
              <table class="table table-bordered">
                <thead id="head_bar">
                  <tr>
                    <th>Rank</th>
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
                        int rank = 1;
                        while(rank <= 50) {
                            TopGame game = (TopGame) topGame.getGame(rank);
                            if(game == null) {
                                %>No games!<%
                                break;
                            }
                    %>
                    <tr>
                        <td id="entry_small"><%=rank%></td>
                        <td id="entry_medium">
                            <form id="gameForm<%=rank%>" action="GameServlet" method="POST">
                                <input type="hidden" name="action" value="game">
                                <input type="hidden" name="username" value="<%=username%>">
                                <input type="hidden" name="gameid" value="<%=game.getId()%>">
                                <a href="#" align="center" onclick="document.getElementById('gameForm<%=rank%>').submit();"><%=game.getTitle()%></a>
                            </form>
                        </td>
                        <td id="entry_medium"><img src="<%=game.getImage()%>" alt="<%=game.getTitle()%>" id="entry_medium"/></td>
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
                        <td id="entry_medium"><img src="<%=game.getEsrb()%>" alt="No game image" id="entry_medium"/></td>
                        <td id="entry_large"><%=game.getPlatform()%></td>
                    </tr>
                    <%rank++;}%>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
