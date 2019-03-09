# JAVA加解密

* [1、BASE64](#1、BASE64)
* [2、MD5](#2、MD5)
* [3、SHA](#3、SHA)
* [4、对称加密AES](#4、对称加密AES)
* [5、非对称加密RSA](#5、非对称加密RSA)

<a name="1、BASE64"></a>
### 1、BASE64 ###

- Base64是一种用64个字符来表示任意二进制数据的方法。['A', 'B', 'C', ... 'a', 'b', 'c', ... '0', '1', ... '+', '/']
- Base64是网络上最常见的用于传输8Bit字节代码的编码方式之一。
- BASE64的加密解密是双向的，**可以求反解**。
- BASE64 严格地说，属于编码格式，而非加密算法 ，主要就是**BASE64Encoder、BASE64Decoder**两个类。
- BASE对二进制数据进行处理，每3个字节一组，一共是3x8=24bit，划为4组。加密后产生的字节位数是8的倍数，如果不够位数以**=**符号填充，解码的时候，会自动去掉。
- 常见于邮件、http加密，截取http信息，你就会发现登录操作的用户名、密码字段通过BASE64加密的。

> 例子

```Java
package com.hdc.baseEncrytion;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import java.io.IOException;

/**
 * base64 加密解密是双向的，可以求反解
 */
public class CreateBase64 {

    /**
     * base64 解密
     * @param key
     * @return
     * @throws Exception
     */
    public static byte[] decrytBase64(String key) throws Exception {
        BASE64Decoder base64Decoder = new BASE64Decoder();
        byte[] buffer = base64Decoder.decodeBuffer(key);
        return buffer;
    }

    /**
     * base64 加密
     * @param b
     * @return
     */
    public static String encritBase64(byte[] b){
        BASE64Encoder base64Encoder = new BASE64Encoder();
        String result = base64Encoder.encodeBuffer(b);
        return result;
    }

    public static void main(String[] args) {
        String str = "123456asdhdjashdfjkads";
        String result1 = encritBase64(str.getBytes());
        System.out.println("加密数据："+result1);

        try {
            byte[] buffer = decrytBase64(result1);
            String result2 = new String(buffer);
            System.out.println("解密数据："+result2);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}

加密数据：MTIzNDU2YXNkaGRqYXNoZGZqa2Fkcw==
解密数据：123456asdhdjashdfjkads
```

<a name="2、MD5"></a>
### 2、MD5 ###

- MD5(Message Digest algorithm 5，信息摘要算法)用于确保信息传输完整一致，常用于**文件校验**。
- MD5加密就是把一个任意长度的字节串变换成一**定长**的十六进制数字串，**不可逆**。
- 通常我们不直接使用上述MD5加密，而是将MD5产生的字节数组交给BASE64再加密一把，得到相应的字符串。

> 例子  
> 使用字节直接转十六进制后加密

```java
package com.hdc.baseEncrytion;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class CreateMd5 {
    public static void main(String[] args) {
        String result = enctyptionPasswd("123456789","test");
        System.out.println("MD5加密后的数据："+ result);
    }
    //公盐
    private static final String PUBLIC_SALT = "hello";

    //十六进制下数字到字符的映射数组
    private final static String[] hexDigits = {"0", "1", "2", "3", "4",
            "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"};

    /**
     * 用户密码加密，盐值为 ：私盐+公盐
     * @param  passwd 密码
     * @param  salt 私盐
     * @return  MD5加密字符串
     */
    public static String enctyptionPasswd(String passwd,String salt ){
        return encodeByMD5(PUBLIC_SALT + passwd + salt);
    }

    /**
     * md5 加密算法
     * @param originString
     * @return 返回加密后的md5 值
     */
    private static String encodeByMD5(String originString){
        String resultString = "";
        if (originString != null){
            try {
                //创建一个提供信息摘要算法的对象，初始化为 baseEncrytion 算法对象
                MessageDigest messageDigest = MessageDigest.getInstance("MD5");
                //初始化为 SHA1 算法对象
//                MessageDigest messageDigest = MessageDigest.getInstance("SHA1");

                //将消息变成byte数组
                byte[] results = messageDigest.digest(originString.getBytes());

                //将字节数组转换成字符串返回
                resultString = byteArrayToHexString(results).toString().toUpperCase();

            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
        }
                return resultString;
    }

    /**
     * 转换字节为十六进制字符串
     * 一个字节是八个二进制，即2个十六进制
     * @param results 字节数组
     * @return 十六进制字符串
     */
    private static String byteArrayToHexString(byte[] results) {

        StringBuffer stringBuffer = new StringBuffer();
        for (int i = 0; i < results.length; i++) {
            // 取出这个字节的高4位，然后与0x0f【15】与运算，得到一个0-15之间的数据,即高位的16进制数
            stringBuffer.append(hexDigits[(results[i] >> 4) & 0x0f]);
            // 取出这个字节的低位，与0x0f与运算，得到一个0-15之间的数据,即低位的16进制数
            stringBuffer.append(hexDigits[results[i] & 0x0f]);
        }
            return stringBuffer.toString();
    }
```


​	
	}

> 使用BigInteger转十六进制后加密

	package com.hdc.baseEncrytion;
	
	import java.math.BigInteger;
	import java.security.MessageDigest;
	import java.security.NoSuchAlgorithmException;
	
	public class MD5 {
	
	    public static void main(String[] args) {
	        String key = "helalo123456789test";
	        String result = encrytMD5(key);
	        System.out.println("MD5加密:"+result.toUpperCase());
	    }
	    public static String encrytMD5(String key){
	        //不可变的任意精度的整数 BigInteger
	        BigInteger bigInteger = null;
	        try {
	            //获取 MessageDigest 对象，参数为 MD5 字符串，表示这是一个 MD5 算法
	            MessageDigest messageDigest = MessageDigest.getInstance("MD5");
	            
	            //update(byte[])方法，输入原数据,类似StringBuilder对象的append()方法，追加模式
	            messageDigest.update(key.getBytes());
	            
	            //将byte 数组转换为 BigInteger
	            bigInteger = new BigInteger(messageDigest.digest());
	
	        } catch (NoSuchAlgorithmException e) {
	            e.printStackTrace();
	        }
	        //返回此 BigInteger 的给定基数【进制数】的字符串表示形式
	        return bigInteger.toString(16);
	    }
	}

> 使用DigestUtils工具加密

	package com.hdc.baseEncrytion;
	
	import org.apache.commons.codec.digest.DigestUtils;
	
	import java.util.Arrays;
	
	/**
	 * 需要引入 commons-codec jar包
	 * @Author: HDC
	 * @Date: Create in 2018/1/5 10:35
	 */
	public class DigestUtilsDemo {
	
	    public static void main(String[] args) {
	
	        String key = "helalo123456789test";
	        byte[] bytes = DigestUtils.md5(key);
	        System.out.println(Arrays.toString(bytes));
	        String md5 = DigestUtils.md5Hex(key);
	        System.out.println("MD5加密值："+md5);
	
	        String sha = DigestUtils.sha256Hex(key);
	        System.out.println("sha256加密："+sha);
	    }


​	
	}

> BigInteger

	不可变的任意精度的整数，提供所有 Java 的基本整数操作符的对应物，并提供 java.lang.Math 的所有相关方法【参考API】
	
	1. String toString() 
		返回此 BigInteger 的十进制字符串表示形式。
	 
	2. String toString(int radix) 
		返回此 BigInteger 的给定基数的字符串表示形式。 
	
	3. String toString(16)
		返回十六进制字符串 
	
	4.BigInteger(byte[] val) 
		将包含 BigInteger 的二进制补码表示形式的 byte 数组转换为 BigInteger

> MD5算法特点

	1. 压缩性：任意长度的数据，算出的MD5值长度都是固定的。
	2. 容易计算：从原数据计算出MD5值很容易。
	3. 抗修改性：对原数据进行任何改动，哪怕只修改1个字节，所得到的MD5值都有很大区别。
	4. 弱抗碰撞：已知原数据和其MD5值，想找到一个具有相同MD5值的数据（即伪造数据）是非常困难的。
	5. 强抗碰撞：想找到两个不同的数据，使它们具有相同的MD5值，是非常困难的。

<a name="3、SHA"></a>
### 3、SHA ###

- SHA(Secure Hash Algorithm，安全散列算法)主要适用于数字签名标准（Digital Signature Standard DSS）里面定义的数字签名算法（Digital Signature Algorithm DSA），**不可逆**。
- 接收一段明文，然后以一种不可逆的方式将它转换成一段（通常更小）密文，也可以简单的理解为取一串输入码（称为预映射或信息），并把它们转化为长度较短、位数固定的输出序列即散列值（也称为信息摘要或信息认证代码）的过程。

> 例子

	package com.hdc.baseEncrytion;
	
	import java.math.BigInteger;
	import java.security.MessageDigest;
	
	public class CreateSHA {
	    public static final String KEY_SHA = "SHA";
	
	    public static String encrytSHA(String inputStr) {
	        BigInteger bigInteger = null;
	        System.out.println("加密前的数据:" + inputStr);
	        try {
	            MessageDigest messageDigest = MessageDigest.getInstance(KEY_SHA);
	            messageDigest.update(inputStr.getBytes());
	            bigInteger = new BigInteger(messageDigest.digest());
	            System.out.println("SHA加密后:" + bigInteger.toString(32));
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return bigInteger.toString(32);
	    }
	
	    public static void main(String args[]) {
	        try {
	            String inputStr = "简单加密123456789test";
	            encrytSHA(inputStr);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}

<a name="4、对称加密AES"></a>
### 4、对称加密AES ###

> 特点

	发送者构建密钥，发布密钥给接收者；
	发送者使用密钥对数据进行加密发送，接收者使用密钥对数据进行解密。

> 实例

	import org.apache.commons.codec.binary.Base64;
	
	import javax.crypto.*;
	import javax.crypto.spec.SecretKeySpec;
	import java.security.InvalidKeyException;
	import java.security.Key;
	import java.security.NoSuchAlgorithmException;
	
	/**
	 * AES 对称加密算法
	 *
	 * Create By HuangDongChang In 2018/5/7
	 */
	public class AesDemo {
	
	    private static String SALT = "this is test";
	    private static String CIPER_STRING = "AES/ECB/PKCS5Padding";
	
	    /**
	     * 生成KEY
	     */
	    public static Key getAESKey() throws NoSuchAlgorithmException {
	
	        KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
	        keyGenerator.init(128);
	        SecretKey secretKey = keyGenerator.generateKey();
	        byte[] secretKeyEncoded = secretKey.getEncoded();
	
	        //key 转换
	         return new SecretKeySpec(secretKeyEncoded,"AES");
	    }
	
	    /**
	     * 加密
	     * @param key  加解密key
	     */
	    public static byte[] encodeAES(Key key){
	
	        byte[] result = null;
	        try {
	            Cipher cipher = Cipher.getInstance(CIPER_STRING);
	            cipher.init(Cipher.ENCRYPT_MODE,key);
	            result = cipher.doFinal(SALT.getBytes());
	
	        } catch (NoSuchAlgorithmException e) {
	            e.printStackTrace();
	        } catch (NoSuchPaddingException e) {
	            e.printStackTrace();
	        } catch (BadPaddingException e) {
	            e.printStackTrace();
	        } catch (IllegalBlockSizeException e) {
	            e.printStackTrace();
	        } catch (InvalidKeyException e) {
	            e.printStackTrace();
	        }
	        return result;
	    }
	
	    /**
	     * 解密
	     * @param key 加解密key
	     * @param encodeInfo 加密数据
	     */
	    public static byte[] decodeAES(Key key,byte[] encodeInfo){
	
	        byte[] result = null;
	        try {
	            Cipher cipher = Cipher.getInstance(CIPER_STRING);
	            cipher.init(Cipher.DECRYPT_MODE,key);
	            result = cipher.doFinal(encodeInfo);
	
	        } catch (NoSuchAlgorithmException e) {
	            e.printStackTrace();
	        } catch (NoSuchPaddingException e) {
	            e.printStackTrace();
	        } catch (BadPaddingException e) {
	            e.printStackTrace();
	        } catch (IllegalBlockSizeException e) {
	            e.printStackTrace();
	        } catch (InvalidKeyException e) {
	            e.printStackTrace();
	        }
	        return result;
	    }
	
	    public static void main(String[] args) {
	        try {
	            Key key = getAESKey();
	            byte[] encodeInfo = encodeAES(key);
	            System.out.println("AES 加密："+ Base64.encodeBase64String(encodeInfo));
	            byte[] bytes = decodeAES(key, encodeInfo);
	            System.out.println("AES 解密：" + new String(bytes));
	        } catch (NoSuchAlgorithmException e) {
	            e.printStackTrace();
	        }
	    }
	}


<a name="5、非对称加密RES"></a>
### 5、非对称加密RES ###

> 特点

	公钥加密，使用私钥解密；
	私钥加密，使用公钥解密；
	
	1024位的证书，加密时最大支持117个字节，解密时为128；
	2048位的证书，加密时最大支持245个字节，解密时为256。

> 作用

	数据加密；数字签名。

> 实例

	import org.apache.commons.codec.binary.Base64;
	import org.apache.commons.codec.binary.Hex;
	
	import javax.crypto.BadPaddingException;
	import javax.crypto.Cipher;
	import javax.crypto.IllegalBlockSizeException;
	import javax.crypto.NoSuchPaddingException;
	import java.security.*;
	import java.security.interfaces.RSAPrivateKey;
	import java.security.interfaces.RSAPublicKey;
	import java.security.spec.InvalidKeySpecException;
	import java.security.spec.PKCS8EncodedKeySpec;
	import java.security.spec.X509EncodedKeySpec;


​	
	/**
	 * Create By HuangDongChang In 2018/5/4
	 */
	public class RsaDemo {
	
	    private static final String SALT = "this is test";
	    private static final String publicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgVxX8coEu9gxev5GzYJMfriv5sltOakXi1QEAL72RU+JAWznyjA5SsAVdhG4cRG9SKQYT8mKjDkgzmnUVMjWHHI8mtVdNxwSy0BJ03pcNJgNwhxE/UcrSKT3bLpGpbCyn2VR7gRry/gC0dsoA+vEM0RFuVpqzCZ0nu6JL/4Z35OfIxJhPNECeZpHicGit/GdHyUEeQylGKvf0+rJAIKuf3dQSIAFUUGLtDm1vzKiwkLTOaW4XjfD0Mid+fxTrcN/gCzt+LqhAJyqAzTj59n2i5/OooBkW23KoiZrjGsDptU5u39GT7EsxbR4jvfwqpSxbcsOJjB5IcJaY4dNeC1lCwIDAQAB";
	    private static final String privateKey =
	            "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCBXFfxygS72DF6/kbNgkx+uK/myW05qReLVAQAvvZFT4kBbOfKMDlKwBV2EbhxEb1IpBhPyYqMOSDOadRUyNYccjya1V03HBLLQEnTelw0mA3CHET9RytIpPdsukalsLKfZVHuBGvL+ALR2ygD68QzREW5WmrMJnSe7okv/hnfk58jEmE80QJ5mkeJwaK38Z0fJQR5DKUYq9/T6skAgq5/d1BIgAVRQYu0ObW/MqLCQtM5pbheN8PQyJ35/FOtw3+ALO34uqEAnKoDNOPn2faLn86igGRbbcqiJmuMawOm1Tm7f0ZPsSzFtHiO9/CqlLFtyw4mMHkhwlpjh014LWULAgMBAAECggEAIyiJ7nlNmBBGQnthmvFTAQ4JINyWBxniAEgxXlKIdIYNYonK5bT9nUdfjdt7GaAMpfWTdfv83+eW9wLkZra/GrQhrKNY1mWW5g7vAb872D+LXbp5Na1mIjRT2wU1tkq0AYZ0IhCpi6I4gfjig05M4PIpURs1845wG9IRDy4ssgr2DgSQF+f7jN6Li12+yHn3UsWHsYCnWlA7h5dwUoOGqIt50DztAPFFNdznAVPPz4JJzNNR3iPK6cuX7XoGRabmWGBSmuDcKE+WXcKgzuWIk23qEXAPO95K2Nnuvh8728giT2w0lfLXZm2Ev4QFK+QCVUTxQMROj3K0ntweOaTxYQKBgQDCfH9/CzwNoaHC9tAHpqXx6NaFY48yYNVz6aHm57BnTAR0wmmfkS/A5+DLxBRMDpwvDIKkRQcFvcjlbSw+aBqtLU1ZhcJmlJ0B/lLodLxAqz8Yhj2VxiiyQ8HCGkVEFyfwQZRA9OziFuQ5Flt+6v70hZQ3Dfb9XxbkKaEA+nifJQKBgQCqRqTY7mAwY+1b5s1bR6ty62LBNei1/tfGWTJKhupoJC7twIPIJSkaFqaR0Vc8nIKTodMDwB2VWVRvdznssHUyOfEvrolJo8RYqhfBXRBhaSqmXhz4Jh7/i68AXnUrilSbv/Ydwa5PuUNpMYsSmtUPJ+w9hBwO/n97Q0J+/7OUbwKBgC89rH6AjRrGixNfflKNcTuckhcegtb63H5mXrRGzPuaZG60FpHy40WZTWpRe5ip59gp0sXyGm2Tluvbo+aYxPoRyfsX2YuvR6AHVb4vNNcEgbQET4tE8fezK6ppVS/f7AyY8VkB5VRZuSAAxULD9CATHlhtJPSQl2/eiMRDEu+dAoGAT5xB3I7u+BDwW+R4JPJITa2R+YWr7NNerQTtB302wUQRkOVOd9gv9Fucu1Zl9Be00TN6xikfa8FdQdQ7h9ckpDwE8Ocolv5zgYTdIHHTg8e4whoEb1zbZ102j/SZ0aaWUk+Y0WbJicqzos4gGK29aZ2fzU8kEzqX/dh/kYMZwg8CgYEAijjJ3FynkKSHeV4mfG4O7tuwUY0CYd1hMfHhEH6s0ktwM1M9wHkq3CyLgQD1exBnLQCzx74hxw3vu4YjUZb4TkHF1hQqiwmiuTPzn2R24cBtElfsHh4imTqpY/NORT8ozpeBCW7nGFZL29FWISwcAdhhlDcRxCepcCr7zaAD4Ac=";
	
	    /**
	     * 1、初始化密钥,设置秘钥长度
	     * 获取密钥对;
	     * 获取公钥、私钥; rsaPublicKey/rsaPrivateKey
	     * 保存公钥、私钥,保存形式：基本为先编码成byte[]再保存为字符串形式
	     *
	     */
	    public static void init(){
	        try {
	            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
	            keyPairGenerator.initialize(1024);
	            KeyPair keyPair = keyPairGenerator.generateKeyPair();
	            RSAPublicKey rsaPublicKey = (RSAPublicKey) keyPair.getPublic();
	            RSAPrivateKey rsaPrivateKey = (RSAPrivateKey) keyPair.getPrivate();
	            System.out.println("公钥="+ Base64.encodeBase64String(rsaPublicKey.getEncoded()));
	            System.out.println("私钥="+ Base64.encodeBase64String(rsaPrivateKey.getEncoded()));
	
	        } catch (NoSuchAlgorithmException e) {
	            e.printStackTrace();
	        }
	    }
	
	    /**
	     * KeyFactory可以来加载相应的公钥和私钥
	     * 公钥加载 使用 X509EncodedKeySpec(byte[]);
	     * 私钥加载 使用 PCKS8EncodedKeySpec(byte[])
	     *
	     * 私钥加密，公钥解密
	     *
	     */
	    public static void PripuRSA(byte[] rsaPrivateKey,byte[] rsaPublicKey){
	        try {
	            //2、私钥加密，公钥解密-- 加密
	            PKCS8EncodedKeySpec pkcs8EncodedKeySpec = new PKCS8EncodedKeySpec(rsaPrivateKey);
	            //指定加密算法
	            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
	            PrivateKey privateKey = keyFactory.generatePrivate(pkcs8EncodedKeySpec);
	            //创建Cipher 使用RSA
	            Cipher cipher = Cipher.getInstance("RSA");
	            cipher.init(Cipher.ENCRYPT_MODE,privateKey);
	            byte[] result = cipher.doFinal(SALT.getBytes());
	            System.out.println("私钥加密，公钥解密 -- 加密："+Base64.encodeBase64String(result));
	
	            //3、私钥加密，公钥解密-- 解密
	            X509EncodedKeySpec x509EncodedKeySpec = new X509EncodedKeySpec(rsaPublicKey);
	            keyFactory = KeyFactory.getInstance("RSA");
	            PublicKey publicKey = keyFactory.generatePublic(x509EncodedKeySpec);
	            cipher = Cipher.getInstance("RSA");
	            cipher.init(Cipher.DECRYPT_MODE,publicKey);
	            if (result != null){
	                result = cipher.doFinal(result);
	                System.out.println("私钥加密，公钥解密 -- 解密："+ new String(result));
	            }
	
	        } catch (NoSuchAlgorithmException|InvalidKeySpecException|NoSuchPaddingException|
	                BadPaddingException|IllegalBlockSizeException|InvalidKeyException e) {
	            e.printStackTrace();
	        }
	    }
	
	    /**
	     * 公钥加密，私钥解密
	     */
	    private static void PupriRSA(byte[] rsaPublicKey,byte[] rsaPrivateKey){
	        try {
	            // 4、公钥加密，私钥解密 -- 加密
	            X509EncodedKeySpec x509EncodedKeySpec = new X509EncodedKeySpec(rsaPublicKey);
	            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
	            PublicKey publicKey = keyFactory.generatePublic(x509EncodedKeySpec);
	            Cipher cipher = Cipher.getInstance("RSA");
	            // 使用公钥加密
	            cipher.init(Cipher.ENCRYPT_MODE,publicKey);
	            byte[] result = cipher.doFinal(SALT.getBytes());
	            System.out.println("公钥加密，私钥解密 -- 加密："+ Base64.encodeBase64String(result));
	
	            //5、公钥加密，私钥解密 -- 解密
	            PKCS8EncodedKeySpec pkcs8EncodedKeySpec = new PKCS8EncodedKeySpec(rsaPrivateKey);
	            keyFactory = KeyFactory.getInstance("RSA");
	            PrivateKey privateKey = keyFactory.generatePrivate(pkcs8EncodedKeySpec);
	            cipher = Cipher.getInstance("RSA");
	            // 使用私钥解密
	            cipher.init(Cipher.DECRYPT_MODE,privateKey);
	            result = cipher.doFinal(result);
	            System.out.println("公钥加密，私钥解密 -- 解密："+ new String(result));
	
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	
	    /**
	     * 使用私钥加密，生成签名
	     * 执行数字签名
	     */
	    public static byte[] sign(byte[] rsaPrivateKey){
	        byte[] result = null;
	        try {
	            PKCS8EncodedKeySpec pkcs8EncodedKeySpec = new PKCS8EncodedKeySpec(rsaPrivateKey);
	            // 使用RSA 算法创建 KeyFactory 对象
	            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
	            PrivateKey privateKey = keyFactory.generatePrivate(pkcs8EncodedKeySpec);
	            // 使用 MD5withRSA 算法创建签名对象 Signature
	            Signature signature = Signature.getInstance("MD5withRSA");
	            signature.initSign(privateKey);
	            // 加载 签名的信息
	            signature.update(SALT.getBytes());
	            // 执行签名
	            result = signature.sign();
	            System.out.println("rsa 签名："+ Hex.encodeHexString(result));
	
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return result;
	    }
	
	    /**
	     * 使用公钥解密
	     * 验证签名
	     */
	    public static void verifySign(byte[] result,byte[] rsaPublicKey){
	        try {
	            X509EncodedKeySpec x509EncodedKeySpec = new X509EncodedKeySpec(rsaPublicKey);
	            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
	            PublicKey publicKey = keyFactory.generatePublic(x509EncodedKeySpec);
	            Signature signature = Signature.getInstance("MD5withRSA");
	            signature.initVerify(publicKey);
	            signature.update(SALT.getBytes());
	            // 验证签名
	            boolean verify = signature.verify(result);
	            System.out.println("rsa 验证签名："+verify);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	
	    public static void main(String[] args) {
	        byte[] publicKeyCode = Base64.decodeBase64(publicKey);
	        byte[] privateKeyCode = Base64.decodeBase64(privateKey);
	        PripuRSA(privateKeyCode,publicKeyCode);
	//        PupriRSA(publicKeyCode,privateKeyCode);
	
	//        byte[] sign = sign(privateKeyCode);
	//        verifySign(sign,publicKeyCode);
	    }
	}


