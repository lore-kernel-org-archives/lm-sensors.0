From: vsu@altlinux.ru (Sergey Vlasov)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] i2c-ipmi, i2c-ipmb: fix compilation with openipmi.sf.net
Message-Id: <20050501162737.GC2589@procyon.home>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

http://openipmi.sourceforge.net/ provides patches for 2.4.x kernels
with updated IPMI code.  However, these patches change the IPMI driver
API by adding an additional argument to ipmi_request():

 int ipmi_request(ipmi_user_t      user,
 		 struct ipmi_addr *addr,
 		 long             msgid,
 		 struct ipmi_msg  *msg,
+		 void             *user_msg_data,
 		 int              priority);

(user_msg_data is later returned in the struct ipmi_recv_msg field).
This API change breaks compilation of some lm_sensors drivers
(i2c-ipmb, i2c-ipmi).

The patch below adds compatibility with the new IPMI API to i2c-ipmb
and i2c-ipmi drivers.  <linux/ipmi.h> does not provide a real
API-version #define, therefore IPMI_RESPONSE_RESPONSE_TYPE (also added
by the openipmi.sf.net patch) is (ab)used as a new API indicator.

Compile tested only due to lack of hardware.

--- lm_sensors-2.8.4/kernel/busses/i2c-ipmi.c.ipmi-update	2003-03-17 04:39:57 +0300
+++ lm_sensors-2.8.4/kernel/busses/i2c-ipmi.c	2004-02-28 19:37:19 +0300
@@ -86,7 +86,11 @@
 
 static void ipmi_i2c_send_message(int id, struct ipmi_msg * msg)
 {
+#ifdef IPMI_RESPONSE_RESPONSE_TYPE
+	ipmi_request(i2c_ipmi_user, &address, (long) id, msg, NULL, 0);
+#else
 	ipmi_request(i2c_ipmi_user, &address, (long) id, msg, 0);
+#endif
 }
 
 /* This is the message send function exported to the client
--- lm_sensors-2.8.4/kernel/busses/i2c-ipmb.c.ipmi-update	2003-03-17 04:39:57 +0300
+++ lm_sensors-2.8.4/kernel/busses/i2c-ipmb.c	2004-02-28 19:36:23 +0300
@@ -87,7 +87,12 @@
 {
 	int err;
 
-	if((err = ipmi_request(i2c_ipmb_user, address, id, msg, 0)))
+#ifdef IPMI_RESPONSE_RESPONSE_TYPE
+	err = ipmi_request(i2c_ipmb_user, address, id, msg, NULL, 0);
+#else
+	err = ipmi_request(i2c_ipmb_user, address, id, msg, 0);
+#endif
+	if (err)
 		printk(KERN_INFO "i2c-ipmb.o: ipmi_request error %d\n",
 			err);
 }

-- 
Sergey Vlasov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050501/ac612130/attachment.bin
