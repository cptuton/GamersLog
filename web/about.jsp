<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
    <!-- Add code here -->
    <div class="container-fluid" id="content" style="text-align: center;">
        <div class="row">
          <h1>About</h1>
        </div>
        <div class="row">
          <textarea rows="7" cols="60" readonly class="form-control-plaintext">
            Gamer's Log Aims to be your go-to place for keeping a record of your played and plan-to-play games so you don't have to keep them in a spreadsheet anymore. So get involved in the community and share your thoughts on your favorite games and keep up with what your friends are playing. Most importantly, have fun!
          </textarea>
        </div>
        <div class="row">
          <h3>Create Your Gaming History</h3>
          <div class="col">
            <div class="row">
              <h5>What Have You Played?</h5>
              <p>Create a list of all the games you've played and keep track of games your friends play as well</p>
            </div>
          </div>
          <div class="col">
            <div class="row">
              <h5>Stay Up To Date With Your Friends</h5>
              <p>Follow your friends and see what they're up to</p>
            </div>
          </div>
        </div>
        <div class="row">
          <h3>Keep Up With The Gaming World</h3>
        </div>
        <div class="col">
          <div class="row">
            <h5>Keep a Watch on What's New</h5>
            <p>Keep up with new and upcoming games and get discussions started early</p>
          </div>
        </div>
    </div>
  </body>
</html>
