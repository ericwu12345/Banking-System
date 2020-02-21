import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;
import java.util.*;
import java.io.*;
import java.sql.*;

/**
 * Manage connection to database and perform SQL statements.
 */
public class BankingSystem {
	// Connection properties
	private static String driver;
	private static String url;
	private static String username;
	private static String password;
	
	// JDBC Objects
	private static Connection con;
	private static Statement stmt;
	private static ResultSet rs;

	/**
	 * Initialize database connection given properties file.
	 * @param filename name of properties file
	 */
	public static void init(String filename) {
		try {
			Properties props = new Properties();						// Create a new Properties object
			FileInputStream input = new FileInputStream(filename);	// Create a new FileInputStream object using our filename parameter
			props.load(input);										// Load the file contents into the Properties object
			driver = props.getProperty("jdbc.driver");				// Load the driver
			url = props.getProperty("jdbc.url");						// Load the url
			username = props.getProperty("jdbc.username");			// Load the username
			password = props.getProperty("jdbc.password");			// Load the password
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Test database connection.
	 */
	public static void testConnection() {
		System.out.println(":: TEST - CONNECTING TO DATABASE");
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, username, password);
			con.close();
			System.out.println(":: TEST - SUCCESSFULLY CONNECTED TO DATABASE");
			} catch (Exception e) {
				System.out.println(":: TEST - FAILED CONNECTED TO DATABASE");
				e.printStackTrace();
			}
	  }

	public static boolean verify(String customerID, String accNum) {
		boolean verify = false;
		int count = 0;
		String query = String.format("select count(*) from (select * from reportView where id = %s and number = %s)", customerID, accNum);
		try {
			con = DriverManager.getConnection(url, username, password);                
			stmt = con.createStatement();  
			rs = stmt.executeQuery(query);     
			while(rs.next()) {
				count = rs.getInt(1);
			} 
			if(count > 0) {
				verify = true;
			}                                                               
			con.close(); 
		} catch(Exception e) {
			System.out.println(":: LOGIN - FAILURE");
			return false;
		}
		return verify;
	}

	public static boolean login(String id, String pin) {
		String query = String.format("select count(*) from (select * from p1.customer where id = %s and pin = %s)", id, pin);
		boolean check = false;
		int counter = 0;
		try {
			System.out.println(":: LOGIN - RUNNING");
			con = DriverManager.getConnection(url, username, password);                
			stmt = con.createStatement();  
			rs = stmt.executeQuery(query);    
			while(rs.next()) {
				counter = rs.getInt(1);
			}
			if(counter > 0) {
				System.out.println(":: LOGIN - SUCCESS");
				check = true;
			} else {
				System.out.println(":: LOGIN - FAILURE");
			}
			con.close(); 
		} catch(Exception e) {
			System.out.println(":: LOGIN - FAILURE");
			return false;
		}
		return check;
	}

	public static void displayAccountInfo(String cusID) {
		String query = String.format("select number, balance, type from reportView where reportView.id = %s", cusID);
		String sumQuery = String.format("select sum(balance) Total from reportView where reportView.id = %s", cusID);
		try {
			con = DriverManager.getConnection(url, username, password);                
			stmt = con.createStatement();  
			rs = stmt.executeQuery(query);  
			//print  
			rs = stmt.executeQuery(sumQuery);
			//print                                                             
			con.close(); 
			System.out.println(":: DISPLAY ACCOUNT INFORMATION - SUCCESS");
			
		} catch(Exception e) {
			System.out.println(":: DISPLAY ACCOUNT INFORMATION - FAILURE");
			
		}
	}

	/**
	 * Create a new customer.
	 * @param name customer name
	 * @param gender customer gender
	 * @param age customer age
	 * @param pin customer pin
	 */
	public static void newCustomer(String name, String gender, String age, String pin) 
	{
		//add a try catch or smt
		String query = String.format("INSERT INTO P1.CUSTOMER (NAME, GENDER, AGE, PIN) VALUES ('%s', '%s', %s, %s)", name, gender, age, pin);  
		//String query = "select * from p1.account";
		try {
			System.out.println(":: CREATE NEW CUSTOMER - RUNNING");
			con = DriverManager.getConnection(url, username, password);                
			stmt = con.createStatement();  
			stmt.executeUpdate(query);                                                                       
			con.close(); 
			System.out.println(":: CREATE NEW CUSTOMER - SUCCESS"); 
		} catch(Exception e) {
			System.out.println(":: CREATE NEW CUSTOMER - FAILURE");
		}
	}

	/**
	 * Open a new account.
	 * @param id customer id
	 * @param type type of account
	 * @param amount initial deposit amount
	 */
	public static void openAccount(String id, String type, String amount) 
	{
		String query = String.format("insert into p1.account(id, balance, type, status) values(%s, %s, '%s', 'A')", id, amount, type);
		//String query = "SELECT * FROM P1.ACCOUNT";
		try {
			System.out.println(":: OPEN ACCOUNT - RUNNING");
			con = DriverManager.getConnection(url, username, password);                
			stmt = con.createStatement(); 
			stmt.executeUpdate(query);
			con.close();
			System.out.println(":: OPEN ACCOUNT - SUCCESS");
		} catch(Exception e) {
			System.out.println(":: OPEN ACCOUNT - FAILURE");
		}
	}

	/**
	 * Close an account.
	 * @param accNum account number
	 */
	public static void closeAccount(String accNum) 
	{
		String query = String.format("update p1.account set balance = 0, status = 'I' where number = %s", accNum);
		try {
			System.out.println(":: CLOSE ACCOUNT - RUNNING");
			con = DriverManager.getConnection(url, username, password);                
			stmt = con.createStatement(); 
			stmt.executeUpdate(query);
			con.close();
			System.out.println(":: CLOSE ACCOUNT - SUCCESS");
		} catch(Exception e) {
			System.out.println(":: CLOSE ACCOUNT - FAILURE");
		}
	}

	/**
	 * Deposit into an account.
	 * @param accNum account number
	 * @param amount deposit amount
	 */
	public static void deposit(String accNum, String amount) 
	{
		String query = String.format("update p1.account set balance = ((select balance from p1.account where number = %s) + %s) where number = %s", accNum, amount, accNum);
		try {
			System.out.println(":: DEPOSIT - RUNNING");
			con = DriverManager.getConnection(url, username, password);                
			stmt = con.createStatement(); 
			stmt.executeUpdate(query);
			con.close();
			System.out.println(":: DEPOSIT - SUCCESS");
		} catch(Exception e) {
			System.out.println(":: DEPOSIT - FAILURE");
		}
	}

	/**
	 * Withdraw from an account.
	 * @param accNum account number
	 * @param amount withdraw amount
	 */
	public static void withdraw(String accNum, String amount) 
	{
		String query = String.format("update p1.account set balance = ((select balance from p1.account where number = %s) - %s) where number = %s", accNum, amount, accNum);
		try {
			System.out.println(":: WITHDRAW - RUNNING");
			con = DriverManager.getConnection(url, username, password);                
			stmt = con.createStatement(); 
			stmt.executeUpdate(query);
			con.close();
			System.out.println(":: WITHDRAW - SUCCESS");
		} catch(Exception e) {
			System.out.println(":: WITHDRAW - FAILURE");
		}
	}

	public static void makeInactive(String accNum) {
		String query = String.format("update p1.account set balance = 0, status = 'I' where number = %s", accNum);
		try {
			con = DriverManager.getConnection(url, username, password);                
			stmt = con.createStatement(); 
			stmt.executeUpdate(query);
			con.close();
			System.out.println(":: MAKE INACTIVE - SUCCESS");
		} catch(Exception e) {
			System.out.println(":: MAKE INACTIVE - FAILURE");
		}
	}

	/**
	 * Transfer amount from source account to destination account. 
	 * @param srcAccNum source account number
	 * @param destAccNum destination account number
	 * @param amount transfer amount
	 */
	public static void transfer(String srcAccNum, String destAccNum, String amount) 
	{
		String query1 = String.format("update p1.account set balance = ((select balance from p1.account where number = %s) - %s) where number = %s", srcAccNum, amount, srcAccNum);
		String query2 = String.format("update p1.account set balance = ((select balance from p1.account where number = %s) + %s) where number = %s", destAccNum, amount, destAccNum);
		try {
			System.out.println(":: TRANSFER - RUNNING");
			con = DriverManager.getConnection(url, username, password);                
			stmt = con.createStatement(); 
			stmt.executeUpdate(query1);
			stmt.executeUpdate(query2);
			con.close();
			System.out.println(":: TRANSFER - SUCCESS");
		} catch(Exception e) {
			System.out.println(":: TRANSFER - FAILURE");
		}
	}

	/**
	 * Display account summary.
	 * @param cusID customer ID
	 */
	public static void accountSummary(String cusID) 
	{
		//String query = String.format("select number, balance, type from reportView where reportView.id = %s", cusID);
		//String sumQuery = String.format("select sum(balance) Total from reportView where reportView.id = %s", cusID);
		String query1 = String.format("select number, balance from reportView where id = %s", cusID);
		String query2 = String.format("select sum(balance) as sum from reportView where id = %s", cusID);
		try {
			System.out.println(":: ACCOUNT SUMMARY - RUNNING");
			con = DriverManager.getConnection(url, username, password);                
			stmt = con.createStatement(); 
			rs = stmt.executeQuery(query1);
			//ResultSet rs = stmt.executeQuery(query);                                                //Executing the query and storing the results in a Result Set
			System.out.printf("%-11s %-11s\n", "NUMBER", "BALANCE");
			System.out.println("----------- -----------");
			while(rs.next()) {                                                                      //Loop through result set and retrieve contents of each row
				Integer number = rs.getInt(1);
				double balance = rs.getDouble(2);
				System.out.printf("%11d %11.2f\n", number, balance);
			}
			System.out.println("-----------------------");
			rs = stmt.executeQuery(query2);
			while(rs.next()) {
				double totalBalance = rs.getDouble(1);
				System.out.printf("%5s %17.2f\n", "TOTAL", totalBalance);
			}
			con.close();
			System.out.println(":: ACCOUNT SUMMARY - SUCCESS");
		} catch(Exception e) {
			System.out.println(":: ACCOUNT SUMMARY - FAILURE");
		}
	}

	/**
	 * Display Report A - Customer Information with Total Balance in Decreasing Order.
	 */
	public static void reportA() 
	{
		String query = "select id, name, gender, age, sum(balance) as total from reportView group by id, name, gender, age order by(total) desc";
		try {
			System.out.println(":: REPORT A - RUNNING");
			con = DriverManager.getConnection(url, username, password);                
			stmt = con.createStatement(); 
			rs = stmt.executeQuery(query);
			//ResultSet rs = stmt.executeQuery(query);                                                //Executing the query and storing the results in a Result Set
			System.out.printf("%-11s %-15s %-6s %-11s %-11s\n", "ID", "NAME", "GENDER", "AGE", "TOTAL");
			System.out.println("----------- --------------- ------ ----------- -----------");
			while(rs.next()) {                                                                      //Loop through result set and retrieve contents of each row
				Integer customerID = rs.getInt(1);
				String name = rs.getString(2);
				String gender = rs.getString(3);
				Integer age = rs.getInt(4);
				double totalBalance = rs.getDouble(5);
				System.out.printf("%11d %15s %6s %11d %11.2f\n", customerID, name, gender, age, totalBalance);
			}
			con.close();
			System.out.println(":: REPORT A - SUCCESS");
		} catch(Exception e) {
			System.out.println(":: REPORT A - FAILURE");
		}
	}

	/**
	 * Display Report B - Customer Information with Total Balance in Decreasing Order.
	 * @param min minimum age
	 * @param max maximum age
	 */
	public static void reportB(String min, String max) 
	{
		String query1 = String.format("select sum(balance) as totalBalance from reportView where age >= %s and age <= %s", min, max);
		String query2 = String.format("select count(*) from (select distinct id from reportView where age >= %s and age <= %s)", min, max);
		double totalBalance = 0;
		double numberOfAccounts = 0;
		try {
			System.out.println(":: REPORT B - RUNNING");
			con = DriverManager.getConnection(url, username, password);                
			stmt = con.createStatement(); 
			rs = stmt.executeQuery(query1);
			System.out.println("AVERAGE");
			System.out.println("-----------");
			while(rs.next()) {                                                                      //Loop through result set and retrieve contents of each row
				totalBalance = rs.getDouble(1);
				//System.out.printf("%11d %15s %6s %11d %11.2f\n", customerID, name, gender, age, totalBalance);
			}
			rs = stmt.executeQuery(query2);
			while(rs.next()) {
				numberOfAccounts = rs.getInt(1);
			}
			double averageBalance = totalBalance/numberOfAccounts;
			System.out.printf("%11.2f\n", averageBalance);
			con.close();
			System.out.println(":: REPORT B - SUCCESS");
		} catch(Exception e) {
			System.out.println(":: REPORT B - FAILURE");
		}
	}
}
