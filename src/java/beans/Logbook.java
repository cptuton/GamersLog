package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.List;
import java.util.ArrayList;

public class Logbook implements Serializable{
    
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
    
    private List<Log> logList;
    
    public class Log {
        public int logid;
        public int gameid;
        public String username;
        public int score;
        public int isFavorite;
        public int status;
        public int timesPlayed;
        public java.util.Date dateAdded;
        public String comments;
        
        public Log (int lid, int gid, String uname, int s, int isFav, int stat, int tp, java.util.Date d) {
            logid = lid;
            gameid = gid;
            username = uname;
            score = s;
            isFavorite = isFav;
            status = stat;
            timesPlayed = tp;
            dateAdded = d;
            comments = null;
        }
        
        public Log (int lid, int gid, String uname, int s, int isFav, int stat, int tp, java.util.Date d, String cmts) {
            logid = lid;
            gameid = gid;
            username = uname;
            score = s;
            isFavorite = isFav;
            status = stat;
            timesPlayed = tp;
            dateAdded = d;
            comments = cmts;
        }
    }
    
    public Logbook() {
        try {
            logList = new ArrayList ();
            String driver = "org.mariadb.jdbc.Driver";
            Class.forName(driver);
            String dbURL = "jdbc:mariadb://localhost:3306/apollo_6_project";
            String username = "apollo.6";
            String password = "hatsunemiku";
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM `Logbook`");
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
                
                logList.add (new Log (logid, gameid, user, score, isFavorite, status, timesPlayed, convertedDate, comments));
                
                logs.put(logid, new Logbook(gameid, user, score, isFavorite, status, timesPlayed, comments, convertedDate));
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Logbook.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public Logbook(int gameid, String username, int score, int isFavorite, int status, int timesPlayed, String comments, java.util.Date dateAdded) {
        this.gameid = gameid;
        this.username = username;
        this.score = score;
        this.isFavorite = isFavorite;
        this.status = status;
        this.timesPlayed = timesPlayed;
        this.comments = comments;
        this.dateAdded = dateAdded;
    }
    
    public static Logbook getLog(int logid) {
        return ((Logbook)logs.get(logid));
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
    
    public int getLogbookSize() {
        return logs.size();
    }
    
    public List<Log> getLogList () {
        return logList;
    }
    
    public String[] getScoreName() {
        String rating[] = new String[2];
        switch(score) {
            case 1:
                rating[0] = "rating_appalling";
                rating[1] = "Appalling";
                break;
            case 2:
                rating[0] = "rating_terrible";
                rating[1] = "Terrible";
                break;
            case 3:
                rating[0] = "rating_bad";
                rating[1] = "Bad";
                break;
            case 4:
                rating[0] = "rating_meh";
                rating[1] = "Meh";
                break;
            case 5:
                rating[0] = "rating_okay";
                rating[1] = "Okay";
                break;
            case 6:
                rating[0] = "rating_good";
                rating[1] = "Good";
                break;
            case 7:
                rating[0] = "rating_great";
                rating[1] = "Great";
                break;
            case 8:
                rating[0] = "rating_fantastic";
                rating[1] = "Fantastic";
                break;
            case 9:
                rating[0] = "rating_masterpiece";
                rating[1] = "Masterpiece";
                break;
            case 10:
                rating[0] = "rating_legendary";
                rating[1] = "Legendary";
                break;
            default:
                rating[0] = "rating_unknown";
                rating[1] = "Unknown";
        }
        return rating;
    }
}
