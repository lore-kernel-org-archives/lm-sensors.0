From: nacc@us.ibm.com (Nishanth Aravamudan)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: [PATCH 2/63] include/usb: change USB_CTRL_{SET,GET}_TIMEOUT to msecs
Message-Id: <20050209001503.GD5661@us.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Sent to everyone so that build and compile tests will be possible. These
constants are used all over, but only with respect to these usb_*_msg()
functions. Only Greg should need to pull this into a tree, though, to send
upstream.

Thanks,
Nish

Description: Change the units of the timeout constants in usb.h to correspond to
the new parameter units for usb_{control,bulk}_msg(), in this case from seconds
to milliseconds.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc3-kj-v/include/linux/usb.h	2005-02-03 16:57:39.000000000 -0800
+++ 2.6.11-rc3-kj/include/linux/usb.h	2005-02-08 11:21:22.000000000 -0800
@@ -986,13 +986,13 @@ extern int usb_reset_configuration(struc
 extern int usb_set_interface(struct usb_device *dev, int ifnum, int alternate);
 
 /*
- * timeouts, in seconds, used for sending/receiving control messages
+ * timeouts, in milliseconds, used for sending/receiving control messages
  * they typically complete within a few frames (msec) after they're issued
  * USB identifies 5 second timeouts, maybe more in a few cases, and a few
  * slow devices (like some MGE Ellipse UPSes) actually push that limit.
  */
-#define USB_CTRL_GET_TIMEOUT	5
-#define USB_CTRL_SET_TIMEOUT	5
+#define USB_CTRL_GET_TIMEOUT	5000
+#define USB_CTRL_SET_TIMEOUT	5000
 
 
 /**
