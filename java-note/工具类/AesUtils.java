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
public class AesUtils {

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
