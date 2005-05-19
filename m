From: nacc@us.ibm.com (Nishanth Aravamudan)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: [PATCH 1/63] usb/message: make usb_{control,bulk}_msg() use msecs
Message-Id: <20050209001232.GC5661@us.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@us.ibm.com, marcel@holtmann.org, maxk@qualcomm.com, jt@hpl.hp.com, perex@suse.cz, linux-dvb-maintainer@linuxtv.org, johnpol@2ka.mipt.ru
Cc: linux-usb-devel@lists.sourceforge.net, bluez-devel@lists.sourceforge.net, irda-users@lists.sourceforge.net, alsa-devel@alsa-project.org, linux-dvb@linuxtv.org, sensors@stimpy.netroedge.com

Hi,

Sent to everyone so that build and compile tests will be possible. Only Greg
should need to pull this into a tree, though, to send upstream.

Thanks,
Nish

Description: Change the units of the timeout parameter in both usb_control_msg()
and usb_bulk_msg() from jiffies to milliseconds. This is the core patch upon
which the remaining ones will be built. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc3-kj-v/drivers/usb/core/message.c	2005-02-03 16:57:40.000000000 -0800
+++ 2.6.11-rc3-kj/drivers/usb/core/message.c	2005-02-08 16:07:32.000000000 -0800
@@ -98,7 +98,7 @@ int usb_internal_control_msg(struct usb_
 	usb_fill_control_urb(urb, usb_dev, pipe, (unsigned char *)cmd, data,
 			     len, usb_api_blocking_completion, NULL);
 
-	retv = usb_start_wait_urb(urb, timeout, &length);
+	retv = usb_start_wait_urb(urb, msecs_to_jiffies(timeout), &length);
 	if (retv < 0)
 		return retv;
 	else
@@ -115,7 +115,7 @@ int usb_internal_control_msg(struct usb_
  *	@index: USB message index value
  *	@data: pointer to the data to send
  *	@size: length in bytes of the data to send
- *	@timeout: time in jiffies to wait for the message to complete before
+ *	@timeout: time in msecs to wait for the message to complete before
  *		timing out (if 0 the wait is forever)
  *	Context: !in_interrupt ()
  *
@@ -163,7 +163,7 @@ int usb_control_msg(struct usb_device *d
  *	@data: pointer to the data to send
  *	@len: length in bytes of the data to send
  *	@actual_length: pointer to a location to put the actual length transferred in bytes
- *	@timeout: time in jiffies to wait for the message to complete before
+ *	@timeout: time in msecs to wait for the message to complete before
  *		timing out (if 0 the wait is forever)
  *	Context: !in_interrupt ()
  *
@@ -196,7 +196,7 @@ int usb_bulk_msg(struct usb_device *usb_
 	usb_fill_bulk_urb(urb, usb_dev, pipe, data, len,
 			  usb_api_blocking_completion, NULL);
 
-	return usb_start_wait_urb(urb,timeout,actual_length);
+	return usb_start_wait_urb(urb,msecs_to_jiffies(timeout),actual_length);
 }
 
 /*-------------------------------------------------------------------*/
