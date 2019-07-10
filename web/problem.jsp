<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
    <!-- Add code here -->
    <br/><br/>
    <div class="center" id="content">
      <div class="container-fluid">
        <div class="col">
          <div class="row">
            <h3>Problem?</h3>
          </div>
        </div>
        <div class="col-lg-12" style="text-align: center;">
          <h4>Let Us Know</h4>
          <div class="row">
            <table class="table">
              <tr>
                <th class="center">Subject</th>
                <th><input type="text" id="subject"></th>
              </tr>
              <tr>
                <th class="center">Issue/Comments</th>
                <th><textarea rows="5" cols="50" id="comments"></textarea></th>
              </tr>
            </table>
          </div>
          <div class="row">
            <br/><br/>
            <input type="button" value="Submit" class="btn-secondary" />
            <input type="button" value="Cancel" class="btn-secondary" />
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
