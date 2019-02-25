package com.hdc.util;

import org.apache.commons.lang3.StringUtils;
import org.csource.common.MyException;
import org.csource.common.NameValuePair;
import org.csource.fastdfs.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author HuangDongChang
 * @date 2018/12/13
 */
public class FastDFSUtil {
    private static final Logger log = LoggerFactory.getLogger(FastDFSUtil.class);

    private TrackerServer trackerServer = null;
    private StorageServer storageServer = null;
    private StorageClient storageClient = null;

    public FastDFSUtil() {
    }

    public FastDFSUtil(String clientConfigFileName) {
        // 加载配置文件
        try {
            ClientGlobal.initByProperties(clientConfigFileName);
            this.init();
        } catch (IOException | MyException e) {
            e.printStackTrace();
            log.error("加载属性配置文件失败");
        }
    }

    /**
     * 初始化连接信息,获取连接
     */
    private void init() throws IOException {
        TrackerClient trackerClient = new TrackerClient();
        trackerServer = trackerClient.getConnection();
        storageClient = new StorageClient(trackerServer, storageServer);
    }

    /**
     * 上传文件
     * 根据文件路径
     */
    public String[] fileUpload(String filePath, String fileName) throws IOException, MyException {
        return fileUpload(null, filePath, fileName);
    }

    /**
     * 上传文件
     * 根据文件字节数组
     */
    public String[] fileUpload(byte[] fileBuff, String fileName) throws IOException, MyException {
        return fileUpload(fileBuff, null, fileName);
    }

    /**
     * 上传文件
     *
     * @param fileBuff 文件字节数组
     * @param filePath 文件路径
     * @param fileName 文件名称
     * @return 文件存储信息
     */
    private String[] fileUpload(byte[] fileBuff,
                                String filePath,
                                String fileName) throws IOException, MyException {
        try {
            if (fileBuff == null && filePath == null) {
                //长度为0的数组依然是数组(对象)
                return new String[0];
            }

            //文件后缀
            String suffix;
            if (StringUtils.isNotBlank(fileName) && fileName.contains(".")) {
                suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            } else {
                return new String[0];
            }
            // 设置图片元数据
            NameValuePair[] metaList = new NameValuePair[2];
            metaList[0] = new NameValuePair("fileName", fileName);
            metaList[1] = new NameValuePair("suffix", suffix);
            // 上传文件
            String[] uploadFile;
            if (fileBuff != null && fileBuff.length != 0) {
                uploadFile = storageClient.upload_file(fileBuff, suffix, metaList);
            } else {
                uploadFile = storageClient.upload_file(filePath, suffix, metaList);
            }
            return uploadFile == null ? new String[0] : uploadFile;
        } finally {
            if (trackerServer != null) {
                trackerServer.close();
            }
            if (storageServer != null) {
                storageServer.close();
            }
        }
    }

    /**
     * 下载文件
     * remoteFileName 要下载的文件[fastdfs中的文件名]
     */
    public String[] downloadFile(String filePath,
                                 String fileName,
                                 String groupName,
                                 String remoteFileName) throws IOException, MyException {
        FileOutputStream fileOutputStream = null;
        try {
            if (remoteFileName == null) {
                return new String[0];
            }
            File file = new File(filePath + "/" + fileName);
            if (!file.getParentFile().exists()) {
                boolean flag = file.getParentFile().mkdirs();
                if (!flag) {
                    log.debug("创建下载文件路径失败");
                }
            }

            //下载文件
            byte[] fileBuff = storageClient.download_file(groupName, remoteFileName);
            fileOutputStream = new FileOutputStream(file);
            fileOutputStream.write(fileBuff);

        } finally {
            if (fileOutputStream != null) {
                fileOutputStream.close();
            }
        }
        return new String[0];
    }

    /**
     * 删除文件
     * 成功返回 0，失败返回 非0
     */
    public int deleteFile(String groupName, String remoteFileName) throws IOException, MyException {

        if (StringUtils.isBlank(remoteFileName)) {
            return -1;
        }
        return storageClient.delete_file(groupName, remoteFileName);
    }

    /**
     * 获取元数据信息
     * 上传图片的时候，元数据若为空将无法生存-m的原数据文件,获取时此处将抛出NullPointerException
     */
    public Map<String,String> getMetaData(String groupName, String remoteFileName) throws IOException, MyException {

        Map<String,String> metaDataMap = new HashMap<>();
        NameValuePair[] getMetadata = storageClient.get_metadata(groupName, remoteFileName);
        for (NameValuePair nameValuePair : getMetadata) {
            log.info("name: " + nameValuePair.getName() + " value: " + nameValuePair.getValue());
            metaDataMap.put(nameValuePair.getName(),nameValuePair.getValue());
        }
        return metaDataMap;
    }

    /**
     * 获取文件信息
     */
    public FileInfo getFileInfo(String groupName, String remoteFileName) throws IOException, MyException {

        return storageClient.get_file_info(groupName, remoteFileName);
    }

	public static void main(String[] args) throws IOException, MyException {
        String filePath = "E:\\time.jpg";
        String configPath = "fastdfs_client.properties";
        FastDFSUtil fastDFSUtil = new FastDFSUtil(configPath);
        String[] result = fastDFSUtil.fileUpload(filePath, "123.png");
        StringBuilder stringBuilder = new StringBuilder();
        for (String str:result
             ) {
            stringBuilder.append(str).append("/");
        }
        System.out.println(stringBuilder.subSequence(0, stringBuilder.length()-1));
        // group1/M00/00/00/wKgBH1wcn3mAL53qAAROH5Zv2bY287.png
    }
    
}
