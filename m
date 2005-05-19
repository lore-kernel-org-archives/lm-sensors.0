From: adaplas@hotpop.com (Antonino A. Daplas)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <200503182136.01803.adaplas@hotpop.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 18 March 2005 20:07, Jean Delvare wrote:
> Hi Tony,
>
> Tony, could it be that the i2c_adapter structures that were allocated in
> the nvidiafb driver and registered with the i2c core (using
> i2c_bit_add_bus() in nvidia_setup_i2c_bus()) are no more reachable at
> this point? I am not familiar with the framebuffer code so I have a hard

It is reachable.  i2c_bit_add_bus is only called after setup of the
hardware, otherwise nvidiafb will be consistently hitting a bug.

> time figuring out when the memory is allocated and when it is freed. I
> think I understand it is allocated by framebuffer_alloc() and freed by
> framebuffer_release()?

Yes all required memory is allocated during framebuffer_alloc().

>
> I note that you never actually unregister the i2c_adapters. The function
> nvidia_delete_i2c_busses() is #if'd out. This means that
> framebuffer_release() can free the memory while the i2c_adapters are
> still in i2c-core's adapters list. This would certainly explain the
> crash Miles observed.

Yes, this is a bug, already fixed in my tree. I  forgot to cleanup i2c in
nvidiafb, which should be done on driver unload. But a framebuffer device
cannot be unloaded if compiled statically or if fbcon is using it. The only
way to unload a framebuffer driver is to call rmmod.

>
> Now, when is framebuffer_release() called? I think I understand it should
> only be called if:
> * the nvidia device detection somehow failed in nvidiafb_probe(); or
> * the driver is unloaded, in nvidiafb_remove().
> Could either case happen in Miles' case? Miles, do you actually get the
> nvidiafb driver to work? If not, then the oops is easily explained by
> what I just described (i2c_adapters still listed at the i2c-core level,
> but freed from memory at the nvidiafb level).

Yes this is possible, but is extremely rare.  The only point nvidiafb
will fail after setting up i2c is when ioremap fails or register_framebuffer
fails.

Anyway, I'm attaching a patch that allows nvidiafb to cleanup i2c on failure
to see if it helps.

Tony

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

