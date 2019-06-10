package com.event.evengers_v2.userClass;

public class DBException extends Exception {
	public DBException() {
		super("스프링은 RuntimeException (선택) 예외만 인정한다."
				+"필수 예외가 발생한 경우는 RuntimeException예외로 변환한다.");		
						//예외처리할때 메시지 날리는(super)
	}
}
