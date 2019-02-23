package com.taihaoli.util.httpclient;

/**
 * @author HuangDongChang
 * @date 2018/12/21
 */
public class HttpClientException extends Exception {
    private String content;

    public HttpClientException() {
    }

    public HttpClientException(String msg) {
        super(msg);
    }

    public HttpClientException(String message, Throwable cause) {
        super(message, cause);
    }

    public HttpClientException(Throwable cause) {
        super(cause);
    }

    public HttpClientException(String message, String content) {
        this(message);
        this.content = content;
    }

    public HttpClientException(String message, Throwable cause, String content) {
        this(message, cause);
        this.content = content;
    }

    public String getContent() {
        return this.content;
    }

    public void setContent(String content) {
        this.content = content;
    }

}
