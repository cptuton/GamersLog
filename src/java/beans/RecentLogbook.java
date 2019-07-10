package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RecentLogbook implements Serializable{
    
    private static HashMap logs = new HashMap();
    private Connection connection;
    
    private int logid;
    private int gameid;
    private String username;
    private int score;
    private int isFavorite;
    private int status;
    private int timesPlayed;
    private String comments;
    private java.util.Date dateAdded;
    
    public RecentLogbook() {
        try {
            String driver = "org.mariadb.jdbc.Driver";
            Class.forName(driver);
            String dbURL = "jdbc:mariadb://localhost:3306/apollo_6_project";
            String username = "apollo.6";
            String password = "hatsunemiku";
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            int rank = 1;
            ResultSet rs = statement.executeQuery("SELECT * FROM `Logbook` ORDER BY date_added DESC");
            while(rs.next()) {
                int logid = rs.getInt("logid");
                int gameid = rs.getInt("gameid");
                String user = rs.getString("username");
                int score = rs.getInt("score");
                int isFavorite = rs.getInt("is_favorite");
                int status = rs.getInt("status");
                int timesPlayed = rs.getInt("times_played");
                String comments = rs.getString("comments");
                Date dateAdded = rs.getDate("date_added");
                java.util.Date convertedDate = new java.util.Date(dateAdded.getTime());
                
                logs.put(Integer.toString(rank), new RecentLogbook(gameid, user, score, isFavorite, status, timesPlayed, comments, convertedDate));
                rank++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(RecentLogbook.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public RecentLogbook(int gameid, String username, int score, int isFavorite, int status, int timesPlayed, String comments, java.util.Date dateAdded) {
        this.gameid = gameid;
        this.username = username;
        this.score = score;
        this.isFavorite = isFavorite;
        this.status = status;
        this.timesPlayed = timesPlayed;
        this.comments = comments;
        this.dateAdded = dateAdded;
    }
    
    public static RecentLogbook getLog(int rank) {
        return ((RecentLogbook)logs.get(Integer.toString(rank)));
    }
    
    public int getGameId() {
        return gameid;
    }
    
    public String getUsername() {
        return username;
    }
    
    public int getScore() {
        return score;
    }
    
    public int getIsFavorite() {
        return isFavorite;
    }
    
    public int getStatus() {
        return status;
    }
    
    public int getTimesPlayed() {
        return timesPlayed;
    }
    
    public String getComments() {
        return comments;
    }
    
    public java.util.Date getDateAdded() {
        return dateAdded;
    }
}
