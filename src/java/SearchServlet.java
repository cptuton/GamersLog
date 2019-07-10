import beans.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(urlPatterns = {"/SearchServlet"})
public class SearchServlet extends HttpServlet {

    public SearchServlet() {
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
        int score;
        String url = "/";
        switch(action) {
            case "games":
                try {
                    String driver = "org.mariadb.jdbc.Driver";
                    Class.forName(driver);
                    String dbURL = "jdbc:mariadb://localhost:3306/apollo_6_project";
                    String user = "apollo.6";
                    String password = "hatsunemiku";
                    Connection connection = DriverManager.getConnection(dbURL, user, password);

                    /* build the search string */
                    String search = "";
                    String prefix = "";
                    int count = 0;
                    if((request.getParameter("title") != null) && (request.getParameter("title") != "null") && (request.getParameter("title") != "")) {
                        if(count == 0) {
                            prefix = " WHERE";
                            count++;
                        }
                        else {
                            prefix = " AND";
                        }
                        search += prefix + " title LIKE '%" + request.getParameter("title") + "%'";
                    }
                    if(request.getParameter("publisher") != "null" && request.getParameter("publisher") != "") {
                        if(count == 0) {
                            prefix = " WHERE";
                            count++;
                        }
                        else {
                            prefix = " AND";
                        }
                        search += prefix + " publisher LIKE '%" + request.getParameter("publisher") + "%'";
                    }
                    if(request.getParameter("studio") != "") {
                        if(count == 0) {
                            prefix = " WHERE";
                            count++;
                        }
                        else {
                            prefix = " AND";
                        }
                        search += prefix + " studio LIKE '%" + request.getParameter("studio") + "%'";
                    }
                    if(request.getParameter("platform") != "") {
                        if(count == 0) {
                            prefix = " WHERE";
                            count++;
                        }
                        else {
                            prefix = " AND";
                        }
                        int platform;
                        switch(request.getParameter("platform")) {
                            case "Android":
                                platform = 4916;
                                break;
                            case "Arcade":
                                platform = 23;
                                break;
                            case "iOS":
                                platform = 4915;
                                break;
                            case "Mac OS":
                                platform = 37;
                                break;
                            case "Microsoft Xbox":
                                platform = 14;
                                break;
                            case "Xbox 360":
                                platform = 15;
                                break;
                            case "Microsoft Xbox One":
                                platform = 4920;
                                break;
                            case "Nintendo 3DS":
                                platform = 4912;
                                break;
                            case "Nintendo 64":
                                platform = 3;
                                break;
                            case "Nintendo DS":
                                platform = 8;
                                break;
                            case "Nintendo Entertainment System (NES)":
                                platform = 7;
                                break;
                            case "Nintendo Game Boy":
                                platform = 4;
                                break;
                            case "Nintendo Game Boy Advanced":
                                platform = 5;
                                break;
                            case "Nintendo Game Boy Color":
                                platform = 41;
                                break;
                            case "Nintendo Game Cube":
                                platform = 2;
                                break;
                            case "Nintendo Switch":
                                platform = 4971;
                                break;
                            case "Nintendo Wii":
                                platform = 9;
                                break;
                            case "Nintendo Wii U":
                                platform = 38;
                                break;
                            case "PC":
                                platform = 1;
                                break;
                            case "Sony Playstation":
                                platform = 10;
                                break;
                            case "Sony Playstation 2":
                                platform = 11;
                                break;
                            case "Sony Playstation 3":
                                platform = 12;
                                break;
                            case "Sony Playstation 4":
                                platform = 4919;
                                break;
                            case "Sony Playstation Portable":
                                platform = 13;
                                break;
                            case "Super Nintendo (SNES)":
                                platform = 6;
                                break;
                            default:
                                platform = 0;
                        }
                        if(platform != 0) {
                            search += prefix + " platform = " + platform;
                        }
                    }
                    if(request.getParameter("min_score") != "") {
                        if(count == 0) {
                            prefix = " WHERE";
                            count++;
                        }
                        else {
                            prefix = " AND";
                        }
                        search += prefix + " score >= " + request.getParameter("min_score");
                    }
                    if(request.getParameter("max_score") != "") {
                        if(count == 0) {
                            prefix = " WHERE";
                            count++;
                        }
                        else {
                            prefix = " AND";
                        }
                        search += prefix + " score <= " + request.getParameter("max_score");
                    }
                    /*if(request.getParameter("esrb") != "") {
                        if(count == 0) {
                            prefix = " WHERE";
                            count++;
                        }
                        else {
                            prefix = " AND";
                        }
                        String esrb;
                        switch(request.getParameter("esrb")) {
                            case "RP":
                                esrb = "0";
                                break;
                            case "EC":
                                esrb = "1";
                                break;
                            case "E":
                                esrb = "2";
                                break;
                            case "E10":
                                esrb = "3";
                                break;
                            case "T":
                                esrb = "4";
                                break;
                            case "M":
                                esrb = "5";
                                break;
                            default:
                                esrb = "error";
                        }
                        if(!esrb.equals("error")) {
                            search += prefix + " esrb = '" + esrb + "'";
                        }
                    }*/
                    
                    /* search the database */
                    Statement statement = connection.createStatement();
                    ResultSet rs = statement.executeQuery("SELECT * FROM `Games`" + search);
                    
                    count = 0;
                    while(rs.next()) {
                        count++;
                        request.setAttribute(Integer.toString(count), rs.getInt("id"));
                    }
                    
                    request.setAttribute("total", count);
                    
                    rs.close();
                    connection.close();
                    url = "/game_results.jsp";
                } catch (ClassNotFoundException | SQLException ex) {
                    url = "/index.jsp";
                    request.setAttribute("error", ex);
                    Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            case "users":
                try {
                    String driver = "org.mariadb.jdbc.Driver";
                    Class.forName(driver);
                    String dbURL = "jdbc:mariadb://localhost:3306/apollo_6_project";
                    String user = "apollo.6";
                    String password = "hatsunemiku";
                    Connection connection = DriverManager.getConnection(dbURL, user, password);

                    /* build the search string */
                    String search = "";
                    if(request.getParameter("user") != null) {
                        search = " WHERE username LIKE '%" + request.getParameter("user") + "%'";
                    }
                    
                    /* search the database */
                    Statement statement = connection.createStatement();
                    ResultSet rs = statement.executeQuery("SELECT * FROM `User`" + search);
                    
                    int count = 0;
                    while(rs.next()) {
                        count++;
                        request.setAttribute(Integer.toString(count), rs.getString("username"));
                    }
                    
                    request.setAttribute("total", count);
                    
                    rs.close();
                    connection.close();
                    url = "/user_results.jsp";
                } catch (ClassNotFoundException | SQLException ex) {
                    url = "/index.jsp";
                    request.setAttribute("error", ex);
                    Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            case "search":
            default:
                url = "/advanced.jsp";
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
