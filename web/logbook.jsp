<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="logbook" class="beans.Logbook" scope="request"/>
<jsp:useBean id="gameInfo" class="beans.GameInfo" scope="request"/>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
    <!-- Add code here -->
    <div id="content">
      <div class="container-fluid">
        <div class="row">
          <h1>Logbook</h1><br>
          <div class="col-xs-12">
            <div class="panel panel-default" id="large_table">
              <table class="table table-bordered">
                <thead id="head_bar">
                  <tr>
                    <th id="entry_medium_center">Action</th>
                    <th id="entry_medium_center">Title</th>
                    <th id="entry_medium_center">Image</th>
                    <th id="entry_medium_center">Rating</th>
                    <th id="entry_medium_center">Status</th>
                    <th id="entry_medium_center">Times Played</th>
                    <th id="entry_medium_center">100% Completion</th>
                    <th id="entry_medium_center">Favorite</th>
                    <th id="entry_medium_center">Date Finished</th>
                  </tr>
                </thead>
                <tbody>
                  <%
                      int logid = 1;
                      Logbook log = (Logbook) logbook.getLog(logid);
                      while(log != null) {
                          GameInfo game = (GameInfo) gameInfo.getGameById(log.getGameId());
                          /* continue if the username does not match or the game doesn't exist */
                          if(!username.equals(log.getUsername()) || game == null) {
                              logid++;
                              log = (Logbook) logbook.getLog(logid);
                              continue;
                          }
                          String title = game.getTitle();
                          String rating = "";
                          String label = "";
                          switch(log.getScore()) {
                              case 1:
                                  rating = "rating_appalling";
                                  label = "Appalling";
                                  break;
                              case 2:
                                  rating = "rating_terrible";
                                  label = "Terrible";
                                  break;
                              case 3:
                                  rating = "rating_bad";
                                  label = "Bad";
                                  break;
                              case 4:
                                  rating = "rating_meh";
                                  label = "Meh";
                                  break;
                              case 5:
                                  rating = "rating_okay";
                                  label = "Okay";
                                  break;
                              case 6:
                                  rating = "rating_good";
                                  label = "Good";
                                  break;
                              case 7:
                                  rating = "rating_great";
                                  label = "Great";
                                  break;
                              case 8:
                                  rating = "rating_fantastic";
                                  label = "Fantastic";
                                  break;
                              case 9:
                                  rating = "rating_masterpiece";
                                  label = "Masterpiece";
                                  break;
                              case 10:
                                  rating = "rating_legendary";
                                  label = "Legendary";
                                  break;
                              default:
                                  rating = "rating_unknown";
                                  label = "Unknown";
                          }
                          String status = "";
                          String check = "";
                          switch(log.getStatus()) {
                              case 1:
                                  status = "Currently Playing";
                                  check = "images/check_empty.png";
                                  break;
                              case 2:
                                  status = "On Hold";
                                  check = "images/check_empty.png";
                                  break;
                              case 3:
                                  status = "Plan to Play";
                                  check = "images/check_empty.png";
                                  break;
                              case 4:
                                  status = "Dropped";
                                  check = "images/check_empty.png";
                                  break;
                              case 5:
                                  status = "Completed";
                                  check = "images/check_empty.png";
                                  break;
                              case 6:
                              	  status = "100% Completed";
                              	  check = "images/check_full.png";
                                  break;
                              default:
                                  status = "Unknown";
                                  check = "images/check_empty.png";
                          }
                          int timesPlayed = log.getTimesPlayed();
                          String comments = log.getComments();
                          String star = "";
                          if(log.getIsFavorite() == 1) {
                              star = "images/star_full.png";
                          }
                          else {
                              star = "images/star_empty.png";
                          }
                          Date date = log.getDateAdded();
                  %>
                  <tr>
                    <!--<td rowspan="1" id="entry_medium_center"><a>Edit</a>/<a>Remove</a></td>-->
                    <td rowspan="1" id="entry_medium_center">
                    <form action="GameServlet" method="POST" id="rmgame">
                              <input type="hidden" name="action" value="remove_game">
                              <input type="hidden" name="gameid" value="<%=log.getGameId()%>">
                              <input type="hidden" name="username" value="<%=username%>">
                              <a href ="#" onclick="getElementById('rmgame').submit()">remove</a>
                    </form>
                    </td>
                    <td id="entry_medium_center">
                          <form action="GameServlet" method="POST" id="gotogame<%=logid%>">
                              <input type="hidden" name="action" value="game">
                              <input type="hidden" name="gameid" value="<%=log.getGameId()%>">
                              <input type="hidden" name="username" value="<%=username%>">
                              <a href ="#" onclick="getElementById('gotogame<%=logid%>').submit()"><%=title%></a>
                          </form>
                    </td>
                    <td id="entry_medium_center"><img width="100%" src="<%=game.getImage()%>" alt="<%=game.getTitle()%>" id="entry_medium"/></td>
                    <td id="entry_medium_center"><span id="<%=rating%>"><%=label%></span></td>
                    <td id="entry_medium_center"><%=status%></td>
                    <td id="entry_medium_center"><%=timesPlayed%></td>
                    <td id="entry_medium_center"><img src="<%=check%>" width="24px"></td>
                    <td id="entry_medium_center"><img src="<%=star%>" width="24px"></td>
                    <td id="entry_medium_center"><%=date%></td>
                  </tr>
                  <%if (comments != null && !comments.equals("")) {%>
                  <tr>
                      <td colspan="9" id="entry_medium"><h4><strong>Comments: </strong><%=comments%></h4></td>
                  </tr>
                  <%} else {%> <td colspan="9" id="entry_medium"></td> <%}%>
                  <%
                        logid++;
                        log = (Logbook) logbook.getLog(logid);
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
