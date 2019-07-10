<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="gameInfo" class="beans.GameInfo" scope="session"/>
<%GameInfo game = (GameInfo) gameInfo.getGameById(Integer.parseInt(request.getParameter("gameid")));%>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
    <!-- Add code here -->
    <div id="content">
      <div class="container-fluid">
        <div class="row">
        <div class="col-xs-4">
          <div class="row" align="left">
              <h1>Title: <%=game.getTitle()%></h1><br>
          </div>
          <div class="row" align="left">
            <img width="100%" src="<%=game.getImage()%>">
          </div>
        </div>
        <div class ="col-xs-1"></div>
        <div class="col-xs-7">
          <div class="row" align="left">
            <h1>Game Information</h1><br>
            <form id="addGameForm" action="GameServlet" method="POST">
              <input type="hidden" name="action" value="add_game">
              <input type="hidden" name="username" value="<%=username%>">
              <input type="hidden" name="gameid" value="<%=Integer.parseInt(request.getParameter("gameid"))%>">
              <table class="table">
                <tr>
                  <th><h4>Rating</h4></th>
                  <th>
                    <select class="custom-select" name="score">
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
                  </th>
                </tr>
                <tr>
                  <th><h4>Status</h4></th>
                  <th>
                    <select class="custom-select" name="status">
                      <option selected>Status</option>
                      <option value="1">Currently Playing</option>
                      <option value="2">On Hold</option>
                      <option value="3">Plan To Play</option>
                      <option value="4">Dropped</option>
                      <option value="5">Completed</option>
                      <option value="6">100% Completed</option>
                    </select>
                  </th>
                </tr>
                <tr>
                  <th><h4>Times Played</h4></th>
                  <th><input type="number" name="times_played" value="1" required></th>
                </tr>
                <tr>
                  <th><h4>Favorite</h4></th>
                  <th>
                    <input type="checkbox" name="favorite" value="1"><br>
                  </th>
                </tr>
                <tr>
                  <th><h4>Comments</h4></th>
                  <th><textarea form="addGameForm" name="comments" style="min-width: 100%;min-height: 100px;"></textarea></th>
                </tr>
              </table>
            <input id="form_submit" type="submit" value="Add Game">
          </form>
          </div>
        </div>
        </div>
      </div>
    </div>
  </body>
</html>