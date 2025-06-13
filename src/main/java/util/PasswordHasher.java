package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

//비밀번호를 안전하게 저장하기 위해 알고리즘 SHA-256으로 해시 처리하는 클래스
public class PasswordHasher {

    public static String encrypt(String input) {
        try {
        	 // SHA-256 해시 알고리즘 사용
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(input.getBytes());

         // 바이트 배열을 16진수 문자열로 변환
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');// 한 자리 수는 앞에 0 붙임
                hexString.append(hex);
            }
            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("암호화 실패", e);
        }
    }
} 
