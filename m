From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:23 +0000
Subject: [lm-sensors] [PATCH] I2C: Drop I2C_DEVNAME and i2c_clientname
Message-Id: <11259567713937@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Drop I2C_DEVNAME and i2c_clientname

I2C_DEVNAME and i2c_clientname were introduced in 2.5.68 [1] to help
media/video driver authors who wanted their code to be compatible with
both Linux 2.4 and 2.6. The cause of the incompatibility has gone since
[2], so I think we can get rid of them, as they tend to make the code
harder to read and longer to preprocess/compile for no more benefit.

I'd hope nobody seriously attempts to keep media/video driver compatible
across Linux trees anymore, BTW.

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m4930186524598&w=2
[2] http://www.linuxhq.com/kernel/v2.6/0-test3/include/linux/i2c.h

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit fae91e72b79ba9a21f0ce7551a1fd7e8984c85a6
tree 1db62e590a010d7ece7f170aedbcc72c8f126122
parent 5b5439652af79106b792faf79b2c1e787e143ba0
author Jean Delvare <khali@linux-fr.org> Mon, 15 Aug 2005 19:57:04 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:35 -0700

 drivers/media/video/bt832.c                    |    2 +
 drivers/media/video/bttv-i2c.c                 |    8 ++---
 drivers/media/video/cx88/cx88-i2c.c            |    8 ++---
 drivers/media/video/ir-kbd-i2c.c               |    2 +
 drivers/media/video/msp3400.c                  |    4 +-
 drivers/media/video/ovcamchip/ovcamchip_core.c |    6 ++--
 drivers/media/video/saa7134/saa6752hs.c        |    2 +
 drivers/media/video/saa7134/saa7134-i2c.c      |    6 ++--
 drivers/media/video/tda7432.c                  |    2 +
 drivers/media/video/tda9840.c                  |    2 +
 drivers/media/video/tda9875.c                  |    2 +
 drivers/media/video/tda9887.c                  |    2 +
 drivers/media/video/tea6415c.c                 |    2 +
 drivers/media/video/tea6420.c                  |    2 +
 drivers/media/video/tuner-core.c               |    2 +
 drivers/media/video/tvaudio.c                  |   41 +++++++++++-------------
 drivers/media/video/tvmixer.c                  |    8 ++---
 drivers/media/video/zoran_card.c               |    2 +
 drivers/usb/media/w9968cf.c                    |    8 ++---
 include/linux/i2c.h                            |    7 ----
 20 files changed, 53 insertions(+), 65 deletions(-)

diff --git a/drivers/media/video/bt832.c b/drivers/media/video/bt832.c
--- a/drivers/media/video/bt832.c
+++ b/drivers/media/video/bt832.c
@@ -241,7 +241,7 @@ static struct i2c_driver driver = {
 };
 static struct i2c_client client_template  {
-	I2C_DEVNAME("bt832"),
+	.name       = "bt832",
 	.flags      = I2C_CLIENT_ALLOW_USE,
         .driver     = &driver,
 };
diff --git a/drivers/media/video/bttv-i2c.c b/drivers/media/video/bttv-i2c.c
--- a/drivers/media/video/bttv-i2c.c
+++ b/drivers/media/video/bttv-i2c.c
@@ -109,7 +109,7 @@ static struct i2c_adapter bttv_i2c_adap_
 #ifdef I2C_CLASS_TV_ANALOG
 	.class             = I2C_CLASS_TV_ANALOG,
 #endif
-	I2C_DEVNAME("bt848"),
+	.name              = "bt848",
 	.id                = I2C_HW_B_BT848,
 	.client_register   = attach_inform,
 };
@@ -280,7 +280,7 @@ static struct i2c_adapter bttv_i2c_adap_
 #ifdef I2C_CLASS_TV_ANALOG
 	.class         = I2C_CLASS_TV_ANALOG,
 #endif
-	I2C_DEVNAME("bt878"),
+	.name          = "bt878",
 	.id            = I2C_HW_B_BT848 /* FIXME */,
 	.algo          = &bttv_algo,
 	.client_register = attach_inform,
@@ -296,7 +296,7 @@ static int attach_inform(struct i2c_clie
 	if (bttv_debug)
 		printk(KERN_DEBUG "bttv%d: %s i2c attach [addr=0x%x,client=%s]\n",
 			btv->c.nr,client->driver->name,client->addr,
-			i2c_clientname(client));
+			client->name);
 	if (!client->driver->command)
 		return 0;
 
@@ -324,7 +324,7 @@ void bttv_call_i2c_clients(struct bttv *
 }
 
 static struct i2c_client bttv_i2c_client_template = {
-	I2C_DEVNAME("bttv internal"),
+	.name	= "bttv internal",
 };
 
 
diff --git a/drivers/media/video/cx88/cx88-i2c.c b/drivers/media/video/cx88/cx88-i2c.c
--- a/drivers/media/video/cx88/cx88-i2c.c
+++ b/drivers/media/video/cx88/cx88-i2c.c
@@ -95,7 +95,7 @@ static int attach_inform(struct i2c_clie
 	struct cx88_core *core = i2c_get_adapdata(client->adapter);
 
 	dprintk(1, "%s i2c attach [addr=0x%x,client=%s]\n",
-		client->driver->name,client->addr,i2c_clientname(client));
+		client->driver->name, client->addr, client->name);
 	if (!client->driver->command)
 		return 0;
 
@@ -128,7 +128,7 @@ static int detach_inform(struct i2c_clie
 {
 	struct cx88_core *core = i2c_get_adapdata(client->adapter);
 
-	dprintk(1, "i2c detach [client=%s]\n", i2c_clientname(client));
+	dprintk(1, "i2c detach [client=%s]\n", client->name);
 	return 0;
 }
 
@@ -152,7 +152,7 @@ static struct i2c_algo_bit_data cx8800_i
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_adapter cx8800_i2c_adap_template = {
-	I2C_DEVNAME("cx2388x"),
+	.name              = "cx2388x",
 	.owner             = THIS_MODULE,
 	.id                = I2C_HW_B_CX2388x,
 	.client_register   = attach_inform,
@@ -160,7 +160,7 @@ static struct i2c_adapter cx8800_i2c_ada
 };
 
 static struct i2c_client cx8800_i2c_client_template = {
-        I2C_DEVNAME("cx88xx internal"),
+        .name	= "cx88xx internal",
 };
 
 static char *i2c_devs[128] = {
diff --git a/drivers/media/video/ir-kbd-i2c.c b/drivers/media/video/ir-kbd-i2c.c
--- a/drivers/media/video/ir-kbd-i2c.c
+++ b/drivers/media/video/ir-kbd-i2c.c
@@ -308,7 +308,7 @@ static struct i2c_driver driver = {
 
 static struct i2c_client client_template  {
-        I2C_DEVNAME("unset"),
+        .name = "unset",
         .driver = &driver
 };
 
diff --git a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
--- a/drivers/media/video/msp3400.c
+++ b/drivers/media/video/msp3400.c
@@ -1437,7 +1437,7 @@ static struct i2c_driver driver = {
 
 static struct i2c_client client_template  {
-	I2C_DEVNAME("(unset)"),
+	.name      = "(unset)",
 	.flags     = I2C_CLIENT_ALLOW_USE,
         .driver    = &driver,
 };
@@ -1509,7 +1509,7 @@ static int msp_attach(struct i2c_adapter
 	}
 
 	/* hello world :-) */
-	printk(KERN_INFO "msp34xx: init: chip=%s",i2c_clientname(c));
+	printk(KERN_INFO "msp34xx: init: chip=%s", c->name);
 	if (HAVE_NICAM(msp))
 		printk(" +nicam");
 	if (HAVE_SIMPLE(msp))
diff --git a/drivers/media/video/ovcamchip/ovcamchip_core.c b/drivers/media/video/ovcamchip/ovcamchip_core.c
--- a/drivers/media/video/ovcamchip/ovcamchip_core.c
+++ b/drivers/media/video/ovcamchip/ovcamchip_core.c
@@ -314,7 +314,7 @@ static int ovcamchip_attach(struct i2c_a
 	}
 	memcpy(c, &client_template, sizeof *c);
 	c->adapter = adap;
-	strcpy(i2c_clientname(c), "OV????");
+	strcpy(c->name, "OV????");
 
 	ov = kmalloc(sizeof *ov, GFP_KERNEL);
 	if (!ov) {
@@ -328,7 +328,7 @@ static int ovcamchip_attach(struct i2c_a
 	if (rc < 0)
 		goto error;
 
-	strcpy(i2c_clientname(c), chip_names[ov->subtype]);
+	strcpy(c->name, chip_names[ov->subtype]);
 
 	PDEBUG(1, "Camera chip detection complete");
 
@@ -421,7 +421,7 @@ static struct i2c_driver driver = {
 };
 
 static struct i2c_client client_template = {
-	I2C_DEVNAME("(unset)"),
+	.name =		"(unset)",
 	.driver =	&driver,
 };
 
diff --git a/drivers/media/video/saa7134/saa6752hs.c b/drivers/media/video/saa7134/saa6752hs.c
--- a/drivers/media/video/saa7134/saa6752hs.c
+++ b/drivers/media/video/saa7134/saa6752hs.c
@@ -598,7 +598,7 @@ static struct i2c_driver driver = {
 
 static struct i2c_client client_template  {
-	I2C_DEVNAME("saa6752hs"),
+	.name       = "saa6752hs",
 	.flags      = I2C_CLIENT_ALLOW_USE,
         .driver     = &driver,
 };
diff --git a/drivers/media/video/saa7134/saa7134-i2c.c b/drivers/media/video/saa7134/saa7134-i2c.c
--- a/drivers/media/video/saa7134/saa7134-i2c.c
+++ b/drivers/media/video/saa7134/saa7134-i2c.c
@@ -334,7 +334,7 @@ static int attach_inform(struct i2c_clie
 	struct tuner_setup tun_setup;
 
 	d1printk( "%s i2c attach [addr=0x%x,client=%s]\n",
-		client->driver->name,client->addr,i2c_clientname(client));
+		 client->driver->name, client->addr, client->name);
 
 	if (!client->driver->command)
 		return 0;
@@ -380,14 +380,14 @@ static struct i2c_adapter saa7134_adap_t
 #ifdef I2C_CLASS_TV_ANALOG
 	.class         = I2C_CLASS_TV_ANALOG,
 #endif
-	I2C_DEVNAME("saa7134"),
+	.name          = "saa7134",
 	.id            = I2C_HW_SAA7134,
 	.algo          = &saa7134_algo,
 	.client_register = attach_inform,
 };
 
 static struct i2c_client saa7134_client_template = {
-	I2C_DEVNAME("saa7134 internal"),
+	.name	= "saa7134 internal",
 };
 
 /* ----------------------------------------------------------- */
diff --git a/drivers/media/video/tda7432.c b/drivers/media/video/tda7432.c
--- a/drivers/media/video/tda7432.c
+++ b/drivers/media/video/tda7432.c
@@ -513,7 +513,7 @@ static struct i2c_driver driver = {
 
 static struct i2c_client client_template  {
-	I2C_DEVNAME("tda7432"),
+	.name       = "tda7432",
 	.driver     = &driver,
 };
 
diff --git a/drivers/media/video/tda9840.c b/drivers/media/video/tda9840.c
--- a/drivers/media/video/tda9840.c
+++ b/drivers/media/video/tda9840.c
@@ -231,7 +231,7 @@ static struct i2c_driver driver = {
 };
 
 static struct i2c_client client_template = {
-	I2C_DEVNAME("tda9840"),
+	.name = "tda9840",
 	.driver = &driver,
 };
 
diff --git a/drivers/media/video/tda9875.c b/drivers/media/video/tda9875.c
--- a/drivers/media/video/tda9875.c
+++ b/drivers/media/video/tda9875.c
@@ -384,7 +384,7 @@ static struct i2c_driver driver = {
 
 static struct i2c_client client_template  {
-        I2C_DEVNAME("tda9875"),
+        .name      = "tda9875",
         .driver    = &driver,
 };
 
diff --git a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
--- a/drivers/media/video/tda9887.c
+++ b/drivers/media/video/tda9887.c
@@ -793,7 +793,7 @@ static struct i2c_driver driver = {
 };
 static struct i2c_client client_template  {
-	I2C_DEVNAME("tda9887"),
+	.name      = "tda9887",
 	.flags     = I2C_CLIENT_ALLOW_USE,
         .driver    = &driver,
 };
diff --git a/drivers/media/video/tea6415c.c b/drivers/media/video/tea6415c.c
--- a/drivers/media/video/tea6415c.c
+++ b/drivers/media/video/tea6415c.c
@@ -200,7 +200,7 @@ static struct i2c_driver driver = {
 };
 
 static struct i2c_client client_template = {
-	I2C_DEVNAME("tea6415c"),
+	.name = "tea6415c",
 	.driver = &driver,
 };
 
diff --git a/drivers/media/video/tea6420.c b/drivers/media/video/tea6420.c
--- a/drivers/media/video/tea6420.c
+++ b/drivers/media/video/tea6420.c
@@ -177,7 +177,7 @@ static struct i2c_driver driver = {
 };
 
 static struct i2c_client client_template = {
-	I2C_DEVNAME("tea6420"),
+	.name = "tea6420",
 	.driver = &driver,
 };
 
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -709,7 +709,7 @@ static struct i2c_driver driver = {
 		   },
 };
 static struct i2c_client client_template = {
-	I2C_DEVNAME("(tuner unset)"),
+	.name = "(tuner unset)",
 	.flags = I2C_CLIENT_ALLOW_USE,
 	.driver = &driver,
 };
diff --git a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
--- a/drivers/media/video/tvaudio.c
+++ b/drivers/media/video/tvaudio.c
@@ -162,24 +162,23 @@ static int chip_write(struct CHIPSTATE *
 	unsigned char buffer[2];
 
 	if (-1 = subaddr) {
-		dprintk("%s: chip_write: 0x%x\n",
-			i2c_clientname(&chip->c), val);
+		dprintk("%s: chip_write: 0x%x\n", chip->c.name, val);
 		chip->shadow.bytes[1] = val;
 		buffer[0] = val;
 		if (1 != i2c_master_send(&chip->c,buffer,1)) {
 			printk(KERN_WARNING "%s: I/O error (write 0x%x)\n",
-			       i2c_clientname(&chip->c), val);
+			       chip->c.name, val);
 			return -1;
 		}
 	} else {
 		dprintk("%s: chip_write: reg%d=0x%x\n",
-			i2c_clientname(&chip->c), subaddr, val);
+			chip->c.name, subaddr, val);
 		chip->shadow.bytes[subaddr+1] = val;
 		buffer[0] = subaddr;
 		buffer[1] = val;
 		if (2 != i2c_master_send(&chip->c,buffer,2)) {
 			printk(KERN_WARNING "%s: I/O error (write reg%d=0x%x)\n",
-			       i2c_clientname(&chip->c), subaddr, val);
+			       chip->c.name, subaddr, val);
 			return -1;
 		}
 	}
@@ -203,11 +202,10 @@ static int chip_read(struct CHIPSTATE *c
 	unsigned char buffer;
 
 	if (1 != i2c_master_recv(&chip->c,&buffer,1)) {
-		printk(KERN_WARNING "%s: I/O error (read)\n",
-		       i2c_clientname(&chip->c));
+		printk(KERN_WARNING "%s: I/O error (read)\n", chip->c.name);
 		return -1;
 	}
-	dprintk("%s: chip_read: 0x%x\n",i2c_clientname(&chip->c),buffer);
+	dprintk("%s: chip_read: 0x%x\n", chip->c.name, buffer);
 	return buffer;
 }
 
@@ -222,12 +220,11 @@ static int chip_read2(struct CHIPSTATE *
         write[0] = subaddr;
 
 	if (2 != i2c_transfer(chip->c.adapter,msgs,2)) {
-		printk(KERN_WARNING "%s: I/O error (read2)\n",
-		       i2c_clientname(&chip->c));
+		printk(KERN_WARNING "%s: I/O error (read2)\n", chip->c.name);
 		return -1;
 	}
 	dprintk("%s: chip_read2: reg%d=0x%x\n",
-		i2c_clientname(&chip->c),subaddr,read[0]);
+		chip->c.name, subaddr, read[0]);
 	return read[0];
 }
 
@@ -240,7 +237,7 @@ static int chip_cmd(struct CHIPSTATE *ch
 
 	/* update our shadow register set; print bytes if (debug > 0) */
 	dprintk("%s: chip_cmd(%s): reg=%d, data:",
-		i2c_clientname(&chip->c),name,cmd->bytes[0]);
+		chip->c.name, name, cmd->bytes[0]);
 	for (i = 1; i < cmd->count; i++) {
 		dprintk(" 0x%x",cmd->bytes[i]);
 		chip->shadow.bytes[i+cmd->bytes[0]] = cmd->bytes[i];
@@ -249,7 +246,7 @@ static int chip_cmd(struct CHIPSTATE *ch
 
 	/* send data to the chip */
 	if (cmd->count != i2c_master_send(&chip->c,cmd->bytes,cmd->count)) {
-		printk(KERN_WARNING "%s: I/O error (%s)\n", i2c_clientname(&chip->c), name);
+		printk(KERN_WARNING "%s: I/O error (%s)\n", chip->c.name, name);
 		return -1;
 	}
 	return 0;
@@ -274,9 +271,9 @@ static int chip_thread(void *data)
         struct CHIPSTATE *chip = data;
 	struct CHIPDESC  *desc = chiplist + chip->type;
 
-	daemonize("%s",i2c_clientname(&chip->c));
+	daemonize("%s", chip->c.name);
 	allow_signal(SIGTERM);
-	dprintk("%s: thread started\n", i2c_clientname(&chip->c));
+	dprintk("%s: thread started\n", chip->c.name);
 
 	for (;;) {
 		add_wait_queue(&chip->wq, &wait);
@@ -288,7 +285,7 @@ static int chip_thread(void *data)
 		try_to_freeze();
 		if (chip->done || signal_pending(current))
 			break;
-		dprintk("%s: thread wakeup\n", i2c_clientname(&chip->c));
+		dprintk("%s: thread wakeup\n", chip->c.name);
 
 		/* don't do anything for radio or if mode != auto */
 		if (chip->norm = VIDEO_MODE_RADIO || chip->mode != 0)
@@ -301,7 +298,7 @@ static int chip_thread(void *data)
 		mod_timer(&chip->wt, jiffies+2*HZ);
 	}
 
-	dprintk("%s: thread exiting\n", i2c_clientname(&chip->c));
+	dprintk("%s: thread exiting\n", chip->c.name);
         complete_and_exit(&chip->texit, 0);
 	return 0;
 }
@@ -314,7 +311,7 @@ static void generic_checkmode(struct CHI
 	if (mode = chip->prevmode)
 	    return;
 
-	dprintk("%s: thread checkmode\n", i2c_clientname(&chip->c));
+	dprintk("%s: thread checkmode\n", chip->c.name);
 	chip->prevmode = mode;
 
 	if (mode & VIDEO_SOUND_STEREO)
@@ -1501,7 +1498,7 @@ static int chip_attach(struct i2c_adapte
 		(desc->flags & CHIP_HAS_INPUTSEL)   ? " audiomux"    : "");
 
 	/* fill required data structures */
-	strcpy(i2c_clientname(&chip->c),desc->name);
+	strcpy(chip->c.name, desc->name);
 	chip->type = desc-chiplist;
 	chip->shadow.count = desc->registers+1;
         chip->prevmode = -1;
@@ -1538,7 +1535,7 @@ static int chip_attach(struct i2c_adapte
 		chip->tpid = kernel_thread(chip_thread,(void *)chip,0);
 		if (chip->tpid < 0)
 			printk(KERN_WARNING "%s: kernel_thread() failed\n",
-			       i2c_clientname(&chip->c));
+			       chip->c.name);
 		wake_up_interruptible(&chip->wq);
 	}
 	return 0;
@@ -1591,7 +1588,7 @@ static int chip_command(struct i2c_clien
 	struct CHIPSTATE *chip = i2c_get_clientdata(client);
 	struct CHIPDESC  *desc = chiplist + chip->type;
 
-	dprintk("%s: chip_command 0x%x\n",i2c_clientname(&chip->c),cmd);
+	dprintk("%s: chip_command 0x%x\n", chip->c.name, cmd);
 
 	switch (cmd) {
 	case AUDC_SET_INPUT:
@@ -1702,7 +1699,7 @@ static struct i2c_driver driver = {
 
 static struct i2c_client client_template  {
-	I2C_DEVNAME("(unset)"),
+	.name       = "(unset)",
 	.flags      = I2C_CLIENT_ALLOW_USE,
         .driver     = &driver,
 };
diff --git a/drivers/media/video/tvmixer.c b/drivers/media/video/tvmixer.c
--- a/drivers/media/video/tvmixer.c
+++ b/drivers/media/video/tvmixer.c
@@ -91,7 +91,7 @@ static int tvmixer_ioctl(struct inode *i
         if (cmd = SOUND_MIXER_INFO) {
                 mixer_info info;
                 strlcpy(info.id, "tv card", sizeof(info.id));
-                strlcpy(info.name, i2c_clientname(client), sizeof(info.name));
+                strlcpy(info.name, client->name, sizeof(info.name));
                 info.modify_counter = 42 /* FIXME */;
                 if (copy_to_user(argp, &info, sizeof(info)))
                         return -EFAULT;
@@ -100,7 +100,7 @@ static int tvmixer_ioctl(struct inode *i
         if (cmd = SOUND_OLD_MIXER_INFO) {
                 _old_mixer_info info;
                 strlcpy(info.id, "tv card", sizeof(info.id));
-                strlcpy(info.name, i2c_clientname(client), sizeof(info.name));
+                strlcpy(info.name, client->name, sizeof(info.name));
                 if (copy_to_user(argp, &info, sizeof(info)))
                         return -EFAULT;
                 return 0;
@@ -295,7 +295,7 @@ static int tvmixer_clients(struct i2c_cl
 			devices[i].dev = NULL;
 			devices[i].minor = -1;
 			printk("tvmixer: %s unregistered (#1)\n",
-			       i2c_clientname(client));
+			       client->name);
 			return 0;
 		}
 	}
@@ -354,7 +354,7 @@ static void __exit tvmixer_cleanup_modul
 		if (devices[i].minor != -1) {
 			unregister_sound_mixer(devices[i].minor);
 			printk("tvmixer: %s unregistered (#2)\n",
-			       i2c_clientname(devices[i].dev));
+			       devices[i].dev->name);
 		}
 	}
 }
diff --git a/drivers/media/video/zoran_card.c b/drivers/media/video/zoran_card.c
--- a/drivers/media/video/zoran_card.c
+++ b/drivers/media/video/zoran_card.c
@@ -737,7 +737,7 @@ static struct i2c_algo_bit_data zoran_i2
 };
 
 static struct i2c_adapter zoran_i2c_adapter_template = {
-	I2C_DEVNAME("zr36057"),
+	.name = "zr36057",
 	.id = I2C_HW_B_ZR36067,
 	.algo = NULL,
 	.client_register = zoran_i2c_client_register,
diff --git a/drivers/usb/media/w9968cf.c b/drivers/usb/media/w9968cf.c
--- a/drivers/usb/media/w9968cf.c
+++ b/drivers/usb/media/w9968cf.c
@@ -1523,7 +1523,6 @@ static u32 w9968cf_i2c_func(struct i2c_a
 static int w9968cf_i2c_attach_inform(struct i2c_client* client)
 {
 	struct w9968cf_device* cam = i2c_get_adapdata(client->adapter);
-	const char* clientname = i2c_clientname(client);
 	int id = client->driver->id, err = 0;
 
 	if (id = I2C_DRIVERID_OVCAMCHIP) {
@@ -1535,12 +1534,12 @@ static int w9968cf_i2c_attach_inform(str
 		}
 	} else {
 		DBG(4, "Rejected client [%s] with driver [%s]", 
-		    clientname, client->driver->name)
+		    client->name, client->driver->name)
 		return -EINVAL;
 	}
 
 	DBG(5, "I2C attach client [%s] with driver [%s]",
-	    clientname, client->driver->name)
+	    client->name, client->driver->name)
 
 	return 0;
 }
@@ -1549,12 +1548,11 @@ static int w9968cf_i2c_attach_inform(str
 static int w9968cf_i2c_detach_inform(struct i2c_client* client)
 {
 	struct w9968cf_device* cam = i2c_get_adapdata(client->adapter);
-	const char* clientname = i2c_clientname(client);
 
 	if (cam->sensor_client = client)
 		cam->sensor_client = NULL;
 
-	DBG(5, "I2C detach client [%s]", clientname)
+	DBG(5, "I2C detach client [%s]", client->name)
 
 	return 0;
 }
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -178,13 +178,6 @@ static inline void i2c_set_clientdata (s
 	dev_set_drvdata (&dev->dev, data);
 }
 
-#define I2C_DEVNAME(str)	.name = str
-
-static inline char *i2c_clientname(struct i2c_client *c)
-{
-	return &c->name[0];
-}
-
 /*
  * The following structs are for those who like to implement new bus drivers:
  * i2c_algorithm is the interface to a class of hardware solutions which can

