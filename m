From: nacc@us.ibm.com (Nishanth Aravamudan)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: [PATCH 54/63] w1/dscore: change parameters of
Message-Id: <20050209064128.GY1419@us.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Description: Change units of parameters being passed to
usb_{control,bulk}_msg() to milliseconds. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc3-kj-v/drivers/w1/dscore.c	2005-02-03 16:57:40.000000000 -0800
+++ 2.6.11-rc3-kj/drivers/w1/dscore.c	2005-02-08 14:23:49.000000000 -0800
@@ -84,7 +84,7 @@ static int ds_send_control_cmd(struct ds
 	int err;
 	
 	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]), 
-			CONTROL_CMD, 0x40, value, index, NULL, 0, HZ);
+			CONTROL_CMD, 0x40, value, index, NULL, 0, 1000);
 	if (err < 0) {
 		printk(KERN_ERR "Failed to send command control message %x.%x: err=%d.\n", 
 				value, index, err);
@@ -99,7 +99,7 @@ static int ds_send_control_mode(struct d
 	int err;
 	
 	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]), 
-			MODE_CMD, 0x40, value, index, NULL, 0, HZ);
+			MODE_CMD, 0x40, value, index, NULL, 0, 1000);
 	if (err < 0) {
 		printk(KERN_ERR "Failed to send mode control message %x.%x: err=%d.\n", 
 				value, index, err);
@@ -114,7 +114,7 @@ static int ds_send_control(struct ds_dev
 	int err;
 	
 	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]), 
-			COMM_CMD, 0x40, value, index, NULL, 0, HZ);
+			COMM_CMD, 0x40, value, index, NULL, 0, 1000);
 	if (err < 0) {
 		printk(KERN_ERR "Failed to send control message %x.%x: err=%d.\n", 
 				value, index, err);
@@ -213,7 +213,7 @@ int ds_recv_data(struct ds_device *dev, 
 	
 	count = 0;
 	err = usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]), 
-				buf, size, &count, HZ);
+				buf, size, &count, 1000);
 	if (err < 0) {
 		printk(KERN_INFO "Clearing ep0x%x.\n", dev->ep[EP_DATA_IN]);
 		usb_clear_halt(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]));
@@ -239,7 +239,7 @@ int ds_send_data(struct ds_device *dev, 
 	int count, err;
 	
 	count = 0;
-	err = usb_bulk_msg(dev->udev, usb_sndbulkpipe(dev->udev, dev->ep[EP_DATA_OUT]), buf, len, &count, HZ);
+	err = usb_bulk_msg(dev->udev, usb_sndbulkpipe(dev->udev, dev->ep[EP_DATA_OUT]), buf, len, &count, 1000);
 	if (err < 0) {
 		printk(KERN_ERR "Failed to read 1-wire data from 0x02: err=%d.\n", err);
 		return err;
