package com.taihaoli.util.httpclient;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.Consts;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.StatusLine;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.apache.http.ssl.SSLContexts;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.net.ssl.SSLContext;
import java.io.IOException;
import java.nio.charset.Charset;
import java.security.KeyStore;

/**
 * @author HuangDongChang
 * @date 2018/12/21
 */
public class HttpClientUtils {

    private static final Logger log = LoggerFactory.getLogger(HttpClientUtils.class);

    public HttpClientUtils() {
    }

    public static String getString(String url) throws HttpClientException {
        return parseContent(getEntity(url));
    }

    public static String getString(String url, Header header) throws HttpClientException {
        return parseContent(getEntity(url, header));
    }

    public static HttpEntity getEntity(String url) throws HttpClientException {
        try {
            return parseEntity(getResponse(url));
        } catch (Exception var2) {
            throw new HttpClientException("HTTPS Get request failed！", var2);
        }
    }

    public static HttpEntity getEntity(String url, Header header) throws HttpClientException {
        try {
            return parseEntity(getResponse(url, header));
        } catch (Exception var2) {
            throw new HttpClientException("HTTPS Get request failed！", var2);
        }
    }

    public static CloseableHttpResponse getResponse(String url) throws HttpClientException {
        try {
            HttpGet httpGet = new HttpGet(url);
            httpGet.setConfig(buildRequestConfig());
            return buildClient(url).execute(httpGet);
        } catch (Exception var2) {
            throw new HttpClientException("HTTPS Get request failed！", var2);
        }
    }

    public static CloseableHttpResponse getResponse(String url, Header header) throws HttpClientException {
        try {
            HttpGet httpGet = new HttpGet(url);
            httpGet.addHeader(header);
            httpGet.setConfig(buildRequestConfig());
            return buildClient(url).execute(httpGet);
        } catch (Exception var2) {
            throw new HttpClientException("HTTPS Get request failed！", var2);
        }
    }

    public static String postJson(String url, String jsonData) throws HttpClientException {
        return parseContent(post(url, createJsonEntity(jsonData)));
    }

    public static String postForm(String url, String params) throws HttpClientException {
        return parseContent(post(url, createPostEntity(params)));
    }

    public static HttpEntity post(String url, StringEntity postEntity) throws HttpClientException {
        try {
            HttpPost httpPost = new HttpPost(url);
            httpPost.setConfig(buildRequestConfig());
            httpPost.setEntity(postEntity);
            CloseableHttpResponse response = buildClient(url).execute(httpPost);
            return parseEntity(response);
        } catch (HttpClientException var4) {
            throw var4;
        } catch (Exception var5) {
            throw new HttpClientException("HTTPS Post request failed！", var5);
        }
    }

    public static String uploadFile(String url, String name, byte[] fileBytes, String fileName) throws HttpClientException, IOException {
        ContentType contentType = ContentType.create("multipart/form-data", Consts.UTF_8);
        HttpEntity reqEntity = MultipartEntityBuilder.create().addBinaryBody(name, fileBytes, contentType, fileName).build();
        HttpPost httpPost = new HttpPost(url);
        httpPost.setConfig(buildRequestConfig());
        httpPost.setEntity(reqEntity);
        CloseableHttpResponse response = buildClient(url).execute(httpPost);
        HttpEntity resEntity = parseEntity(response);
        return parseContent(resEntity);
    }

    public static String parseContent(HttpEntity httpEntity) throws HttpClientException {
        try {
            if (!httpEntity.isStreaming()) {
                log.debug("httpEntity is not streaming");
                return "";
            } else {
                ContentType contentType = ContentType.getOrDefault(httpEntity);
                Charset charset = contentType.getCharset();
                String charsetStr = charset != null ? charset.name() : contentType.getParameter("encoding");
                log.debug("charsetStr=" + charsetStr);
                if (StringUtils.isBlank(charsetStr)) {
                    charsetStr = "UTF-8";
                }

                return IOUtils.toString(httpEntity.getContent(), charsetStr);
            }
        } catch (Exception var4) {
            throw new HttpClientException("Get response content failed！", var4);
        }
    }

    public static StringEntity createJsonEntity(String data) {
        return createJsonEntity(data, Consts.UTF_8);
    }

    public static StringEntity createJsonEntity(String data, Charset charset) {
        return new StringEntity(data, ContentType.create("application/json", charset));
    }

    public static StringEntity createPostEntity(String data, Charset charset) {
        return new StringEntity(data, ContentType.create("application/x-www-form-urlencoded", charset));
    }

    public static StringEntity createPostEntity(String data, String charset) {
        return createPostEntity(data, StringUtils.isNoneBlank(new CharSequence[]{charset}) ? Charset.forName(charset) : null);
    }

    public static StringEntity createPostEntity(String data) {
        return createPostEntity(data, Consts.UTF_8);
    }

    public static HttpEntity parseEntity(CloseableHttpResponse response) throws HttpClientException {
        try {
            StatusLine statusLine = response.getStatusLine();
            HttpEntity entity = response.getEntity();
            if (statusLine.getStatusCode() >= 300) {
                throw new HttpClientException(statusLine.getStatusCode() + ":" + statusLine.getReasonPhrase(), parseContent(entity));
            } else if (entity == null) {
                throw new ClientProtocolException("Response contains no content");
            } else {
                return entity;
            }
        } catch (HttpClientException var3) {
            throw var3;
        } catch (Exception var4) {
            throw new HttpClientException(var4.getMessage(), var4);
        }
    }

    public static RequestConfig buildRequestConfig() {
        return RequestConfig.custom().setSocketTimeout(30000).setConnectTimeout(30000).build();
    }

    public static CloseableHttpClient buildClient(String url, boolean laxRedirect) throws HttpClientException {
        HttpClientBuilder clientBuilder = HttpClients.custom();
        if (url.startsWith("https")) {
            clientBuilder.setSSLSocketFactory(buildDefaultSSLFactory());
        }

        if (laxRedirect) {
            clientBuilder.setRedirectStrategy(new LaxRedirectStrategy());
        }

        return clientBuilder.build();
    }

    public static CloseableHttpClient buildClient(String url) throws HttpClientException {
        return buildClient(url, false);
    }

    private static SSLConnectionSocketFactory buildDefaultSSLFactory() throws HttpClientException {
        try {
            SSLContext sslContext = SSLContexts.custom().loadTrustMaterial((KeyStore)null, new DefaultTrustStrategy()).build();
            return new SSLConnectionSocketFactory(sslContext);
        } catch (Exception var1) {
            throw new HttpClientException("Build SSLConnectionSocketFactory failed!", var1);
        }
    }

    public static void main(String[] args) {
        try {
            String res = postJson("http://msg.umeng.com/api/send", "");
            log.debug(res);
        } catch (HttpClientException var2) {
            log.debug(var2.getMessage());
            log.debug(var2.getContent());
        } catch (Exception var3) {
            var3.printStackTrace();
        }

    }
}
