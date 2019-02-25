package com.msymobile.mobile.context.utils;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;

import javax.crypto.Cipher;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.security.*;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.HashMap;
import java.util.Map;


public class RSAUtil {

	/** *//**
	 * 加密算法RSA
	 */
	private static final String KEY_ALGORITHM = "RSA";


	private static final String CIPER_ALGORITHM = "RSA/ECB/PKCS1Padding";


	private static final String ALGORITHM_SHA1PRNG = "SHA1PRNG";

	/*****
	 * 签名算法
	 */
	private static final String SIGNATURE_ALGORITHM = "MD5withRSA";

	/** 获取公钥的key*/
	private static final String PUBLIC_KEY = "RSAPublicKey";


	/**
	 * 获取公钥的key
	 */
	private static final String PUBLIC_KEYS = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDK0gZoLfD2pb3mklRMAETmqA5ddC4N7g4k0TnBIlHsM7M/3J7ZrsDrfWPFsdQhp+tTBpjUmM9BMV3awRLNaFn7sBxu+yL9FtEcgtzyqxg/dT2glc1KLb0FLR9LXljPJ95zqmDmZsJDmE2MxMq9HTNQ9BWwV9t6h3kTBLx8wwhthQIDAQAB";


	public static final String PRIVATE_KEYS ="MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMrSBmgt8PalveaSVEwAROaoDl10Lg3uDiTROcEiUewzsz/cntmuwOt9Y8Wx1CGn61MGmNSYz0ExXdrBEs1oWfuwHG77Iv0W0RyC3PKrGD91PaCVzUotvQUtH0teWM8n3nOqYOZmwkOYTYzEyr0dM1D0FbBX23qHeRMEvHzDCG2FAgMBAAECgYBxwCE/xKRkcMh0zJTimzQJeS+1UjeSMHVWSNHvc+QmaUibBI1C4TPp30VZ10Z2KctdoVGNyrZShfFxgt+cvG3aL2pf5SFH9F0UikME2hPuBDRf8UjL8mmrFN+e4EKsUpiEpBvDor8QBgYSUZh9p+l+A3g7SX3g6+c8s3R0ZWaucQJBAOaRSE6mtQ3d4ZJqIg2gH6nldcGKFY6LIRIhtXyqbLqBud1flInT9pazujbIURRLIlwd1ADVSK6j4j+s//o+7UcCQQDhMTnJ7LbgRKguN0H3pQhrWiTwc3oxOPwaP1Xci1VTDp0Ehq868AJAfifczdtGSYJjU3+5KiwYdmib7pYmvETTAkBxuE51nHvIbxuG35oUJln3rhk6cCTZvX1+N+oPpu8hvkIyEaZtpIIHKnY59usmmzhDPuMF1iyXFnXM+kL25nqZAkEAjuXAyPy4E1od6q3P44jK7exW8mokyOVjPHiiUH/uFfV49+1Ldrfkhe5H91p94X02CzdqHiK/too02XYtu8jOVwJBAI4/4RfXVYq15yeIeN7Enn1qoYtw45zjclZ8S+1Tb/Equ4+fdylvAcHwiqrDDoFPee4CALh8Iopb/ql7boHjWYc=";


	/** *//**
	 * 获取私钥的key
	 */
	private static final String PRIVATE_KEY = "RSAPrivateKey";


	private static final int KEY_SIZE = 1024;

	/** *//**
	 * RSA最大加密明文大小
	 */
	private static final int MAX_ENCRYPT_BLOCK = 117;

	/** *//**
	 * RSA最大解密密文大小
	 */
	private static final int MAX_DECRYPT_BLOCK = 128;

	public static Map<String, Object> genKeyPair(String seed) throws Exception {
		KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance(KEY_ALGORITHM);
		SecureRandom random = SecureRandom.getInstance(ALGORITHM_SHA1PRNG);//如果使用SecureRandom random = new SecureRandom();//windows和linux默认不同，导致两个平台生成的公钥和私钥不同
		random.setSeed(seed.getBytes());//使用种子则生成相同的公钥和私钥
		keyPairGen.initialize(KEY_SIZE, random);
		KeyPair keyPair = keyPairGen.generateKeyPair();
		RSAPublicKey publicKey = (RSAPublicKey) keyPair.getPublic();//公钥
		RSAPrivateKey privateKey = (RSAPrivateKey) keyPair.getPrivate();//私钥
		Map<String, Object> keyMap = new HashMap<String, Object>(2);
		keyMap.put(PUBLIC_KEY, publicKey);
		keyMap.put(PRIVATE_KEY, privateKey);
		return keyMap;
	}

	public static String sign(byte[] data, String privateKey) throws Exception {
		byte[] keyBytes =Base64.decodeBase64(privateKey);
		PKCS8EncodedKeySpec pkcs8KeySpec = new PKCS8EncodedKeySpec(keyBytes);
		KeyFactory keyFactory = KeyFactory.getInstance(KEY_ALGORITHM);
		PrivateKey privateK = keyFactory.generatePrivate(pkcs8KeySpec);
		Signature signature = Signature.getInstance(SIGNATURE_ALGORITHM);
		signature.initSign(privateK);
		signature.update(data);
		return Base64.encodeBase64String(signature.sign());

	}

	public static boolean verify(byte[] data, String publicKey, String sign)
			throws Exception {
		byte[] keyBytes = Base64.decodeBase64(publicKey);
		X509EncodedKeySpec keySpec = new X509EncodedKeySpec(keyBytes);
		KeyFactory keyFactory = KeyFactory.getInstance(KEY_ALGORITHM);
		PublicKey publicK = keyFactory.generatePublic(keySpec);
		Signature signature = Signature.getInstance(SIGNATURE_ALGORITHM);
		signature.initVerify(publicK);
		signature.update(data);
		return signature.verify(Base64.decodeBase64(sign));
	}

	public static byte[] decryptByPrivateKey(byte[] encryptedData, String privateKey)
			throws Exception {
		byte[] keyBytes = Base64.decodeBase64(privateKey);
		PKCS8EncodedKeySpec pkcs8KeySpec = new PKCS8EncodedKeySpec(keyBytes);
		KeyFactory keyFactory = KeyFactory.getInstance(KEY_ALGORITHM);
		Key privateK = keyFactory.generatePrivate(pkcs8KeySpec);
		Cipher cipher = Cipher.getInstance(CIPER_ALGORITHM);
		cipher.init(Cipher.DECRYPT_MODE, privateK);
		int inputLen = encryptedData.length;
		byte[] result = new byte[(encryptedData.length/128 + 1 )*117];
		int offSet = 0;
		byte[] cache;
		int i = 0;
		int len=0;
		// 对数据分段解密
		while (inputLen - offSet > 0) {
			if (inputLen - offSet > MAX_DECRYPT_BLOCK) {
				cache = cipher.doFinal(encryptedData, offSet, MAX_DECRYPT_BLOCK);
			} else {
				cache = cipher.doFinal(encryptedData, offSet, inputLen - offSet);
			}
			i++;
			offSet = i * MAX_DECRYPT_BLOCK;
			for(byte b:cache){
				result[len++]=b;
			}
		}
		return result;
	}

	public static byte[] decryptByPublicKey(byte[] encryptedData, String publicKey)
			throws Exception {
		byte[] keyBytes = Base64.decodeBase64(publicKey);
		X509EncodedKeySpec x509KeySpec = new X509EncodedKeySpec(keyBytes);
		KeyFactory keyFactory = KeyFactory.getInstance(KEY_ALGORITHM);
		Key publicK = keyFactory.generatePublic(x509KeySpec);
		Cipher cipher = Cipher.getInstance(CIPER_ALGORITHM);
		cipher.init(Cipher.DECRYPT_MODE, publicK);
		int inputLen = encryptedData.length;
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		int offSet = 0;
		byte[] cache;
		int i = 0;
		// 对数据分段解密
		while (inputLen - offSet > 0) {
			if (inputLen - offSet > MAX_DECRYPT_BLOCK) {
				cache = cipher.doFinal(encryptedData, offSet, MAX_DECRYPT_BLOCK);
			} else {
				cache = cipher.doFinal(encryptedData, offSet, inputLen - offSet);
			}
			out.write(cache, 0, cache.length);
			i++;
			offSet = i * MAX_DECRYPT_BLOCK;
		}
		byte[] decryptedData = out.toByteArray();
		out.close();
		return decryptedData;
	}

	public static byte[] encryptByPublicKey(byte[] data, String publicKey)
			throws Exception {
		byte[] keyBytes = Base64.decodeBase64(publicKey);
		X509EncodedKeySpec x509KeySpec = new X509EncodedKeySpec(keyBytes);
		KeyFactory keyFactory = KeyFactory.getInstance(KEY_ALGORITHM);
		Key publicK = keyFactory.generatePublic(x509KeySpec);
		// 对数据加密
		Cipher cipher = Cipher.getInstance(CIPER_ALGORITHM);
		cipher.init(Cipher.ENCRYPT_MODE, publicK);
		int inputLen = data.length;
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		int offSet = 0;
		byte[] cache;
		int i = 0;
		// 对数据分段加密
		while (inputLen - offSet > 0) {
			if (inputLen - offSet > MAX_ENCRYPT_BLOCK) {
				cache = cipher.doFinal(data, offSet, MAX_ENCRYPT_BLOCK);
			} else {
				cache = cipher.doFinal(data, offSet, inputLen - offSet);
			}
			out.write(cache, 0, cache.length);
			i++;
			offSet = i * MAX_ENCRYPT_BLOCK;
		}
		byte[] encryptedData = out.toByteArray();
		out.close();
		return encryptedData;
	}

	public static String encryptStringByPrivateKey(byte[] data, String privateKey) throws Exception {
		return Base64.encodeBase64String(encryptByPrivateKey(data,privateKey));
	}

	public static byte[] encryptByPrivateKey(byte[] data, String privateKey)
			throws Exception {
		byte[] keyBytes = Base64.decodeBase64(privateKey);
		PKCS8EncodedKeySpec pkcs8KeySpec = new PKCS8EncodedKeySpec(keyBytes);
		KeyFactory keyFactory = KeyFactory.getInstance(KEY_ALGORITHM);
		Key privateK = keyFactory.generatePrivate(pkcs8KeySpec);
		Cipher cipher = Cipher.getInstance(CIPER_ALGORITHM);
		cipher.init(Cipher.ENCRYPT_MODE, privateK);
		int inputLen = data.length;
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		int offSet = 0;
		byte[] cache;
		int i = 0;
		// 对数据分段加密
		while (inputLen - offSet > 0) {
			if (inputLen - offSet > MAX_ENCRYPT_BLOCK) {
				cache = cipher.doFinal(data, offSet, MAX_ENCRYPT_BLOCK);
			} else {
				cache = cipher.doFinal(data, offSet, inputLen - offSet);
			}
			out.write(cache, 0, cache.length);
			i++;
			offSet = i * MAX_ENCRYPT_BLOCK;
		}
		byte[] encryptedData = out.toByteArray();
		out.close();
		return encryptedData;
	}

	public static String getPrivateKey(Map<String, Object> keyMap)
			throws Exception {
		Key key = (Key) keyMap.get(PRIVATE_KEY);
		return Base64.encodeBase64String(key.getEncoded());
	}

	public static String getPublicKey(Map<String, Object> keyMap)
			throws Exception {
		Key key = (Key) keyMap.get(PUBLIC_KEY);
		return Base64.encodeBase64String(key.getEncoded());
	}

	public static void main(String[] args) throws IOException {
		try {
			String seed = "abc123";//种子
			Map<String,Object> keyPair=genKeyPair(seed);

			String privateKey =getPrivateKey(keyPair);
			String publicKey = getPublicKey(keyPair);

			String pwd = "what a carry!";//原文

			pwd = URLDecoder.decode(pwd,"UTF-8");

			//encode
			byte[] b=encryptByPublicKey(pwd.getBytes("UTF-8"), PUBLIC_KEYS);


			String pwd_encoded=Base64.encodeBase64String(b);
			//decode
			System.out.println("密文："+pwd_encoded);

			String encode = "QAVuJBa8MS0pcLmOwpffWdr6tpOg1YE9lFj8GhGJz++lbxNwdQ/iK2RKUqV0GvIfFdUJNW8p/WQdz7dAa4CPlHKxQ9rhlYUvRSWqTpmc64b93sD/Vs3Uh0/r/Qxfp2WDyNdNushDJXWy2MHHmnX/nwzPQ8UkQ+4PvtscPC3C7KI=";


			String code =new String(decryptByPublicKey(Base64.decodeBase64(encode),PUBLIC_KEYS));

			System.out.println(code.trim());

		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	/**
	 * 将url参数转换成map
	 * @param param aa=11&bb=22&cc=33
	 * @return
	 */
	public static Map<String, Object> getUrlParams(String param) {
		Map<String, Object> map = new HashMap<String, Object>(0);

		if (StringUtils.isBlank(param)) {
			return map;
		}
		String[] params = param.split("&");
		for (int i = 0; i < params.length; i++) {
			String[] p = params[i].split("=");
			if (p.length == 2) {
				map.put(p[0], p[1]);
			}
		}
		return map;
	}





}
