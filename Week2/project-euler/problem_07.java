public class problem_07 {
		
	public static void main(String[] args) {
		
		int i = 0;
		int j = 0;
		int yaku = 0;
		int c = 0;
		
		for (;;) {
			
			i++;
			yaku = 0;
			
			for (j = 1; j <= i; j++) {
				
				if (i % j == 0) yaku++;
				
			}
			
			if (yaku == 2) c++;
			
			if (c == 10001) {
				
				System.out.print(i);
				break;
				
			}
			
		}
		
	}
	
}