<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
    <!-- Add code here -->
    <div class="container-fluid" id="content" style="text-align: center;">
        <div class="row">
          <h1>Contact Us</h1>
          <p>
            If you want to let us know how we're doing contact us at <a href="#">gamerslogteam@notarealaddress.com</a>
          </p>
        </div>
        <div class="row">
          <h3>Comments or Issues?</h3>
          <div class="col">
            <div class="row">
              <h5>Let Us Know <a href="problem.html">Here</a></h5>
            </div>
          </div>
          <div class="col">
            <div class="row">
              <h5>We try our best to resolve all complaints and issues</h5>
              <p>No soliciting please!</p>
            </div>
          </div>
        </div>
    </div>
  </body>
</html>
