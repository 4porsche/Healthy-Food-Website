package util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

public class VNPayHelper {

    private static final String TMN_CODE = "PBUIGQTA";
    private static final String SECRET_KEY = "YT45665PMCH1QTC5ANPT9NAGJBPBW6A7";
    private static final String VNP_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";

    public static String createVNPayPaymentUrl(int orderId, int totalAmount) {
        try {
            Map<String, String> vnpParams = new HashMap<>();
            vnpParams.put("vnp_Version", "2.1.0");
            vnpParams.put("vnp_Command", "pay");
            vnpParams.put("vnp_TmnCode", TMN_CODE);
            vnpParams.put("vnp_Amount", String.valueOf(totalAmount * 100));
            vnpParams.put("vnp_CurrCode", "VND");
            vnpParams.put("vnp_TxnRef", "ORDER_" + orderId);
            vnpParams.put("vnp_OrderInfo", "Thanh toan don hang " + orderId);
            vnpParams.put("vnp_OrderType", "other");
            vnpParams.put("vnp_Locale", "vn");
            vnpParams.put("vnp_ReturnUrl", "http://localhost:8080/healthyfood/vnpay-return");
            vnpParams.put("vnp_IpAddr", "127.0.0.1");
            
            // Format date correctly
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            vnpParams.put("vnp_CreateDate", formatter.format(new Date()));
            
            // Set expiration time (15 minutes)
            Calendar expireCalendar = Calendar.getInstance();
            expireCalendar.add(Calendar.MINUTE, 15);
            vnpParams.put("vnp_ExpireDate", formatter.format(expireCalendar.getTime()));

            // Sort parameters alphabetically
            List<String> fieldNames = new ArrayList<>(vnpParams.keySet());
            Collections.sort(fieldNames);
            
            // Build hash data
            StringBuilder hashData = new StringBuilder();
            for (String fieldName : fieldNames) {
                String fieldValue = vnpParams.get(fieldName);
                if (fieldValue != null && !fieldValue.isEmpty()) {
                    if (hashData.length() > 0) {
                        hashData.append('&');
                    }
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8.toString()));
                }
            }
            
            // Build query string
            StringBuilder query = new StringBuilder(hashData.toString());
            
            // Generate secure hash
            String vnp_SecureHash = hmacSHA512(SECRET_KEY, hashData.toString());
            
            // Append secure hash to query
            query.append('&');
            query.append(URLEncoder.encode("vnp_SecureHash", StandardCharsets.UTF_8.toString()));
            query.append('=');
            query.append(URLEncoder.encode(vnp_SecureHash, StandardCharsets.UTF_8.toString()));
            
            // Debug output
            System.out.println("VNPay Hash Data: " + hashData.toString());
            System.out.println("VNPay Secure Hash: " + vnp_SecureHash);
            System.out.println("VNPay Full URL: " + VNP_URL + "?" + query.toString());
            
            return VNP_URL + "?" + query.toString();
            
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    private static String hmacSHA512(String key, String data) {
        try {
            Mac hmac512 = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            hmac512.init(secretKey);
            
            byte[] hash = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();
            
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}