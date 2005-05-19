From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <20050322225622.0d57d194.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> >  I think we would spare a significant amount of time if Miles could
> >  test Tony's patch to nvidiafb - unless he already tried and I am
> >  not aware? Miles?
> 
> Perhaps you could resend it?

Sure.

diff -Nru a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
--- a/drivers/video/nvidia/nv_i2c.c	2005-03-12 23:25:10 +08:00
+++ b/drivers/video/nvidia/nv_i2c.c	2005-03-18 21:06:28 +08:00
@@ -146,7 +146,6 @@
 	nvidia_setup_i2c_bus(&par->chan[2], "BUS3");
 }
 
-#if 0
 void nvidia_delete_i2c_busses(struct nvidia_par *par)
 {
 	if (par->chan[0].par)
@@ -162,7 +161,6 @@
 	par->chan[2].par = NULL;
 
 }
-#endif  /*  0  */
 
 static u8 *nvidia_do_probe_i2c_edid(struct nvidia_i2c_chan *chan)
 {
diff -Nru a/drivers/video/nvidia/nv_of.c b/drivers/video/nvidia/nv_of.c
--- a/drivers/video/nvidia/nv_of.c	2005-03-12 23:25:11 +08:00
+++ b/drivers/video/nvidia/nv_of.c	2005-03-18 21:06:28 +08:00
@@ -28,6 +28,7 @@
 #include "nv_proto.h"
 
 void nvidia_create_i2c_busses(struct nvidia_par *par) {}
+void nvidia_delete_i2c_busses(struct nvidia_par *par) {}
 
 int nvidia_probe_i2c_connector(struct nvidia_par *par, int conn, u8 **out_edid)
 {
diff -Nru a/drivers/video/nvidia/nv_proto.h b/drivers/video/nvidia/nv_proto.h
--- a/drivers/video/nvidia/nv_proto.h	2005-03-12 23:25:12 +08:00
+++ b/drivers/video/nvidia/nv_proto.h	2005-03-18 21:06:28 +08:00
@@ -33,10 +33,12 @@
 /* in nvidia-i2c.c */
 #if defined(CONFIG_FB_NVIDIA_I2C) || defined (CONFIG_PPC_OF)
 void nvidia_create_i2c_busses(struct nvidia_par *par);
+void nvidia_delete_i2c_busses(struct nvidia_par *par);
 int nvidia_probe_i2c_connector(struct nvidia_par *par, int conn,
 			       u8 ** out_edid);
 #else
 #define nvidia_create_i2c_busses(...)
+#define nvidia_delete_i2c_busses(...)
 #define nvidia_probe_i2c_connector(p, c, edid) \
 do {                                           \
 	*(edid) = NULL;                        \
diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c	2005-03-15 18:42:12 +08:00
+++ b/drivers/video/nvidia/nvidia.c	2005-03-18 21:22:39 +08:00
@@ -1566,8 +1566,9 @@
 
       err_out_iounmap_fb:
 	iounmap(info->screen_base);
-      err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
+	nvidia_delete_i2c_busses(par);
+      err_out_free_base1:
 	iounmap(par->REGS);
       err_out_free_base0:
 	pci_release_regions(pd);
@@ -1597,9 +1598,10 @@
 			 info->fix.smem_len);
 #endif				/* CONFIG_MTRR */
 
+	iounmap(info->screen_base);
 	fb_destroy_modedb(info->monspecs.modedb);
+	nvidia_delete_i2c_busses(par);
 	iounmap(par->REGS);
-	iounmap(info->screen_base);
 	pci_release_regions(pd);
 	pci_disable_device(pd);
 	kfree(info->pixmap.addr);



-- 
Jean Delvare
