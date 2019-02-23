# FastDFS #

> pom.xml

	<dependency>
	  <groupId>com.github.penggle</groupId>
	  <artifactId>fastdfs-client-java</artifactId>
	  <version>1.27</version>
	</dependency>


> FastDFS服务器的配置文件 fastdfs_client.properties

	fastdfs.connect_timeout_in_seconds = 5
	fastdfs.network_timeout_in_seconds = 30
	fastdfs.charset = UTF-8
	fastdfs.http_anti_steal_token = false
	fastdfs.http_tracker_http_port = 80
	fastdfs.tracker_servers = 192.168.1.31:22122

> fastdfs 工具类
		
	import org.csource.common.MyException;
	import org.csource.common.NameValuePair;
	import org.csource.fastdfs.*;
	
	import javax.servlet.http.HttpServletRequest;
	import java.io.File;
	import java.io.FileOutputStream;
	import java.io.IOException;
	import java.util.Arrays;

	public class FastdsfUtil {
	
	    private static TrackerServer trackerServer = null;
	    private static StorageServer storageServer = null;
	    private static StorageClient storageClient = null;
	    private static TrackerClient trackerClient = null;
	
	    static{
	        // 加载配置文件
	        try {
	            ClientGlobal.initByProperties("fastdfs-client.properties");
	        } catch (IOException | MyException e) {
	            e.printStackTrace();
	            System.out.println("加载属性配置文件失败");
	        }
	    }
	
	    /**
	     * 初始化连接信息
	     */
	    private static void init(){
	        try {
	            // 获取连接
	            trackerClient = new TrackerClient();
	            trackerServer = trackerClient.getConnection();
	            storageClient = new StorageClient(trackerServer, storageServer);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	
	    /**
	     * 上传文件
	     *  根据文件路径
	     */
	    public static String[] fileUpload(String filePath,
	                                      String fileName){
	        return fileUpload(null,filePath,fileName);
	    }
	
	    /**
	     * 上传文件
	     *  根据文件字节数组
	     */
	    public static String[] fileUpload(byte[] fileBuff,
	                                      String fileName){
	        return fileUpload(fileBuff,null,fileName);
	    }
	
	    /**
	     * 上传文件
	     * @param fileBuff 文件字节数组
	     * @param filePath 文件路径
	     * @param fileName 文件名称
	     * @return 文件存储信息
	     */
	    private static String[] fileUpload(byte[] fileBuff,
	                                       String filePath,
	                                       String fileName){
	        try {
	            if (fileBuff ==null && filePath == null){
	                //长度为0的数组依然是数组(对象)
	                return new String[0];
	            }
	            if(storageClient == null){
	                init();
	            }
	            //文件后缀
	            String suffix;
	            if (fileName != null && !fileName.equals("")&& fileName.contains(".")){
	                suffix = fileName.substring(fileName.lastIndexOf(".")+1);
	            }else{
	                return new String[0];
	            }
	            // 设置图片元数据
	            NameValuePair[] metaList = new NameValuePair[2];
	            metaList[0] = new NameValuePair("fileName", fileName);
	            metaList[1] = new NameValuePair("suffix", suffix);
	            // 上传文件
	            String[] uploadFile;
	            if (fileBuff != null&& fileBuff.length !=0) {
	                uploadFile = storageClient.upload_file(fileBuff, suffix, metaList);
	            }
	            else{
	                uploadFile = storageClient.upload_file(filePath, suffix, metaList);
	            }
	            return uploadFile == null ? new String[0] : uploadFile;
	
	        } catch (IOException | MyException e) {
	            e.printStackTrace();
	        }finally {
	            try {
	                if (trackerServer != null) {
	                    trackerServer.close();
	                }
	                if (storageServer != null) {
	                    storageServer.close();
	                }
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
	        }
	        return new String[0];
	    }
	
	    /**
	     * 下载文件
	     * remoteFileName 要下载的文件[fastdfs中的文件名]
	     */
	    public static String[] downloadFile(String filePath,
	                                        String fileName,
	                                        String groupName,
	                                        String remoteFileName){
	        FileOutputStream fileOutputStream =null;
	        try {
	            if (remoteFileName == null ){
	                return new String[0];
	            }
	            File file = new File(filePath+"/"+fileName);
	            if (!file.getParentFile().exists()){
	                boolean flag = file.getParentFile().mkdirs();
	                if (!flag){
	                    System.out.println("创建下载文件路径失败");
	                }
	            }
	            if (storageClient == null){
	                init();
	            }
	            //下载文件
	            byte[] file_buff = storageClient.download_file(groupName,remoteFileName);
	            fileOutputStream = new FileOutputStream(file);
	            fileOutputStream.write(file_buff);
	
	        } catch (IOException | MyException e) {
	            e.printStackTrace();
	        }finally {
	            try {
	                if (fileOutputStream!=null) {
	                    fileOutputStream.close();
	                }
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
	        }
	         return new String[0];
	    }
	
	    /**
	     * 删除文件
	     * 成功返回 0，失败返回 非0
	     */
	    public static int deleteFile(String groupName,
	                                 String remoteFileName){
	
	        if (remoteFileName == null ||remoteFileName.equals("")){
	            return -1;
	        }
	        if (storageClient == null){
	            init();
	        }
	        try {
	            return storageClient.delete_file(groupName,remoteFileName);
	        } catch (IOException | MyException e) {
	            e.printStackTrace();
	        }
	
	        return -1;
	    }
	
	    /**
	     * 获取元数据信息
	     */
	    public void getMetaData(String groupName,
	                            String remoteFileName){
	        if (storageClient == null){
	            init();
	        }
	        // 上传图片的时候，元数据若为空将无法生存-m的原数据文件。获取时候此处将抛出NullPointerException
	        NameValuePair[] get_metadata = new NameValuePair[0];
	        try {
	            get_metadata = storageClient.get_metadata(groupName,remoteFileName);
	        } catch (IOException|MyException e) {
	            e.printStackTrace();
	        }
	        for (NameValuePair nameValuePair: get_metadata) {
	            System.out.println("name: " + nameValuePair.getName() + " value: " + nameValuePair.getValue());
	        }
	    }
	
	    /**
	     * 获取文件信息
	     */
	    public static FileInfo getFileInfo(String groupName,
	                            String remoteFileName){
	        if (storageClient == null){
	            init();
	        }
	        FileInfo fileInfo = null;
	        try{
	            fileInfo = storageClient.get_file_info(groupName, remoteFileName);
	        } catch (IOException|MyException e) {
	            e.printStackTrace();
	        }
	        return fileInfo;
	    }
	}

> fastdfs 测试类

	package com.hdc.controller;
	
	import com.hdc.tool.FileTool;
	import org.apache.commons.io.FileUtils;
	import org.springframework.http.HttpHeaders;
	import org.springframework.http.HttpStatus;
	import org.springframework.http.MediaType;
	import org.springframework.http.ResponseEntity;
	import org.springframework.stereotype.Controller;
	import org.springframework.ui.Model;
	import org.springframework.web.bind.annotation.RequestMapping;
	import org.springframework.web.bind.annotation.RequestParam;
	import org.springframework.web.multipart.commons.CommonsMultipartFile;
	
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
	import java.io.*;
	import java.net.URLEncoder;
	import java.util.ArrayList;
	import java.util.List;
	import java.util.UUID;
	
	@Controller
	public class UploadController {
	
	    @RequestMapping("/upload")
	    public String upload(@RequestParam("file")CommonsMultipartFile file,
	                         HttpServletRequest request){
	
	        //获取上传路径
	        String path = request.getSession().getServletContext().getRealPath("/upload");
	        //获取文件名
	        String fileName = file.getOriginalFilename();
	        File newFile = new File(path);
	        //判断路径是否存在，如果不存在就创建一个
	        if(!newFile.exists()){
	            boolean flag = newFile.mkdir();
	            if (!flag){
	                System.out.println("创建路径失败");
	                return null;
	            }
	        }
	        //将上传文件转存到指定的路径
	        try {
	            file.transferTo(new File(path + "/" + fileName));
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	        /*//获取数据流
	        InputStream is =null;
	        OutputStream os =null;
	        try {
	            is = file.getInputStream();
	            os = new FileOutputStream(newFile);
	            //临时区
	            int len = 0;
	            byte[] buffer = new byte[1024];
	            while((len=is.read(buffer))!= -1){
	                os.write(buffer,0,len);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }finally {
	            try {
	                if(os!=null){
	                    os.close();
	                }
	            }catch (Exception e){
	                e.printStackTrace();
	            }
	            try {
	                if(is!=null){
	                    is.close();
	                }
	            }catch (Exception e){
	                e.printStackTrace();
	            }
	        }
	*/
	        return "index";
	    }
	
	    @RequestMapping("/uploadMulti")
	    public String uploadMulti(@RequestParam("file")CommonsMultipartFile files[],
	                         HttpServletRequest request){
	
	        List<String> list = new ArrayList<>();
	
	        // 上传位置 ,设定文件保存的目录
	        String path = request.getSession().getServletContext().getRealPath("/img") + "/";
	        File f = new File(path);
	        if (!f.exists()){
	            boolean flag = f.mkdirs();
	        }
	
	        for (int i = 0; i < files.length; i++) {
	            // 获得原始文件名
	            String fileName = files[i].getOriginalFilename();
	            System.out.println("原始文件名:" + fileName);
	            // 新文件名
	            String newFileName = UUID.randomUUID() + fileName;
	            if (!files[i].isEmpty()) {
	                try {
	                    FileOutputStream fos = new FileOutputStream(path + newFileName);
	                    InputStream in = files[i].getInputStream();
	                    int b = 0;
	                    byte[] buffer = new byte[1024];
	                    while ((b = in.read(buffer)) != -1) {
	                        fos.write(buffer,0,b);
	                    }
	                    fos.close();
	                    in.close();
	                } catch (Exception e) {
	                    e.printStackTrace();
	                }
	            }
	            System.out.println("上传图片到:" + path + newFileName);
	            list.add(path + newFileName);
	        }
	        return "index";
	    }
	
	    //获取下载路径下的所有文件
	    @RequestMapping("/showFile")
	    public String showFile(HttpServletRequest request){
	        //获取下载路径
	        String file_path = request.getSession().getServletContext().getRealPath("/img");
	        List<String> file_list= FileTool.readFiles(file_path);
	        request.setAttribute("file_list",file_list);
	        return "download";
	    }
	
	    /**
	     * download处理方法接收页面传递的文件名filename后，使用Apache Commons FileUpload组件的FileUtils读取项目的上传文件，
	     * 并将其构建成ResponseEntity对象返回客户端下载。
	     * 使用ResponseEntity对象，可以很方便的定义返回的HttpHeaders和HttpStatus
	     * @param request
	     * @param filename
	     * @param model
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value="/download")
	    public ResponseEntity<byte[]> download(HttpServletRequest request,
	                                           @RequestParam("filename") String filename,
	                                           Model model)throws Exception {
	        //下载文件路径
	        String path = request.getSession().getServletContext().getRealPath("/upload/");
	        File file = new File(path + "/" + filename);
	        HttpHeaders headers = new HttpHeaders();
	        //下载显示的文件名，解决中文名称乱码问题
	        String downloadFileName = new String(filename.getBytes("UTF-8"),"iso-8859-1");
	        //通知浏览器以attachment（下载方式）打开图片
	        headers.setContentDispositionFormData("attachment", downloadFileName);
	        //application/octet-stream ： 二进制流数据（最常见的文件下载）
	        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
	                headers, HttpStatus.CREATED);
	    }
	
	    @RequestMapping("/downFile")
	    public void downFile(HttpServletRequest request,HttpServletResponse response) {
	
	        // 得到要下载的文件名
	        String fileName = request.getParameter("filename");
	        try {
	            fileName = new String(fileName.getBytes("iso8859-1"), "UTF-8");
	            // 上传位置
	            String fileSaveRootPath = request.getSession().getServletContext().getRealPath("/img");
	            System.out.println(fileSaveRootPath + "\\" + fileName);
	            // 得到要下载的文件
	            File file = new File(fileSaveRootPath + "\\" + fileName);
	            // 如果文件不存在
	            if (!file.exists()) {
	                request.setAttribute("message", "您要下载的资源已被删除！！");
	                System.out.println("您要下载的资源已被删除！！");
	                return;
	            }
	            // 处理文件名
	            String realname = fileName.substring(fileName.indexOf("_") + 1);
	            // 设置响应头，控制浏览器下载该文件
	            response.setHeader("content-disposition", "attachment;filename="
	                    + URLEncoder.encode(realname, "UTF-8"));
	            // 读取要下载的文件，保存到文件输入流
	            FileInputStream in = new FileInputStream(fileSaveRootPath + "\\" + fileName);
	            // 创建输出流
	            OutputStream out = response.getOutputStream();
	            // 创建缓冲区
	            byte buffer[] = new byte[1024];
	            int len = 0;
	            // 循环将输入流中的内容读取到缓冲区当中
	            while ((len = in.read(buffer)) > 0) {
	                // 输出缓冲区的内容到浏览器，实现文件下载
	                out.write(buffer, 0, len);
	            }
	            // 关闭文件输入流
	            in.close();
	            // 关闭输出流
	            out.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}




