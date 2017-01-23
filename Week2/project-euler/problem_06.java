public class problem_06 {
		
	public static void main(String[] args) {
		
		int i = 0;
		int result1 = 0;
		int result2 = 0;
		int work;
		int result = 0;
		
		for (i = 1; i <= 100; i ++) {
			
		result1 += i * i;
		result2 += i;
			
			
		}
		
		work = result2 * result2;
		
		result = work - result1;
		
		System.out.print(result);
		
	}
}
