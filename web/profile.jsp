<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<jsp:useBean id="logInfo" class="beans.Logbook" scope="request"/>
<jsp:useBean id="gameInfo" class="beans.GameInfo" scope="request"/>
<%
    String username;
    if((String)request.getAttribute("username") == null) {
        username = request.getParameter("username");
    }
    else {
        username = (String)request.getAttribute("username");
    }
%>
<%@include file="header.jsp"%>
<%UserInfo user = userInfo.getUser(username);%>
    <!-- Add code here -->
    <div id="content">
      <div class="container-fluid">
        <div class="col-xs-12">
            <h1>Profile</h1></br>
            <div class="col-xs-12 col-sm-3">
                <h2>Profile Picture:</h2><br>
                <h4>
                <img width="100%" src="<%=user.getPicture()%>" alt="<%=user%>" id="center_img"></img>
                <br><br>
                <form id="editForm" action="GameServlet" method="POST">
                  <input type="hidden" name="action" value="edit_profile">
                  <input type="hidden" name="username" value="<%=username%>">
                  <input id="form_submit" type="submit" value="Edit Information">
                </form>
                <br>
                <form id="logbookForm2" action="GameServlet" method="POST">
                  <input type="hidden" name="action" value="logbook">
                  <input type="hidden" name="username" value="<%=username%>">
                  <input id="form_submit" type="submit" value="Logbook">
                </form>
                </h4>
            </div>
            <div class="col-xs-12 col-sm-1"></div>
            <div class="col-xs-12 col-sm-8">
                <h2>Profile Information:</h2><br>
                <h4>
                <div class="row">
                  <div class="col-xs-3">
                    <div class="row">
                      <span id="strong">Name:</span>
                    </div>
                  </div>
                  <div class="col-xs-9">
                    <div class="row">
                      <%=user.getName()%>
                    </div>
                  </div>
                  <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                  <div class="col-xs-3">
                    <div class="row">
                      <span id="strong">Username:</span>
                    </div>
                  </div>
                  <div class="col-sx-9">
                    <div class="row">
                      <%=user.getUsername()%>
                    </div>
                  </div>
                  <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                  <div class="col-xs-3">
                    <div class="row">
                      <strong>Email:</strong>
                    </div>
                  </div>
                  <div class="col-xs-9">
                    <div class="row">
                      <%=user.getEmail()%>
                    </div>
                  </div>
                  <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                  <div class="col-xs-3">
                    <div class="row">
                      <span id="strong">Age:</span>
                    </div>
                  </div>
                  <div class="col-xs-9">
                    <div class="row">
                      <%=user.getAge()%>
                    </div>
                  </div>
                  <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                  <div class="col-xs-3">
                    <div class="row">
                      <span id="strong">Bio:</span>
                    </div>
                  </div>
                  <div class="col-xs-9">
                    <div class="row">
                      <%=user.getBio()%>
                    </div>
                  </div>
                </div>
                <div class="col-xs-12"><br></div>
                </h4>
            </div>
            <div class="col-xs-12">
                <h2>Favorites</h2><br>
                <div class="panel panel-default" id="large_table">
                  <table class="table table-bordered">
                    <thead id="head_bar">
                    <tr>
                      <th>Name</th>
                      <th>Image</th>
                      <th>Score</th>
                      <th>Platform</th>
                    </tr>
                    </thead>
                      <%
                        int logSize = (int) logInfo.getLogbookSize();
                        int logid = 1;
                        boolean foundGame = false;
                        while(logid <= logSize) {
                            Logbook entry = (Logbook) logInfo.getLog(logid);
                            if((entry == null) && (foundGame == false) && (logid == logSize)) {
                                %>No favorites!<%
                                break;
                            }
<<<<<<< HEAD
                            if (entry == null) {
                                logid++;
                                continue;
                            }
                            %>Final debugging<br><%
                            if (username.equals(entry.getUsername())) {
                                %>User found<br><%
                                if (entry.getIsFavorite() != 1) {
                                    %>Not a Favorite!<br><%
                                    logid++;
                                    continue;
                                }
                                foundGame = true;
                            }
=======
                            if ((entry == null) || (entry.getIsFavorite() == 0) || (!entry.getUsername().equals(username))) {
                                logid++;
                                continue;
                            }
                            foundGame = true;
>>>>>>> master
                            GameInfo game = (GameInfo) gameInfo.getGameById(entry.getGameId());
                      %>
                    <tr>
                        <td id="entry_medium">
                            <form id="gameForm<%=logid%>" action="GameServlet" method="POST">
                                <input type="hidden" name="action" value="game">
                                <input type="hidden" name="username" value="<%=username%>">
                                <input type="hidden" name="gameid" value="<%=game.getId()%>">
                                <a href="#" align="center" onclick="document.getElementById('gameForm<%=logid%>').submit();"><%=game.getTitle()%></a>
                            </form>
                        </td>
                        <td id="entry_medium"><img src="<%=game.getImage()%>" alt="<%=game.getTitle()%>" id="entry_medium"/></td>
                        <td id="entry_medium_center"><span id="<%=entry.getScoreName()[0]%>"><%=entry.getScoreName()[1]%></span></td>
                        <td id="entry_large"><%=game.getPlatform()%></td>
                        <td id="entry_large"><%=entry.getIsFavorite()%></td>
                    </tr>
                    <%logid++;}%>
                        </tbody>
                      </table>
                </div>
            </div>
        </div>
      </div>
    </div>
  </body>
</html>
