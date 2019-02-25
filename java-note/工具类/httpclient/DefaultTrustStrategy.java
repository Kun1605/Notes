package com.taihaoli.util.httpclient;

import org.apache.http.conn.ssl.TrustStrategy;

import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

/**
 * @author HuangDongChang
 * @date 2018/12/21
 */
public class DefaultTrustStrategy implements TrustStrategy {

    public DefaultTrustStrategy() {
    }

    @Override
    public boolean isTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {
        return true;
    }
}
