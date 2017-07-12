
public class test {

public static long createTime(){
		
		return System.currentTimeMillis();
		
	}
	public static void main(String[] args) throws Exception{
	//	System.out.println(md5("123456"));
////		System.out.println(md5("12354654676dfdfdfdf"));
//		System.out.println(createId());
//		System.out.println(createId());
		System.out.println(createTime());//1
		int i;
		for( i=0;i<1000;i++){
			
		}
		System.out.println(i);
		System.out.println(createTime());//2
      for( i=0;i<1000;i++){
			
		}
        System.out.println(i);
		System.out.println(createTime());//3
      for( i=0;i<1000;i++){
			
		}
		
		System.out.println(i);
		System.out.println(createTime());//4
	}
//	1499324803671
//	1000
//	1499324803672
//	1000
//	1499324803673
//	1000
//	1499324803674
}
