<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String username = (String)request.getAttribute("username");%>
<jsp:useBean id="recentGame" class="beans.RecentGame" scope="request"/>
<jsp:useBean id="recentLogbook" class="beans.RecentLogbook" scope="request"/>
<jsp:useBean id="recentReview" class="beans.RecentReview" scope="request"/>
<jsp:useBean id="gameInfo" class="beans.GameInfo" scope="request"/>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<%@include file="header.jsp"%>
<!-- Add code here -->
<%
    Exception ex = (Exception)request.getAttribute("error");
    if(ex != null) {
        %>ERROR! Stacktrace: <%=ex%><%
    }
    int rank;
    int cap = 50;
%>
<div id="content">
  <div class="container-fluid">
    <div class="row" align="left">
      <div class="col-md-12 col-lg-4">
        <h1>Recently Added Games</h1><br>
        <div class="panel panel-default" align="center">
            <table class="table table-bordered">
                <thead id="head_bar">
                  <tr>
                    <th>Title</th>
                    <th>Image</th>
                    <th>Score</th>
                    <th>Members</th>
                  </tr>
                </thead>
                <tbody>
                    <%
                        rank = 1;
                        RecentGame recent = (RecentGame) recentGame.getGame(rank);
                        while(rank <= cap && recent != null) {
                    %>
                    <tr>
                        <td id="entry_small">
                            <form id="gameForm<%=rank%>" action="GameServlet" method="POST">
                                <input type="hidden" name="action" value="game">
                                <input type="hidden" name="username" value="<%=username%>">
                                <input type="hidden" name="gameid" value="<%=recent.getId()%>">
                                <a href="#" align="center" onclick="document.getElementById('gameForm<%=rank%>').submit();"><%=recent.getTitle()%></a>
                            </form>
                        </td>
                        <td id="entry_medium"><img src="<%=recent.getImage()%>" alt="No game image" id="entry_medium"/></td>
                        <td id="entry_medium"><%=recent.getScore()%></td>
                        <td id="entry_medium"><%=recent.getMembers()%></td>
                    </tr>
                    <%
                            rank++;
                            recent = (RecentGame) recentGame.getGame(rank);
                        }
                    %>
                </tbody>
            </table>
        </div>
      </div>
      <div class="col-md-12 col-lg-4">
        <h1>Recently Logged Games</h1><br>
        <div class="panel panel-default" align="center">
            <table class="table table-bordered">
                <thead id="head_bar">
                  <tr>
                    <th>Title</th>
                    <th>Image</th>
                    <th>Score</th>
                    <th>Members</th>
                  </tr>
                </thead>
                <tbody>
                    <%
                        rank = 1;
                        RecentLogbook log = (RecentLogbook) recentLogbook.getLog(rank);
                        while(rank <= cap && log != null) {
                            GameInfo game = (GameInfo) gameInfo.getGameById(log.getGameId());
                    %>
                    <tr>
                        <td id="entry_medium">
                            <form id="logForm<%=rank%>" action="GameServlet" method="POST">
                                <input type="hidden" name="action" value="game">
                                <input type="hidden" name="username" value="<%=username%>">
                                <input type="hidden" name="gameid" value="<%=log.getGameId()%>">
                                <a href="#" align="center" onclick="document.getElementById('logForm<%=rank%>').submit();"><%=game.getTitle()%></a>
                            </form>
                        </td>
                        <td id="entry_medium"><img src="<%=game.getImage()%>" alt="No game image" id="entry_medium"/></td>
                        <td id="entry_medium"><%=game.getScore()%></td>
                        <td id="entry_medium"><%=game.getMembers()%></td>
                    </tr>
                    <%
                          rank++;
                          log = (RecentLogbook) recentLogbook.getLog(rank);
                        }
                    %>
                </tbody>
            </table>
        </div>
      </div>
      <div class="col-md-12 col-lg-4">
        <h1>Recent Reviews</h1><br>
        <div class="panel panel-default" align="left">
            <table class="table table-bordered">
                <thead id="head_bar">
                  <tr>
                    <th>Title</th>
                    <th>Image</th>
                    <th>Review</th>
                  </tr>
                </thead>
                <tbody>
                    <%
                      rank = 1;
                      RecentReview review = (RecentReview) recentReview.getReview(rank);
                      while(rank <= cap && review != null) {
                          String user = review.getUsername();
                          String content = review.getReview();
                          GameInfo game = gameInfo.getGameById(review.getGameId());
                          UserInfo reviewer = userInfo.getUser(review.getUsername());
                          String picture = reviewer.getPicture();
                          if(picture == null) {
                              picture = "images/blank_user.jpg";
                          }
                    %>
                  <tr>
                    <td id="entry_medium">
                        <form id="reviewForm<%=rank%>" action="GameServlet" method="POST">
                            <input type="hidden" name="action" value="game">
                            <input type="hidden" name="username" value="<%=username%>">
                            <input type="hidden" name="gameid" value="<%=review.getGameId()%>">
                            <a href="#" align="center" onclick="document.getElementById('reviewForm<%=rank%>').submit();"><%=game.getTitle()%></a>
                        </form>
                    </td>
                    <td id="entry_medium"><img src="<%=game.getImage()%>" alt="No game image" id="entry_medium"/></td>
                    <td><%=content%></td>
                  </tr>
                  <%
                        rank++;
                        review = (RecentReview) recentReview.getReview(rank);
                      }
                  %>
                </tbody>
            </table>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
