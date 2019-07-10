package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RecentReview implements Serializable{
    
    private static HashMap reviews = new HashMap();
    private Connection connection;
    
    private int reviewid;
    private int gameid;
    private String username;
    private String review;
    private int score;
    private int likes;
    private int dislikes;
    private int helpfulness;
    private java.util.Date dateAdded;
    
    public RecentReview() {
        try {
            String driver = "org.mariadb.jdbc.Driver";
            Class.forName(driver);
            String dbURL = "jdbc:mariadb://localhost:3306/apollo_6_project";
            String username = "apollo.6";
            String password = "hatsunemiku";
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            int rank = 1;
            ResultSet rs = statement.executeQuery("SELECT * FROM `Reviews` ORDER BY date_added DESC");
            while(rs.next()) {
                int reviewid = rs.getInt("reviewid");
                int gameid = rs.getInt("gameid");
                String user = rs.getString("username");
                int score = rs.getInt("score");
                String review = rs.getString("review");
                int likes = rs.getInt("likes");
                int dislikes = rs.getInt("dislikes");
                int helpfulness = rs.getInt("helpfulness");
                Date dateAdded = rs.getDate("date_added");
                java.util.Date convertedDate = new java.util.Date(dateAdded.getTime());
                
                reviews.put(Integer.toString(rank), new RecentReview(reviewid, gameid, user, score, review, likes, dislikes, helpfulness, dateAdded));
                rank++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(RecentReview.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public RecentReview(int reviewid, int gameid, String username, int score, String review, int likes, int dislikes, int helpfulness, java.util.Date dateAdded) {
        this.reviewid = reviewid;
        this.gameid = gameid;
        this.username = username;
        this.score = score;
        this.review = review;
        this.likes = likes;
        this.dislikes = dislikes;
        this.helpfulness = helpfulness;
        this.dateAdded = dateAdded;
    }
    
    public static RecentReview getReview(int rank) {
        return ((RecentReview)reviews.get(Integer.toString(rank)));
    }
    
    public int getReviewId() {
        return reviewid;
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
    
    public String getReview() {
        return review;
    }
    
    public int getLikes() {
        return likes;
    }
    
    public int getDislikes() {
        return dislikes;
    }
    
    public int getHelpfulness() {
        return helpfulness;
    }
    
    public java.util.Date getDateAdded() {
        return dateAdded;
    }
    
}
