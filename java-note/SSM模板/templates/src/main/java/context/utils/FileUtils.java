package com.msymobile.mobile.context.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Create By HuangDongChang On 2018/8/8
 */
public class FileUtils {

    private static Logger logger = LoggerFactory.getLogger(FileUtils.class);

    /**
     * 根据号码段导出所有的号码
     * @param phonePrefix   手机号码段
     * @param filePhoneNum 单个文件的号码个数
     */
    public static List<File> download(String phonePrefix,int filePhoneNum){
        long t = System.currentTimeMillis();

        //8个数组成的位数
        int phoneNum = 100000000;
        int num = phoneNum%filePhoneNum == 0 ? 0:1;
        int fileNum = phoneNum/filePhoneNum + num;
        List<File> files = new ArrayList<>();
        for (int i = 1; i <= fileNum ; i++) {
            String fileName = "a" + i + ".txt";
            File file = new File(fileName);
            files.add(file);
            try {
                OutputStreamWriter outputStreamWriter = new OutputStreamWriter(new FileOutputStream(file), StandardCharsets.UTF_8);
                Writer writer = new BufferedWriter(outputStreamWriter);
                // 处理数据边界
                int totalPhoneNum = filePhoneNum * (i) - phoneNum > 0 ? phoneNum : filePhoneNum * (i);
                IntStream.range(filePhoneNum * (i-1),totalPhoneNum )
                        .mapToObj(String::valueOf)
                        .map(s -> "00000000".substring(0, "00000000".length() - s.length()) + s + "\n") // 补0，换行
                        .forEach(s -> {
                            try {
                                writer.write(phonePrefix + s);
                            } catch (IOException e) {
                                throw new UncheckedIOException(e);
                            }
                        });
                writer.flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        logger.info("生成文件耗时：" + (System.currentTimeMillis() - t) + "ms");
        return files;
    }

    /**
     * 压缩文件成一个zip文件
     * @param srcFiles：源文件
     * @param out：完成文件的压缩
     */
    public static void zipFiles(List<File> srcFiles, ZipOutputStream out){
        byte[] buf = new byte[1024];
        try {
            for (File srcFile:srcFiles
                 ) {
                FileInputStream fis = new FileInputStream(srcFile);
                out.putNextEntry(new ZipEntry(srcFile.getName()));
                int len = 0;
                while ((len = fis.read(buf)) > 0) {
                    out.write(buf, 0, len);
                    out.flush();
                }
                out.closeEntry();
                fis.close();
            }
            logger.info("压缩完成.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
