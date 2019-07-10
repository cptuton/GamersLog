import beans.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(urlPatterns = {"/GameServlet"})
public class GameServlet extends HttpServlet {

    public GameServlet() {
        super();
    }
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GameServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GameServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String username = request.getParameter("username");
        int gameid;
        int reviewid;
        int score;
        String url = "/";
        switch(action) {
            case "remove_game":
                gameid = Integer.parseInt(request.getParameter("gameid"));

                try {
                    String driver = "org.mariadb.jdbc.Driver";
                    Class.forName(driver);
                    String dbURL = "jdbc:mariadb://localhost:3306/apollo_6_project";
                    String user = "apollo.6";
                    String password = "hatsunemiku";
                    Connection connection = DriverManager.getConnection(dbURL, user, password);

                    /* try and delete from the logbook */
                    Statement statement = connection.createStatement();
                    String query = "DELETE FROM `Logbook` WHERE username = ? AND gameid = ?";
                    PreparedStatement ps = connection.prepareStatement(query);
                        
                    ps = connection.prepareStatement(query);
                    ps.setString(1, username);
                    ps.setInt(2, gameid);
                    ps.execute();
                    
                    /* update the game's score */
                    GameInfo gameInfo = new GameInfo();
                    GameInfo game = gameInfo.getGameById(gameid);
                    int members = game.getMembers();
                    ResultSet rs = statement.executeQuery("SELECT * FROM `Logbook`");
                    int sum = 0;
                    int count = 0;
                    while(rs.next()) {
                        if(gameid == rs.getInt("gameid")) {
                            sum += rs.getInt("score");
                            count++;
                        }
                    }
                    query = "UPDATE `apollo_6_project`.`Games` SET score = ?, members = ? WHERE id = ?";

                    ps = connection.prepareStatement(query);
                    ps.setFloat(1, (float)sum / (float)count);
                    ps.setInt(2, members - 1);
                    ps.setInt(3, gameid);
                    ps.execute();

                    ps.close();

                    connection.close();
                    url = "/logbook.jsp";
                } catch (ClassNotFoundException | SQLException ex) {
                    url = "/index.jsp";
                    request.setAttribute("error", ex);
                    Logger.getLogger(GameServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            case "review":
                score = Integer.parseInt(request.getParameter("score"));
                String review = request.getParameter("review");
                if(review.length() > 2048) {
                    review = review.substring(0, 2048);
                }
                gameid = Integer.parseInt(request.getParameter("gameid"));
                try {
                    String driver = "org.mariadb.jdbc.Driver";
                    Class.forName(driver);
                    String dbURL = "jdbc:mariadb://localhost:3306/apollo_6_project";
                    String user = "apollo.6";
                    String password = "hatsunemiku";
                    Connection connection = DriverManager.getConnection(dbURL, user, password);

                    /* grab the next available id */
                    Statement statement = connection.createStatement();
                    ResultSet rs = statement.executeQuery("SELECT * FROM `Reviews`");
                    reviewid = 1;
                    boolean error = false;
                    while(rs.next()) {
                        String tmpReview = rs.getString("review");
                        String tmpUsername = rs.getString("username");
                        if(tmpReview.equals(review) && tmpUsername.equals(username)) {
                            error = true;
                            break;
                        }
                        reviewid++;
                    }
                    if(!error) {
                        Calendar calendar = Calendar.getInstance();
                        java.sql.Date dateAdded = new java.sql.Date(calendar.getTime().getTime());

                        String query = "INSERT INTO `apollo_6_project`.`Reviews` (`reviewid`, `gameid`, `username`, `score`, `review`, `likes`, `dislikes`, `helpfulness`, `date_added`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";

                        PreparedStatement ps = connection.prepareStatement(query);
                        ps.setInt(1, reviewid);
                        ps.setInt(2, gameid);
                        ps.setString(3, username);
                        ps.setInt(4, score);
                        ps.setString(5, review);
                        ps.setInt(6, 0);
                        ps.setInt(7, 0);
                        ps.setInt(8, 0);
                        ps.setDate(9, dateAdded);
                        
                        ps.execute();
                        ps.close();
                    }
                    rs.close();
                    connection.close();
                    url = "/game.jsp";
                } catch (ClassNotFoundException | SQLException ex) {
                    url = "/index.jsp";
                    request.setAttribute("error", ex);
                    Logger.getLogger(GameServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            case "add_game":
                gameid = Integer.parseInt(request.getParameter("gameid"));
                score = Integer.parseInt(request.getParameter("score"));
                int is_favorite;
                if(request.getParameter("is_favorite") != null) {
                    is_favorite = 1;
                }
                else {
                    is_favorite = 0;
                }
                int status = Integer.parseInt(request.getParameter("status"));
                int times_played = Integer.parseInt(request.getParameter("times_played"));
                String comments = request.getParameter("comments");
                if(comments.length() > 2048) {
                    comments = comments.substring(0, 2048);
                }
                try {
                    String driver = "org.mariadb.jdbc.Driver";
                    Class.forName(driver);
                    String dbURL = "jdbc:mariadb://localhost:3306/apollo_6_project";
                    String user = "apollo.6";
                    String password = "hatsunemiku";
                    Connection connection = DriverManager.getConnection(dbURL, user, password);

                    /* grab the next available id */
                    Statement statement = connection.createStatement();
                    ResultSet rs = statement.executeQuery("SELECT * FROM `Logbook`");
                    boolean error = false;
                    int logid = 1;
                    while(rs.next()) {
                        int tmpGameId = rs.getInt("gameid");
                        String tmpUsername = rs.getString("username");
                        if(tmpGameId == gameid && (tmpUsername == null ? username == null : tmpUsername.equals(username))) {
                            error = true;
                            break;
                        }
                        logid++;
                    }
                    if(!error) {
                        Calendar calendar = Calendar.getInstance();
                        java.sql.Date dateAdded = new java.sql.Date(calendar.getTime().getTime());

                        String query = "INSERT INTO `apollo_6_project`.`Logbook` (`logid`, `gameid`, `username`, `score`, `is_favorite`, `status`, `times_played`, `comments`, `date_added`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";

                        PreparedStatement ps = connection.prepareStatement(query);
                        ps.setInt(1, logid);
                        ps.setInt(2, gameid);
                        ps.setString(3, username);
                        ps.setInt(4, score);
                        ps.setInt(5, is_favorite);
                        ps.setInt(6, status);
                        ps.setInt(7, times_played);
                        ps.setString(8, comments);
                        ps.setDate(9, dateAdded);
                        ps.execute();
                        
                        /* update the game's score */
                        GameInfo gameInfo = new GameInfo();
                        GameInfo game = gameInfo.getGameById(gameid);
                        int members = game.getMembers();
                        rs = statement.executeQuery("SELECT * FROM `Logbook`");
                        int sum = 0;
                        int count = 0;
                        while(rs.next()) {
                            if(gameid == rs.getInt("gameid")) {
                                sum += rs.getInt("score");
                                count++;
                            }
                        }
                        query = "UPDATE `apollo_6_project`.`Games` SET score = ?, members = ? WHERE id = ?";
                        
                        ps = connection.prepareStatement(query);
                        ps.setFloat(1, (float)sum / (float)count);
                        ps.setInt(2, members + 1);
                        ps.setInt(3, gameid);
                        ps.execute();
                        
                        ps.close();
                    }
                    rs.close();
                    connection.close();
                    url = "/logbook.jsp";
                } catch (ClassNotFoundException | SQLException ex) {
                    url = "/index.jsp";
                    request.setAttribute("error", ex);
                    Logger.getLogger(GameServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            case "upvote":
                reviewid = Integer.parseInt(request.getParameter("reviewid"));
                int likes = Integer.parseInt(request.getParameter("likes"));
                try {
                    String driver = "org.mariadb.jdbc.Driver";
                    Class.forName(driver);
                    String dbURL = "jdbc:mariadb://localhost:3306/apollo_6_project";
                    String user = "apollo.6";
                    String password = "hatsunemiku";
                    Connection connection = DriverManager.getConnection(dbURL, user, password);

                    String query = "UPDATE `apollo_6_project`.`Reviews` SET likes = ? WHERE reviewid = ?";

                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setInt(1, likes + 1);
                    ps.setInt(2, reviewid);
                    ps.execute();

                    ps.close();
                    
                    connection.close();
                    url = "/game.jsp";
                } catch (ClassNotFoundException | SQLException ex) {
                    url = "/index.jsp";
                    request.setAttribute("error", ex);
                    Logger.getLogger(GameServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            case "downvote":
                reviewid = Integer.parseInt(request.getParameter("reviewid"));
                int dislikes = Integer.parseInt(request.getParameter("dislikes"));

                try {
                    String driver = "org.mariadb.jdbc.Driver";
                    Class.forName(driver);
                    String dbURL = "jdbc:mariadb://localhost:3306/apollo_6_project";
                    String user = "apollo.6";
                    String password = "hatsunemiku";
                    Connection connection = DriverManager.getConnection(dbURL, user, password);

                    String query = "UPDATE `apollo_6_project`.`Reviews` SET dislikes = ? WHERE reviewid = ?";

                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setInt(1, dislikes + 1);
                    ps.setInt(2, reviewid);
                    ps.execute();

                    ps.close();
                    
                    connection.close();
                    url = "/game.jsp";
                } catch (ClassNotFoundException | SQLException ex) {
                    url = "/index.jsp";
                    request.setAttribute("error", ex);
                    Logger.getLogger(GameServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            case "add":
                if(username == null || username.equals("") || username.equals("null")) {
                    url = "/login.jsp";
                }
                else {
                    url = "/add_game.jsp";
                }
                break;
            case "logbook":
                if(username == null || username.equals("") || username.equals("null")) {
                    url = "/login.jsp";
                }
                else {
                    url = "/logbook.jsp";
                }
                break;
            case "game":
                url = "/game.jsp";
                break;
            case "popular":
                url = "/popular.jsp";
                break;
            case "top":
                url = "/top.jsp";
                break;
            case "index":
                request.setAttribute("username", username);
                url = "/index.jsp";
                break;
            default:
                ;
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher(url);
        dispatcher.forward(request, response);                
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
