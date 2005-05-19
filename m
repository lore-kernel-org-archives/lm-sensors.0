From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH] I2C fixes for 2.6.10-rc2
Message-Id: <11018600193088@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11018600193699@kroah.com>
References: <20041119220001.GB15956@kroah.com>
In-Reply-To: <20041119220001.GB15956@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2223.2.4, 2004/11/24 14:25:23-08:00, johnpol@2ka.mipt.ru

[PATCH] drivers/w1/dscore: fix the inline mess

Remove unneded inlines.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/dscore.c |   40 ++++++++++++++++++++--------------------
 drivers/w1/dscore.h |   34 +++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 37 deletions(-)


diff -Nru a/drivers/w1/dscore.c b/drivers/w1/dscore.c
--- a/drivers/w1/dscore.c	2004-11-30 16:01:10 -08:00
+++ b/drivers/w1/dscore.c	2004-11-30 16:01:10 -08:00
@@ -35,26 +35,26 @@
 int ds_probe(struct usb_interface *, const struct usb_device_id *);
 void ds_disconnect(struct usb_interface *);
 
-inline int ds_touch_bit(struct ds_device *, u8, u8 *);
-inline int ds_read_byte(struct ds_device *, u8 *);
-inline int ds_read_bit(struct ds_device *, u8 *);
-inline int ds_write_byte(struct ds_device *, u8);
-inline int ds_write_bit(struct ds_device *, u8);
-inline int ds_start_pulse(struct ds_device *, int);
-inline int ds_set_speed(struct ds_device *, int);
-inline int ds_reset(struct ds_device *, struct ds_status *);
-inline int ds_detect(struct ds_device *, struct ds_status *);
-inline int ds_stop_pulse(struct ds_device *, int);
-inline int ds_send_data(struct ds_device *, unsigned char *, int);
-inline int ds_recv_data(struct ds_device *, unsigned char *, int);
-inline int ds_recv_status(struct ds_device *, struct ds_status *);
-inline struct ds_device * ds_get_device(void);
-inline void ds_put_device(struct ds_device *);
+int ds_touch_bit(struct ds_device *, u8, u8 *);
+int ds_read_byte(struct ds_device *, u8 *);
+int ds_read_bit(struct ds_device *, u8 *);
+int ds_write_byte(struct ds_device *, u8);
+int ds_write_bit(struct ds_device *, u8);
+int ds_start_pulse(struct ds_device *, int);
+int ds_set_speed(struct ds_device *, int);
+int ds_reset(struct ds_device *, struct ds_status *);
+int ds_detect(struct ds_device *, struct ds_status *);
+int ds_stop_pulse(struct ds_device *, int);
+int ds_send_data(struct ds_device *, unsigned char *, int);
+int ds_recv_data(struct ds_device *, unsigned char *, int);
+int ds_recv_status(struct ds_device *, struct ds_status *);
+struct ds_device * ds_get_device(void);
+void ds_put_device(struct ds_device *);
 
 static inline void ds_dump_status(unsigned char *, unsigned char *, int);
-static inline int ds_send_control(struct ds_device *, u16, u16);
-static inline int ds_send_control_mode(struct ds_device *, u16, u16);
-static inline int ds_send_control_cmd(struct ds_device *, u16, u16);
+static int ds_send_control(struct ds_device *, u16, u16);
+static int ds_send_control_mode(struct ds_device *, u16, u16);
+static int ds_send_control_cmd(struct ds_device *, u16, u16);
 
 
 static struct usb_driver ds_driver = {
@@ -503,7 +503,7 @@
 	return 0;
 }
 
-inline int ds_read_block(struct ds_device *dev, u8 *buf, int len)
+int ds_read_block(struct ds_device *dev, u8 *buf, int len)
 {
 	struct ds_status st;
 	int err;
@@ -529,7 +529,7 @@
 	return err;
 }
 
-inline int ds_write_block(struct ds_device *dev, u8 *buf, int len)
+int ds_write_block(struct ds_device *dev, u8 *buf, int len)
 {
 	int err;
 	struct ds_status st;
diff -Nru a/drivers/w1/dscore.h b/drivers/w1/dscore.h
--- a/drivers/w1/dscore.h	2004-11-30 16:01:10 -08:00
+++ b/drivers/w1/dscore.h	2004-11-30 16:01:10 -08:00
@@ -151,23 +151,23 @@
 
 };
 
-inline int ds_touch_bit(struct ds_device *, u8, u8 *);
-inline int ds_read_byte(struct ds_device *, u8 *);
-inline int ds_read_bit(struct ds_device *, u8 *);
-inline int ds_write_byte(struct ds_device *, u8);
-inline int ds_write_bit(struct ds_device *, u8);
-inline int ds_start_pulse(struct ds_device *, int);
-inline int ds_set_speed(struct ds_device *, int);
-inline int ds_reset(struct ds_device *, struct ds_status *);
-inline int ds_detect(struct ds_device *, struct ds_status *);
-inline int ds_stop_pulse(struct ds_device *, int);
-inline int ds_send_data(struct ds_device *, unsigned char *, int);
-inline int ds_recv_data(struct ds_device *, unsigned char *, int);
-inline int ds_recv_status(struct ds_device *, struct ds_status *);
-inline struct ds_device * ds_get_device(void);
-inline void ds_put_device(struct ds_device *);
-inline int ds_write_block(struct ds_device *, u8 *, int);
-inline int ds_read_block(struct ds_device *, u8 *, int);
+int ds_touch_bit(struct ds_device *, u8, u8 *);
+int ds_read_byte(struct ds_device *, u8 *);
+int ds_read_bit(struct ds_device *, u8 *);
+int ds_write_byte(struct ds_device *, u8);
+int ds_write_bit(struct ds_device *, u8);
+int ds_start_pulse(struct ds_device *, int);
+int ds_set_speed(struct ds_device *, int);
+int ds_reset(struct ds_device *, struct ds_status *);
+int ds_detect(struct ds_device *, struct ds_status *);
+int ds_stop_pulse(struct ds_device *, int);
+int ds_send_data(struct ds_device *, unsigned char *, int);
+int ds_recv_data(struct ds_device *, unsigned char *, int);
+int ds_recv_status(struct ds_device *, struct ds_status *);
+struct ds_device * ds_get_device(void);
+void ds_put_device(struct ds_device *);
+int ds_write_block(struct ds_device *, u8 *, int);
+int ds_read_block(struct ds_device *, u8 *, int);
 
 #endif /* __DSCORE_H */
 

