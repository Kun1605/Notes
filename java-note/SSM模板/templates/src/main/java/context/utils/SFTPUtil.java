package com.msymobile.mobile.context.utils;

import com.jcraft.jsch.*;
import com.sungness.core.util.DateUtil;
import com.sungness.core.util.DateUtilExt;
import org.apache.commons.io.IOUtils;
import org.jsoup.helper.StringUtil;
import org.slf4j.*;

import java.io.*;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Vector;

/**
 * User: hk
 * Date: 2017/8/10 下午4:31
 * version: 1.0
 */
public class SFTPUtil {
    private static final org.slf4j.Logger log = LoggerFactory.getLogger(SFTPUtil.class);

    private ChannelSftp sftp;

    private Session session;
    /**
     * SFTP 登录用户名
     */
    private String username;
    /**
     * SFTP 登录密码
     */
    private String password;
    /**
     * 私钥
     */
    private String privateKey;
    /**
     * SFTP 服务器地址IP地址
     */
    private String host;
    /**
     * SFTP 端口
     */
    private int port;

    private final static String SEND_DIR = "SENDED";
    private final static String RESULT_DIR = "RESULT";

    /**
     * 构造基于密码认证的sftp对象
     */
    public SFTPUtil(String username, String password, String host, int port) {
        this.username = username;
        this.password = password;
        this.host = host;
        this.port = port;
    }

    /**
     * 连接sftp服务器
     */
    public void login() {
        try {
            JSch jsch = new JSch();
            if (privateKey != null) {
                jsch.addIdentity(privateKey);// 设置私钥
            }

            session = jsch.getSession(username, host, port);

            if (password != null) {
                session.setPassword(password);
            }
            Properties config = new Properties();
            config.put("StrictHostKeyChecking", "no");

            session.setConfig(config);
            session.connect();

            Channel channel = session.openChannel("sftp");
            channel.connect();

            sftp = (ChannelSftp) channel;
        } catch (JSchException e) {
            log.warn("SFTP登陆失败,重试");
            e.printStackTrace();
            login();
        }
    }

    /**
     * 关闭连接 server
     */
    public void logout() {
        if (sftp != null) {
            if (sftp.isConnected()) {
                sftp.disconnect();
            }
        }
        if (session != null) {
            if (session.isConnected()) {
                session.disconnect();
            }
        }
    }


    /**
     * 将输入流的数据上传到sftp作为文件。文件完整路径=basePath+directory
     *
     * @param basePath     服务器的基础路径
     * @param directory    上传到该目录
     * @param sftpFileName sftp端文件名
     */
    public void upload(String basePath, String directory, String sftpFileName, InputStream input) throws SftpException {
        try {
            sftp.cd(basePath);
        } catch (SftpException e) {
            //目录不存在，则创建文件夹
            String[] dirs = directory.split("/");
            String tempPath = basePath;
            for (String dir : dirs) {
                if (null == dir || "".equals(dir)) continue;
                tempPath += "/" + dir;
                try {
                    sftp.cd(tempPath);
                } catch (SftpException ex) {
                    sftp.mkdir(tempPath);
                    sftp.cd(tempPath);
                }
            }
        }
        sftp.put(input, sftpFileName);  //上传文件
    }


    /**
     * 下载文件。
     *
     * @param directory    下载目录
     * @param downloadFile 下载的文件
     * @param saveFile     存在本地的文件
     */
    public void download(String directory, String downloadFile, File saveFile) throws SftpException, FileNotFoundException {
        if (directory != null && !"".equals(directory)) {
            sftp.cd(directory);
        }
//        File file = new File(saveFile);
        sftp.get(downloadFile, new FileOutputStream(saveFile));
    }

    /**
     * 下载文件
     *
     * @param directory    下载目录
     * @param downloadFile 下载的文件名
     * @return 字节数组
     */
    public byte[] download(String directory, String downloadFile) throws SftpException, IOException {
        if (directory != null && !"".equals(directory)) {
            sftp.cd(directory);
        }
        InputStream is = sftp.get(downloadFile);

        byte[] fileData = IOUtils.toByteArray(is);

        return fileData;
    }


    /**
     * 删除文件
     *
     * @param directory  要删除文件所在目录
     * @param deleteFile 要删除的文件
     */
    public void delete(String directory, String deleteFile) throws SftpException {
        sftp.cd(directory);
        sftp.rm(deleteFile);
    }

    /**
     * 列出目录下的文件
     *
     * @param directory 要列出的目录
     */
    public Vector<?> listFiles(String directory) throws SftpException {
        return sftp.ls(directory);
    }

    //上传文件测试
    public static void main(String[] args) throws SftpException, IOException {
        SFTPUtil sftp = new SFTPUtil("dyuser4","rktaV%3rZ","219.148.199.17",22);
//        SFTPUtil sftp = new SFTPUtil("web","TVm{icBb0iBOf}JuUh]LuStE9","47.93.80.50",6810);
        sftp.login();
        File file = new File("E:\\test\\20180818161333.txt");
        InputStream is = new FileInputStream(file);
        String sftpFileName = "20180818161333.txt";

//        System.out.print(DateUtilExt.format(DateUtilExt.getTimestamp(),"yyyyMMddHHmmss"));
//        sftp.upload("/opt/netpromotion/dyuser4",null, sftpFileName, is);
//        sftp.download("/opt/netpromotion/dyuser4","20180817151801.in","E:\\test\\20180817151801.in");
        sftp.upload("/home/web/","", sftpFileName, is);

        String resultFileName = "20180817151801.out";
        File result_file = new File("C:\\Users\\hdc\\Desktop\\20180817151801.out");
        InputStream result_is = new FileInputStream(result_file);
        //日期文件夹
        String fileName = DateUtilExt.format(DateUtilExt.getTimestamp(),"yyyyMMdd");
        //上传发完的文件
        sftp.upload("/home/web/",fileName + "/" + SEND_DIR, sftpFileName, is);
        //上传返回结果文件
        sftp.upload("/home/web/",fileName + "/" + RESULT_DIR, resultFileName, result_is);
//        sftp.download("/home/web","20180817151801.in","E:\\test\\20180817151801.in");
//        sftp.delete("/home/hdc","20180817151801.in");

        sftp.logout();
    }
}
