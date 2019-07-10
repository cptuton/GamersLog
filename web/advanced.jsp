<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
    <!-- Add code here -->
    <div id="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-xs-12 col-sm-6">
            <h1>Search Games</h1><br>
            <form id="searchForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="games">
                <input type="hidden" name="username" value="<%=username%>">
                <h3>Game Title</h3>
                <input style="min-width: 100%;" type="text" name="title"></input>
                <h3>Publisher</h3>
                <input style="min-width: 100%;" type="text" name="publisher"></input>
                <h3>Studio</h3>
                <input style="min-width: 100%;" type="text" name="studio"></input>
                <h3>Minimum Score</h3>
                <input style="min-width: 100%;" type="text" name="min_score"></input>
                <h3>Maximum Score</h3>
                <input style="min-width: 100%;" type="text" name="max_score"></input>
                <h3>Platform</h3>
                <input style="min-width: 100%;" type="text" name="platform"></input>
                <!--<h3>ESRB Rating</h3>
                <input style="min-width: 100%;" type="text" name="esrb"></input>
                <h3>Genres</h3>
                <div class="col-sx-2">
                  <input type="checkbox" name="genres"></input> Action  
                  <input type="checkbox" name="genres"></input> Adventure  
                  <input type="checkbox" name="genres"></input> Racing  
                </div>
                <br>
                <div class="col-sx-2">
                  <input type="checkbox" name="genres"></input> MMO  
                  <input type="checkbox" name="genres"></input> Fighting  
                  <input type="checkbox" name="genres"></input> FPS  
                </div>
                <br>
                <div class="col-sx-2">
                  <input type="checkbox" name="genres"></input> RPG  
                  <input type="checkbox" name="genres"></input> Sports  
                  <input type="checkbox" name="genres"></input> RTS  
                </div>
                -->
                <br><br><br>
                <input id="form_submit" type="submit" value="Search Games"></input>
            </form>
            <br><br><br>
          </div>
          <div class="col-xs-12 col-sm-6">
            <h1>Search Users</h1><br>
            <form id="searchForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="users">
                <input type="hidden" name="username" value="<%=username%>">
                <h3>Username</h3>
                <input style="min-width: 100%;" type="text" name="user"></input>
                <br><br><br>
                <input id="form_submit" type="submit" value="Search Users"></input>
            </form>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>