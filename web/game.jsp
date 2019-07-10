<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="gameInfo" class="beans.GameInfo" scope="request"/>
<jsp:useBean id="reviewInfo" class="beans.ReviewInfo" scope="request"/>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<%GameInfo game = (GameInfo) gameInfo.getGameById(Integer.parseInt(request.getParameter("gameid")));%>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
    <!-- Add code here -->
    <div id="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-xs-12 col-sm-4">
            <div class="row" align="left">
                <h1>Title: <%=game.getTitle()%></h1></br>
            </div>
            <div class="row" align="left">
                <img width="100%" src="<%=game.getImage()%>"></img><br><br>
                <form id="addForm" action="GameServlet" method="POST">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="username" value="<%=username%>">
                    <input type="hidden" name="gameid" value="<%=Integer.parseInt(request.getParameter("gameid"))%>">
                    <input type="submit" value="Add to Log" id="form_submit" align="center">
                </form>
                <br><br>
                <div align="left">
                  <div class="panel panel-default">
                    <table class="table table-bordered">
                        <%
                            float score = 0;
                            String platform = "";
                            String players = "";
                            String modes = "";
                            String genres = "";
                            if(game.getScore() != 0.0) {
                                score = game.getScore();
                            }
                            if(game.getPlatform() == null) {
                                platform = "No Platform";
                            }
                            else {
                                platform = game.getPlatform();
                            }
                            if(game.getModes() == null) {
                                modes = "Unknown";
                            }
                            else {
                                modes = game.getModes();
                            }
                            if(game.getGenres() == null) {
                                genres = "No Genres";
                            }
                            else {
                                genres = Boolean.toString(game.getGenres());
                            }
                            String rating = "";
                            String label = "";
                            switch((int)score) {
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
                                    label = "Masterpeice";
                                    break;
                                case 10:
                                    rating = "rating_legendary";
                                    label = "Legendary";
                                    break;
                                default:
                                    rating = "rating_unrated";
                                    label = "Unrated";
                            }
                            String publisher = game.getPublisher();
                            String developer = game.getDeveloper();
                        %>
                      <tr>
                        <td><h4><strong>ESRB Rating:</strong></h4></td><td><img src="<%=game.getEsrb()%>" width="90px" align="center"/></td>
                      </tr>
                      <tr>
                        <td><h4><strong>Score:</strong></h4></td><td><h4><%=score%></h4></td>
                      </tr>
                      <tr>
                        <td><h4><strong>Rating:</strong></h4></td><td><h4><span id="<%=rating%>"><%=label%></span></h4></td>
                      </tr>
                      <tr>
                        <td><h4><strong>Platform:</strong></h4></td><td><h4><%=platform%></h4></td>
                      </tr>
                      <tr>
                        <td><h4><strong>Players:</strong></h4></td><td><h4><%=modes%></h4></td>
                      </tr>
                      <tr>
                        <td><h4><strong>Publisher:</strong></h4></td><td><h4><%=publisher%></h4></td>
                      </tr>
                      <tr>
                        <td><h4><strong>Developer:</strong></h4></td><td><h4><%=developer%></h4></td>
                      </tr>
                    </table>
                  </div>
                </div>
            </div>
          </div>
          <div class="col-xs-12 col-sm-8">
            <div class="row">
              <div class="col-xs-1"></div>
              <div class="col-xs-9">
                  <h1>Game Description</h1>
                  <br>
                  <h4>
                    <%=game.getDescription()%>
                  </h4>
                  <br>
                  <h1>Reviews</h1><br>
                    <%
                      int reviewid = 1;
                      int reviewCount = 0;
                      while(true) {
                          ReviewInfo review = (ReviewInfo) reviewInfo.getReview(reviewid);
                          if(review == null) {
                              if(reviewCount == 0) {
                                  %><br><h4>There are no reviews for this game. Be the first to write one!</h4><%
                              }
                              break;
                          }
                          if(review.getGameId() != game.getId()) {
                              reviewid++;
                              continue;
                          }
                          String user = review.getUsername();
                          Date dateAdded = review.getDateAdded();
                          rating = "";
                          label = "";
                          switch(review.getScore()) {
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
                                  label = "Masterpeice";
                                  break;
                              case 10:
                                  rating = "rating_legendary";
                                  label = "Legendary";
                                  break;
                              default:
                                  rating = "rating_unrated";
                                  label = "Unrated";
                          }
                          String content = review.getReview();
                          int likes = review.getLikes();
                          int dislikes = review.getDislikes();
                          int total = likes + dislikes;
                          UserInfo reviewer = userInfo.getUser(review.getUsername());
                          String picture = reviewer.getPicture();
                          if(picture == null) {
                              picture = "images/blank_user.jpg";
                          }
                    %>
                    <div class="col">
                      <div class="col-xs-6 col-sm-3">
                          <image src="<%=picture%>" width="100%"><br>
                      </div>
                      <div class="col-xs-6 col-sm-9">
                          <h4>
                          <strong>Username:</strong> <%=user%></br>
                          <strong>Added:</strong> <%=dateAdded%></br>
                          <strong>Rating: </strong><span id="<%=rating%>"><%=label%></span></br>
                          </h4>
                          <div class="col-xs-2">
                            <form id="upvoteForm" action="GameServlet" method="post">
                              <input type="hidden" name="action" value="upvote">
                              <input type="hidden" name="gameid" value="<%=game.getId()%>">
                              <input type="hidden" name="reviewid" value="<%=reviewid%>">
                              <input type="hidden" name="likes" value="<%=likes%>">
                              <input type="hidden" name="username" value="<%=username%>">
                              <a href="#" onclick="document.getElementById('upvoteForm').submit();"><img src="images/upvote.png" width="40px"></a>
                            </form>
                          </div>
                          <div class="col-xs-2">
                            <form id="downvoteForm" action="GameServlet" method="post">
                              <input type="hidden" name="action" value="downvote">
                              <input type="hidden" name="gameid" value="<%=game.getId()%>">
                              <input type="hidden" name="reviewid" value="<%=reviewid%>">
                              <input type="hidden" name="dislikes" value="<%=dislikes%>">
                              <input type="hidden" name="username" value="<%=username%>">
                              <a href="#" onclick="document.getElementById('downvoteForm').submit();"><img src="images/downvote.png" width="40px"></a>
                            </form>
                          </div>
                      </div>
                      <div class="col-xs-12"><br></div>
                      <div class="col-xs-12">
                        <div class="panel panel-default">
                        <h4>
                          <%=content%>
                        </h4>
                        </div>
                        <div align="right">
                          <h4><%=likes%> out of <%=total%> people found this review helpful<br></h4>
                          <!--<button type="button" id="upvote"><img src="images/upvote.png" width="40px"></button>
                          <button type="button" id="downvote"><img src="images/downvote.png" width="40px"></button>
                          <a href="report.html">Report</a>-->
                          <br><br>
                        </div>
                      </div>
                    </div>
                    <%
                          reviewCount++;
                          reviewid++;
                        }
                    %>
                    <div class="col-xs-12">
                        <br>
                        <h1>Write A Review</h1><br>
                        <%
                            if(username == null || username.equals("") || username.equals("null")) {
                        %>
                        <h4>If you want to review this game login or sign up for an account.</h4>
                        <%} else {%>
                        <h4>If you want to review this game, fill out the fields below and click submit.</h4><br>
                        <form id="reviewForm" action="GameServlet" method="POST">
                          <input type="hidden" name="action" value="review">
                          <input type="hidden" name="username" value="<%=username%>">
                          <input type="hidden" name="gameid" value="<%=game.getId()%>">
                          <h4>Give the game a rating. The rating will be displayed on the website as follows:<br>
                              1) <span id="rating_appalling">Appalling</span><br>
                              2) <span id="rating_terrible">Terrible</span><br>
                              3) <span id="rating_bad">Bad</span><br>
                              4) <span id="rating_meh">Meh</span><br>
                              5) <span id="rating_okay">Okay</span><br>
                              6) <span id="rating_good">Good</span><br>
                              7) <span id="rating_great">Great</span><br>
                              8) <span id="rating_fantastic">Fantastic</span><br>
                              9) <span id="rating_masterpiece">Masterpiece</span><br>
                              10) <span id="rating_legendary">Legendary</span><br><br>
                          <strong>Rating:</strong>
                          </h4>
                          <select class="custom-select" name="score" required>
                            <option selected>Rating</option>
                            <option value="1">Appalling</option>
                            <option value="2">Terrible</option>
                            <option value="3">Bad</option>
                            <option value="4">Meh</option>
                            <option value="5">Okay</option>
                            <option value="6">Good</option>
                            <option value="7">Great</option>
                            <option value="8">Fantastic</option>
                            <option value="9">Masterpiece</option>
                            <option value="10">Legendary</option>
                          </select>
                          <br><br>
                          <h4>Use the following space to write your review. Please use constructive rhetoric and avoid the use of profanity. We reserve the right to take down reviews we find to be inappropriate.<br><br>
                          <strong>Review:</strong></h4>
                          <textarea name="review" form="reviewForm" style="min-width: 100%;min-height: 100px;" placeholder="I liked this game because..." required></textarea><br><br>
                          <input id="form_submit" type="submit" value="Submit">
                        </form>
                        <%}%>
                    </div>
                  </div>
            </div>
        </div>
      </div>
    </div>
  </div>
  </body>
</html>
