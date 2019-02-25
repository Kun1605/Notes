package com.hdc.utils;

import java.io.*;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Create By HuangDongChang On 2018/8/10
 */
public class ZipUtils {

    private static final int BUFFER_SIZE = 1024;

    public ZipUtils(){}

    public static void compress(String srcFile, String zipFile) throws IOException {
        compress(new File(srcFile), new File(zipFile));
    }

    public static void compress(String srcFile, ZipOutputStream outputStream) throws IOException {
        compress(new File(srcFile), outputStream);
    }

    /**
     * 单个文件压缩
     *
     * @param srcFile：源文件
     * @param zipFile：压缩后的文件
     */
    public static void compress(File srcFile, File zipFile) throws IOException {
        ZipOutputStream out = null;
        try {
            out = new ZipOutputStream(new FileOutputStream(zipFile));
            compress(srcFile, out);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            assert out != null;
            out.close();
        }
    }

    /**
     * 判断是文件夹还是文件
     *
     * @param srcFile      源文件
     * @param outputStream zip输出流，完成文件或文件夹的压缩
     */
    public static void compress(File srcFile, ZipOutputStream outputStream) {
        if (srcFile.isDirectory()) {
            if (!srcFile.exists()) {
                return;
            }
            File[] files = srcFile.listFiles();
            compress(files, outputStream);
        } else {
            doZip(srcFile, outputStream);
        }
    }

    /**
     * 将单个文件压缩到zip输出流中
     *
     * @param srcFile      元文件
     * @param outputStream zip输出流，完成文件或文件夹的压缩
     */
    private static void doZip(File srcFile, ZipOutputStream outputStream) {
        byte[] buf = new byte[BUFFER_SIZE];
        try {
            FileInputStream in = new FileInputStream(srcFile);
            outputStream.putNextEntry(new ZipEntry(srcFile.getName()));
            int len;
            while ((len = in.read(buf)) > 0) {
                outputStream.write(buf, 0, len);
            }
            outputStream.closeEntry();
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void compress(File[] srcFiles, File zipFile) throws IOException {

        for (int i = 0; i < srcFiles.length; i++) {
            compress(srcFiles[i], zipFile);
        }
    }

    public static void compress(File[] srcFiles, ZipOutputStream outputStream) {

        for (int i = 0; i < srcFiles.length; i++) {
            compress(srcFiles[i], outputStream);
        }
    }

    /**
     * 多文件压缩
     *
     * @param srcFiles 源文件列表
     * @param zipFile  zip压缩文件
     */
    public static void compress(List<File> srcFiles, File zipFile) throws IOException {
        for (File srcFile : srcFiles
                ) {
            compress(srcFile, zipFile);
        }
    }

    /**
     * 将多个文件压缩到zip输出流中
     *
     * @param srcFiles     元文件
     * @param outputStream zip输出流，完成文件或文件夹的压缩
     */
    public static void compress(List<File> srcFiles, ZipOutputStream outputStream) {
        for (File srcFile : srcFiles
                ) {
            compress(srcFile, outputStream);
        }
    }

}
