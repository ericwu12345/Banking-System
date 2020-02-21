import java.util.*;
public class p1 {
    Scanner in = new Scanner(System.in);
    boolean stop = false;
    boolean login = false;
    String id = "";
    public void start() {
        while(!stop) {
            System.out.println("1) New Customer");
            System.out.println("2) Customer Login");
            System.out.println("3) Exit");
            String input1 = in.nextLine();
            firstMenu(input1);
        }
    }
    public void secondMenu(String choice) {
        switch(choice) {
            case "1" :
                System.out.println("Please enter Customer ID: ");
                String id = in.nextLine();
                System.out.println("Please enter Account type (S or C): ");
                String type = in.nextLine();
                System.out.println("Please enter initial deposit: ");
                String amount = in.nextLine();
                BankingSystem.openAccount(id, type, amount);
                break;
            case "2" :
                System.out.println("Please enter Account Number: ");
                //make Inactive and empty balance
                String accountNumber = in.nextLine();
                if(BankingSystem.verify(this.id, accountNumber)) {
                    BankingSystem.closeAccount(accountNumber);
                } else {
                    System.out.println("YOU HAVE ENTERED INVALID INFORMATION!");
                }
                break;
            case "3" :
                System.out.println("Please enter Account Number: ");
                //deposit amount
                String accountNumber2 = in.nextLine();
                System.out.println("Please enter deposit amount: ");
                String deposit = in.nextLine();
                BankingSystem.deposit(accountNumber2, deposit);
                break;
            case "4" :
                System.out.println("Please enter Account Number: ");
                String accountNumber3 = in.nextLine();
                System.out.println("Please enter withdraw amount");
                String withdraw = in.nextLine();
                if(BankingSystem.verify(this.id, accountNumber3)) {
                    BankingSystem.withdraw(accountNumber3, withdraw);
                } else {
                    System.out.println("YOU HAVE ENTERED INVALID INFORMATION!");
                }
                break;
            case "5" :
                System.out.println("Please enter account to withdraw from: ");
                String accountNumber4 = in.nextLine();
                System.out.println("Please enter the amount you wish to transfer: ");
                String amountToTransfer = in.nextLine();
                System.out.println("Please enter account to deposit into: ");
                String accountNumber5 = in.nextLine();
                if(BankingSystem.verify(this.id, accountNumber4)) {
                    BankingSystem.transfer(accountNumber4, accountNumber5, amountToTransfer);
                } else {
                    System.out.println("YOU HAVE ENTERED INVALID INFORMATION!");
                }
                break;
            case "6" :
                //display account # and balance for same customer and total balance of all accounts
                BankingSystem.accountSummary(this.id);
                break;
            case "7" :
                //go back to previous menu
                id = "";
                //start();
                break;
            default :
                //nothing
                id = "";
                //start();
        }        
    }

    public void secretMenu(String choice) {
            if(choice.equals("1")) {
                //same as function 6
                System.out.println("Please enter the Customer ID you wish to get a summary for: ");
                String result1 = in.nextLine();
                BankingSystem.accountSummary(result1);
            } else if(choice.equals("2")) {
              BankingSystem.reportA();
            } else if(choice.equals("3")) {
                System.out.println("Please enter the minimum age of Account: ");
                String minAge = in.nextLine();
                System.out.println("Please enter the maximum age of Account: ");
                String maxAge = in.nextLine();
                BankingSystem.reportB(minAge, maxAge);
            } else if(choice.equals("4")) {
                System.out.println("Returning to previous Menu");
                //go back to previous menu
                //start();
            }
    }

    public void firstMenu(String choice) {
        if(choice.equals("1")) {
            System.out.println("Please enter your name: ");
            String name = in.nextLine();
            System.out.println("Please enter your gender (M or F): ");
            String gender = in.nextLine();
            System.out.println("Please enter your age: ");
            String age = in.nextLine();
            System.out.println("Please enter a PIN: ");
            String pin = in.nextLine();
            BankingSystem.newCustomer(name, gender, age, pin);
        } else if(choice.equals("2")) {
            System.out.println("Please enter your ID: ");
            String id = in.nextLine();
            System.out.println("Please enter your PIN: ");
            String pin = in.nextLine();
            if(id.equals("0") && pin.equals("0")) {
                boolean admin = false;
                while(!admin) {
                    System.out.println("1) Account Summary for a Customer");
                    System.out.println("2) Report A :: Customer Information with Total Balance in Decreasing Order");
                    System.out.println("3) Report B :: Find the Average Total Balance Between Age Groups");
                    System.out.println("4) Exit");
                    String result = in.nextLine();
                    if(result.equals("4")) {
                        admin = true;
                    }
                    secretMenu(result);
                }
            } else {
                login = BankingSystem.login(id, pin);
                while(login) {
                    this.id = id;
                    System.out.println("1) Open Account");
                    System.out.println("2) Close Account");
                    System.out.println("3) Deposit");
                    System.out.println("4) Withdraw");
                    System.out.println("5) Transfer");
                    System.out.println("6) Account Summary");
                    System.out.println("7) Exit");
                    String result = in.nextLine();
                    if(result.equals("7")) {
                        login = false;
                    }
                    secondMenu(result);
                }
            }
        } else if(choice.equals("3")) {
            stop = true;
        }
    }
}