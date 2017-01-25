public class problem_01 {
		
	public static void main(String[] args) {
		
		int i = 0;
		int j = 0;
		
		for (i = 0; i < 1000; i ++) {
			
			if (i % 3 == 0 || i % 5 ==0) {
				
				j += i;
				
			}
			
		}
		
		System.out.print(j);
		
	}
}
