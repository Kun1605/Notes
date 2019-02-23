
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
