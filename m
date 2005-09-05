From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:49:13 +0000
Subject: [lm-sensors] [PATCH] I2C: Kill i2c_algorithm.id (6/7)
Message-Id: <11259567702508@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Kill i2c_algorithm.id (6/7)

In theory, there should be no more users of I2C_ALGO_* at this point.
However, it happens that several drivers were using I2C_ALGO_* for
adapter ids, so we need to correct these before we can get rid of all
the I2C_ALGO_* definitions.

Note that this also fixes a bug in media/video/tvaudio.c:

	/* don't attach on saa7146 based cards,
	   because dedicated drivers are used */
	if ((adap->id & I2C_ALGO_SAA7146))
		return 0;

This test was plain broken, as it would succeed for many more adapters
than just the saa7146: any those id would share at least one bit with
the saa7146 id. We are really lucky that the few other adapters we want
this driver to work with did not fulfill that condition.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 1684a984303abbfc39aa8b59b0fe825c717811a9
tree 5ba646c7c81f1ed3a2bbc032a412dcff21fc7c37
parent c7a46533ff7ef9e1c51bae6e54208527c5275b24
author Jean Delvare <khali@linux-fr.org> Thu, 11 Aug 2005 23:51:10 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:32 -0700

 drivers/i2c/busses/i2c-keywest.c                  |    1 -
 drivers/i2c/busses/scx200_acb.c                   |    2 +-
 drivers/media/common/saa7146_i2c.c                |    2 +-
 drivers/media/dvb/b2c2/flexcop-i2c.c              |    1 -
 drivers/media/dvb/dvb-usb/dvb-usb-i2c.c           |    1 -
 drivers/media/dvb/pluto2/pluto2.c                 |    1 -
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    1 -
 drivers/media/video/ir-kbd-i2c.c                  |    2 +-
 drivers/media/video/saa7134/saa7134-i2c.c         |    2 +-
 drivers/media/video/tda9840.c                     |    2 +-
 drivers/media/video/tda9887.c                     |    2 +-
 drivers/media/video/tea6415c.c                    |    2 +-
 drivers/media/video/tea6420.c                     |    2 +-
 drivers/media/video/tvaudio.c                     |    4 ++--
 drivers/video/aty/radeon_i2c.c                    |    2 +-
 drivers/video/nvidia/nv_i2c.c                     |    3 +--
 drivers/video/riva/rivafb-i2c.c                   |    3 +--
 drivers/video/savage/savagefb-i2c.c               |    3 +--
 include/linux/i2c-id.h                            |    7 +++++++
 include/media/id.h                                |    5 -----
 20 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
--- a/drivers/i2c/busses/i2c-keywest.c
+++ b/drivers/i2c/busses/i2c-keywest.c
@@ -619,7 +619,6 @@ create_iface(struct device_node *np, str
 		sprintf(chan->adapter.name, "%s %d", np->parent->name, i);
 		chan->iface = iface;
 		chan->chan_no = i;
-		chan->adapter.id = I2C_ALGO_SMBUS;
 		chan->adapter.algo = &keywest_algorithm;
 		chan->adapter.algo_data = NULL;
 		chan->adapter.client_register = NULL;
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -454,7 +454,7 @@ static int  __init scx200_acb_create(int
 	i2c_set_adapdata(adapter, iface);
 	snprintf(adapter->name, I2C_NAME_SIZE, "SCx200 ACB%d", index);
 	adapter->owner = THIS_MODULE;
-	adapter->id = I2C_ALGO_SMBUS;
+	adapter->id = I2C_HW_SMBUS_SCX200;
 	adapter->algo = &scx200_acb_algorithm;
 	adapter->class = I2C_CLASS_HWMON;
 
diff --git a/drivers/media/common/saa7146_i2c.c b/drivers/media/common/saa7146_i2c.c
--- a/drivers/media/common/saa7146_i2c.c
+++ b/drivers/media/common/saa7146_i2c.c
@@ -410,7 +410,7 @@ int saa7146_i2c_adapter_prepare(struct s
 #endif
 		i2c_adapter->algo	   = &saa7146_algo;
 		i2c_adapter->algo_data     = NULL;
-		i2c_adapter->id		   = I2C_ALGO_SAA7146;
+		i2c_adapter->id		   = I2C_HW_SAA7146;
 		i2c_adapter->timeout = SAA7146_I2C_TIMEOUT;
 		i2c_adapter->retries = SAA7146_I2C_RETRIES;
 	}
diff --git a/drivers/media/dvb/b2c2/flexcop-i2c.c b/drivers/media/dvb/b2c2/flexcop-i2c.c
--- a/drivers/media/dvb/b2c2/flexcop-i2c.c
+++ b/drivers/media/dvb/b2c2/flexcop-i2c.c
@@ -190,7 +190,6 @@ int flexcop_i2c_init(struct flexcop_devi
 	fc->i2c_adap.class	    = I2C_CLASS_TV_DIGITAL;
 	fc->i2c_adap.algo       = &flexcop_algo;
 	fc->i2c_adap.algo_data  = NULL;
-	fc->i2c_adap.id         = I2C_ALGO_BIT;
 
 	if ((ret = i2c_add_adapter(&fc->i2c_adap)) < 0)
 		return ret;
diff --git a/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c b/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c
--- a/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c
+++ b/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c
@@ -27,7 +27,6 @@ int dvb_usb_i2c_init(struct dvb_usb_devi
 #endif
 	d->i2c_adap.algo      = d->props.i2c_algo;
 	d->i2c_adap.algo_data = NULL;
-	d->i2c_adap.id        = I2C_ALGO_BIT;
 
 	i2c_set_adapdata(&d->i2c_adap, d);
 
diff --git a/drivers/media/dvb/pluto2/pluto2.c b/drivers/media/dvb/pluto2/pluto2.c
--- a/drivers/media/dvb/pluto2/pluto2.c
+++ b/drivers/media/dvb/pluto2/pluto2.c
@@ -633,7 +633,6 @@ static int __devinit pluto2_probe(struct
 	i2c_set_adapdata(&pluto->i2c_adap, pluto);
 	strcpy(pluto->i2c_adap.name, DRIVER_NAME);
 	pluto->i2c_adap.owner = THIS_MODULE;
-	pluto->i2c_adap.id = I2C_ALGO_BIT;
 	pluto->i2c_adap.class = I2C_CLASS_TV_DIGITAL;
 	pluto->i2c_adap.dev.parent = &pdev->dev;
 	pluto->i2c_adap.algo_data = &pluto->i2c_bit;
diff --git a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
+++ b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
@@ -1523,7 +1523,6 @@ static int ttusb_probe(struct usb_interf
 #endif
 	ttusb->i2c_adap.algo              = &ttusb_dec_algo;
 	ttusb->i2c_adap.algo_data         = NULL;
-	ttusb->i2c_adap.id                = I2C_ALGO_BIT;
 
 	result = i2c_add_adapter(&ttusb->i2c_adap);
 	if (result) {
diff --git a/drivers/media/video/ir-kbd-i2c.c b/drivers/media/video/ir-kbd-i2c.c
--- a/drivers/media/video/ir-kbd-i2c.c
+++ b/drivers/media/video/ir-kbd-i2c.c
@@ -432,7 +432,7 @@ static int ir_probe(struct i2c_adapter *
 	case I2C_HW_B_BT848:
 		probe = probe_bttv;
 		break;
-	case I2C_ALGO_SAA7134:
+	case I2C_HW_SAA7134:
 		probe = probe_saa7134;
 		break;
 	}
diff --git a/drivers/media/video/saa7134/saa7134-i2c.c b/drivers/media/video/saa7134/saa7134-i2c.c
--- a/drivers/media/video/saa7134/saa7134-i2c.c
+++ b/drivers/media/video/saa7134/saa7134-i2c.c
@@ -381,7 +381,7 @@ static struct i2c_adapter saa7134_adap_t
 	.class         = I2C_CLASS_TV_ANALOG,
 #endif
 	I2C_DEVNAME("saa7134"),
-	.id            = I2C_ALGO_SAA7134,
+	.id            = I2C_HW_SAA7134,
 	.algo          = &saa7134_algo,
 	.client_register = attach_inform,
 };
diff --git a/drivers/media/video/tda9840.c b/drivers/media/video/tda9840.c
--- a/drivers/media/video/tda9840.c
+++ b/drivers/media/video/tda9840.c
@@ -205,7 +205,7 @@ static int detect(struct i2c_adapter *ad
 static int attach(struct i2c_adapter *adapter)
 {
 	/* let's see whether this is a know adapter we can attach to */
-	if (adapter->id != I2C_ALGO_SAA7146) {
+	if (adapter->id != I2C_HW_SAA7146) {
 		dprintk("refusing to probe on unknown adapter [name='%s',id=0x%x]\n", adapter->name, adapter->id);
 		return -ENODEV;
 	}
diff --git a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
--- a/drivers/media/video/tda9887.c
+++ b/drivers/media/video/tda9887.c
@@ -620,7 +620,7 @@ static int tda9887_probe(struct i2c_adap
 	switch (adap->id) {
 	case I2C_HW_B_BT848:
 	case I2C_HW_B_RIVA:
-	case I2C_ALGO_SAA7134:
+	case I2C_HW_SAA7134:
 		return i2c_probe(adap, &addr_data, tda9887_attach);
 		break;
 	}
diff --git a/drivers/media/video/tea6415c.c b/drivers/media/video/tea6415c.c
--- a/drivers/media/video/tea6415c.c
+++ b/drivers/media/video/tea6415c.c
@@ -86,7 +86,7 @@ static int detect(struct i2c_adapter *ad
 static int attach(struct i2c_adapter *adapter)
 {
 	/* let's see whether this is a know adapter we can attach to */
-	if (adapter->id != I2C_ALGO_SAA7146) {
+	if (adapter->id != I2C_HW_SAA7146) {
 		dprintk("refusing to probe on unknown adapter [name='%s',id=0x%x]\n", adapter->name, adapter->id);
 		return -ENODEV;
 	}
diff --git a/drivers/media/video/tea6420.c b/drivers/media/video/tea6420.c
--- a/drivers/media/video/tea6420.c
+++ b/drivers/media/video/tea6420.c
@@ -135,7 +135,7 @@ static int tea6420_detect(struct i2c_ada
 static int attach(struct i2c_adapter *adapter)
 {
 	/* let's see whether this is a know adapter we can attach to */
-	if (adapter->id != I2C_ALGO_SAA7146) {
+	if (adapter->id != I2C_HW_SAA7146) {
 		dprintk("refusing to probe on unknown adapter [name='%s',id=0x%x]\n", adapter->name, adapter->id);
 		return -ENODEV;
 	}
diff --git a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
--- a/drivers/media/video/tvaudio.c
+++ b/drivers/media/video/tvaudio.c
@@ -1548,7 +1548,7 @@ static int chip_probe(struct i2c_adapter
 {
 	/* don't attach on saa7146 based cards,
 	   because dedicated drivers are used */
-	if ((adap->id & I2C_ALGO_SAA7146))
+	if (adap->id = I2C_HW_SAA7146)
 		return 0;
 #ifdef I2C_CLASS_TV_ANALOG
 	if (adap->class & I2C_CLASS_TV_ANALOG)
@@ -1557,7 +1557,7 @@ static int chip_probe(struct i2c_adapter
 	switch (adap->id) {
 	case I2C_HW_B_BT848:
 	case I2C_HW_B_RIVA:
-	case I2C_ALGO_SAA7134:
+	case I2C_HW_SAA7134:
 		return i2c_probe(adap, &addr_data, chip_attach);
 	}
 #endif
diff --git a/drivers/video/aty/radeon_i2c.c b/drivers/video/aty/radeon_i2c.c
--- a/drivers/video/aty/radeon_i2c.c
+++ b/drivers/video/aty/radeon_i2c.c
@@ -75,7 +75,7 @@ static int radeon_setup_i2c_bus(struct r
 
 	strcpy(chan->adapter.name, name);
 	chan->adapter.owner		= THIS_MODULE;
-	chan->adapter.id		= I2C_ALGO_ATI;
+	chan->adapter.id		= I2C_HW_B_RADEON;
 	chan->adapter.algo_data		= &chan->algo;
 	chan->adapter.dev.parent	= &chan->rinfo->pdev->dev;
 	chan->algo.setsda		= radeon_gpio_setsda;
diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -90,14 +90,13 @@ static int nvidia_gpio_getsda(void *data
 	return val;
 }
 
-#define I2C_ALGO_NVIDIA   0x0e0000
 static int nvidia_setup_i2c_bus(struct nvidia_i2c_chan *chan, const char *name)
 {
 	int rc;
 
 	strcpy(chan->adapter.name, name);
 	chan->adapter.owner = THIS_MODULE;
-	chan->adapter.id = I2C_ALGO_NVIDIA;
+	chan->adapter.id = I2C_HW_B_NVIDIA;
 	chan->adapter.algo_data = &chan->algo;
 	chan->adapter.dev.parent = &chan->par->pci_dev->dev;
 	chan->algo.setsda = nvidia_gpio_setsda;
diff --git a/drivers/video/riva/rivafb-i2c.c b/drivers/video/riva/rivafb-i2c.c
--- a/drivers/video/riva/rivafb-i2c.c
+++ b/drivers/video/riva/rivafb-i2c.c
@@ -92,14 +92,13 @@ static int riva_gpio_getsda(void* data)
 	return val;
 }
 
-#define I2C_ALGO_RIVA   0x0e0000
 static int riva_setup_i2c_bus(struct riva_i2c_chan *chan, const char *name)
 {
 	int rc;
 
 	strcpy(chan->adapter.name, name);
 	chan->adapter.owner		= THIS_MODULE;
-	chan->adapter.id		= I2C_ALGO_RIVA;
+	chan->adapter.id		= I2C_HW_B_RIVA;
 	chan->adapter.algo_data		= &chan->algo;
 	chan->adapter.dev.parent	= &chan->par->pdev->dev;
 	chan->algo.setsda		= riva_gpio_setsda;
diff --git a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
--- a/drivers/video/savage/savagefb-i2c.c
+++ b/drivers/video/savage/savagefb-i2c.c
@@ -137,7 +137,6 @@ static int prosavage_gpio_getsda(void* d
 	return (0 != (GET_CR_DATA(chan->ioaddr) & PROSAVAGE_I2C_SDA_IN));
 }
 
-#define I2C_ALGO_SAVAGE   0x0f0000
 static int savage_setup_i2c_bus(struct savagefb_i2c_chan *chan,
 				const char *name)
 {
@@ -147,7 +146,7 @@ static int savage_setup_i2c_bus(struct s
 	if (add_bus && chan->par) {
 		strcpy(chan->adapter.name, name);
 		chan->adapter.owner		= THIS_MODULE;
-		chan->adapter.id		= I2C_ALGO_SAVAGE;
+		chan->adapter.id		= I2C_HW_B_SAVAGE;
 		chan->adapter.algo_data		= &chan->algo;
 		chan->adapter.dev.parent	= &chan->par->pcidev->dev;
 		chan->algo.udelay		= 40;
diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -245,6 +245,9 @@
 #define I2C_HW_B_ZR36067	0x010019 /* Zoran-36057/36067 based boards */
 #define I2C_HW_B_PCILYNX	0x01001a /* TI PCILynx I2C adapter */
 #define I2C_HW_B_CX2388x	0x01001b /* connexant 2388x based tv cards */
+#define I2C_HW_B_NVIDIA		0x01001c /* nvidia framebuffer driver */
+#define I2C_HW_B_SAVAGE		0x01001d /* savage framebuffer driver */
+#define I2C_HW_B_RADEON		0x01001e /* radeon framebuffer driver */
 
 /* --- PCF 8584 based algorithms					*/
 #define I2C_HW_P_LP		0x020000 /* Parallel port interface */
@@ -317,4 +320,8 @@
 /* --- Marvell mv64xxx i2c adapter */
 #define I2C_HW_MV64XXX		0x190000
 
+/* --- Miscellaneous adapters */
+#define I2C_HW_SAA7146		0x060000 /* SAA7146 video decoder bus */
+#define I2C_HW_SAA7134		0x090000 /* SAA7134 video decoder bus */
+
 #endif /* LINUX_I2C_ID_H */
diff --git a/include/media/id.h b/include/media/id.h
--- a/include/media/id.h
+++ b/include/media/id.h
@@ -34,8 +34,3 @@
 #ifndef  I2C_DRIVERID_SAA6752HS
 # define I2C_DRIVERID_SAA6752HS I2C_DRIVERID_EXP0+8
 #endif
-
-/* algorithms */
-#ifndef I2C_ALGO_SAA7134
-# define I2C_ALGO_SAA7134 0x090000
-#endif

