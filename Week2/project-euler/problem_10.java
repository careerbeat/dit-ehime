/*
 * ì¬“ú : 2017/01/23
 * ì¬Ò : –q Œ’“l
 * <ƒNƒ‰ƒXŠT—và–¾>
 *
 *
 */
package soc;

public class sosu {

	public static void main (String[] args) {

		System.out.println("sosu = " + sosu_sum(2));


	}


	//x‚ª‘f”‚©”»’è‚·‚é
//	static boolean isPrimeNum( int x ) {
//		
//		if (x <= 1) {
//			
//			return false;
//			
//		}
//
//		for (int i = 2; i < x; i++) {
//			
//			if (x % i == 0) {
//				
//				return false;
//			}
//		}
//
//		return true;
//	}
	static boolean isPrimeNum( int x ) {
	 if( x == 2 ) return true;
     if( x < 2 || x % 2 == 0 ) return false;
     for( int n = 3; n <= Math.sqrt((double)x); n += 2 )
         if( x % n == 0 ) return false;
     return true;
 }

	public static long sosu_sum(int sum) {

		long result = 0;
		
		try{
			
			for (int a = sum; a < 2000000; a++) {
	
				if(isPrimeNum(a)){
	
					System.out.println(a);
					result += a;
	
				}	
	
			}
		
		}
		
		catch (Exception e){
			System.out.println(e.toString());
		}

		return result;
		

	}

}
