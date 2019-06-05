package com.event.evengers_v2.userClass;

import java.util.Random;

public class TempKey {
	private int size;
	private boolean lowerCheck;

	public int getKey(int size, boolean lowerCheck) {
		this.size = size;
		this.lowerCheck = lowerCheck;
		return random();
	}

	public int random() {

		Random ran = new Random();
		StringBuffer sb = new StringBuffer();

		int num = 0;

		do {
			num = ran.nextInt(100) + 2;

			if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
				sb.append((char) num);
			} else {
				continue;
			}
		} while (sb.length() < size);

		return num;
	}
}
