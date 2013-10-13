import java.util.*;
public class OzAssemblyProj
{
	static Scanner in = new Scanner(System.in);
	public static void main(String[] args)
	{
		char[] grid = new char[9];
		int player;
		boolean win;
		int move;
		System.out.println("Tic Tac Toe Game - By Oz Elentok");
		do
		{
			win = false;
			player = 2;
			System.out.println("Enter your move by location(1-9)");
			System.out.println();
			initiateGrid(grid);
			for(int i = 1; i <= 9 && !win; i++)
			{
				printGrid(grid);
				if(player == 2)
				{
					player >>= 1; // shift right by 1
					System.out.println("Player 1 (X) turn");
				}
				else
				{
					player <<= 1; // shift left by 1
					System.out.println("Player 2 (O) turn");
				}
				move = getMove(grid);
				if(player == 1)
					grid[move] = 'X';
				else
					grid[move] = 'O';
				if (i >= 4 && checkWin(grid))
					win = true;
			}
			if(win)
				System.out.println("The player who won was player " + player);
			else
				System.out.println("A tie between the two players!");
				
			System.out.println("Would you like a rematch? (y - yes, any key - no)");
			move = in.next().charAt(0);
		} while ( move == 'y' );
	}
	static int getMove(char[] grid)
	{
		char move;
		boolean notGood;
		do 
		{
			move = in.next().charAt(0);
			move -= '1';
			notGood = (move < 0 || move > 8);
			if (notGood)
				System.out.println("ERROR!, input is not a digit");
			else
			{
				notGood = (grid[move] > '9'); // 'O' or 'X' are bigger then '9'
				if (notGood)
					System.out.println("ERROR!, this place is taken");
			}
		} while (notGood);
		return (int) move;
	}
	static void initiateGrid(char[] grid)
	{
		for(char i = 0; i < 9; i++)
		{
			grid[i] = (char)('1' + i);
		}

	}
	static boolean checkWin(char[] grid)
	{	
		// check diagonals
		if(grid[0] == grid[4] && grid[0] == grid[8])
			return true;
		else if(grid[2] == grid[4] && grid[2] == grid[6])
			return true;
			
		// check rows
		else if(grid[0] == grid[1] && grid[0] == grid[2])
			return true;
		else if(grid[3] == grid[4] && grid[3] == grid[5])
			return true;
		else if(grid[6] == grid[7] && grid[6] == grid[8])
			return true;
			
		// check colums
		else if(grid[0] == grid[3] && grid[0] == grid[6])
			return true;
		else if(grid[1] == grid[4] && grid[1] == grid[7])
			return true;
		else if(grid[2] == grid[5] && grid[2] == grid[8])
			return true;
			
		else
			return false;
	}
	static void printGrid(char[] grid)
	{
		System.out.println(" " + grid[0] + " | " + grid[1] + " | "+ grid[2]);
		System.out.println("---|---|---");
		System.out.println(" " + grid[3] + " | " + grid[4] + " | "+ grid[5]);
		System.out.println("---|---|---");
		System.out.println(" " + grid[6] + " | " + grid[7] + " | "+ grid[8]);

	}

}
