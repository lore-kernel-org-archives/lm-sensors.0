From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:30 +0000
Subject: [lm-sensors] [PATCH] I2C: Kill i2c_algorithm.id (5/7)
Message-Id: <11259567702509@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Kill i2c_algorithm.id (5/7)

Merge the algorithm id part (16 upper bits) of the i2c adapters ids
into the definition of the adapters ids directly. After that, we don't
need to OR both ids together for each i2c_adapter structure.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c7a46533ff7ef9e1c51bae6e54208527c5275b24
tree 4b952a757d60d9cfa4aad8462ee8ef7e03fec6dd
parent 1d8b9e1bad35fa3ea829990b9056c2a257d8fe79
author Jean Delvare <khali@linux-fr.org> Thu, 11 Aug 2005 23:41:56 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:31 -0700

 drivers/i2c/algos/i2c-algo-bit.c               |    2 
 drivers/i2c/algos/i2c-algo-ite.c               |    2 
 drivers/i2c/algos/i2c-algo-pca.c               |    2 
 drivers/i2c/algos/i2c-algo-pcf.c               |    2 
 drivers/i2c/algos/i2c-algo-sgi.c               |    1 
 drivers/i2c/algos/i2c-algo-sibyte.c            |    2 
 drivers/i2c/busses/i2c-ibm_iic.c               |    2 
 drivers/i2c/busses/i2c-isa.c                   |    2 
 drivers/i2c/busses/i2c-mpc.c                   |    2 
 drivers/i2c/busses/i2c-mv64xxx.c               |    2 
 drivers/media/video/bt832.c                    |    2 
 drivers/media/video/bttv-i2c.c                 |    2 
 drivers/media/video/ir-kbd-i2c.c               |    2 
 drivers/media/video/ovcamchip/ov6x20.c         |    6 +
 drivers/media/video/ovcamchip/ov6x30.c         |    4 -
 drivers/media/video/ovcamchip/ovcamchip_core.c |    8 +-
 drivers/media/video/tda7432.c                  |    2 
 drivers/media/video/tda9875.c                  |    2 
 drivers/media/video/tda9887.c                  |    4 -
 drivers/media/video/tuner-3036.c               |    2 
 drivers/media/video/tvaudio.c                  |    6 +
 drivers/media/video/tveeprom.c                 |    2 
 drivers/media/video/tvmixer.c                  |    6 +
 drivers/usb/media/w9968cf.c                    |    2 
 drivers/video/matrox/matroxfb_maven.c          |    2 
 include/linux/i2c-id.h                         |  128 ++++++++++++------------
 include/linux/i2c-isa.h                        |    2 
 27 files changed, 95 insertions(+), 106 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -539,8 +539,6 @@ int i2c_bit_add_bus(struct i2c_adapter *
 	DEB2(dev_dbg(&adap->dev, "hw routines registered.\n"));
 
 	/* register new adapter to i2c module... */
-
-	adap->id |= I2C_ALGO_BIT;
 	adap->algo = &i2c_bit_algo;
 
 	adap->timeout = 100;	/* default values, should	*/
diff --git a/drivers/i2c/algos/i2c-algo-ite.c b/drivers/i2c/algos/i2c-algo-ite.c
--- a/drivers/i2c/algos/i2c-algo-ite.c
+++ b/drivers/i2c/algos/i2c-algo-ite.c
@@ -736,8 +736,6 @@ int i2c_iic_add_bus(struct i2c_adapter *
 	            adap->name));
 
 	/* register new adapter to i2c module... */
-
-	adap->id |= I2C_ALGO_IIC;
 	adap->algo = &iic_algo;
 
 	adap->timeout = 100;	/* default values, should	*/
diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -369,8 +369,6 @@ int i2c_pca_add_bus(struct i2c_adapter *
 	int rval;
 
 	/* register new adapter to i2c module... */
-
-	adap->id |= I2C_ALGO_PCA;
 	adap->algo = &pca_algo;
 
 	adap->timeout = 100;		/* default values, should	*/
diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -474,8 +474,6 @@ int i2c_pcf_add_bus(struct i2c_adapter *
 	DEB2(dev_dbg(&adap->dev, "hw routines registered.\n"));
 
 	/* register new adapter to i2c module... */
-
-	adap->id |= I2C_ALGO_PCF;
 	adap->algo = &pcf_algo;
 
 	adap->timeout = 100;		/* default values, should	*/
diff --git a/drivers/i2c/algos/i2c-algo-sgi.c b/drivers/i2c/algos/i2c-algo-sgi.c
--- a/drivers/i2c/algos/i2c-algo-sgi.c
+++ b/drivers/i2c/algos/i2c-algo-sgi.c
@@ -167,7 +167,6 @@ static struct i2c_algorithm sgi_algo = {
  */
 int i2c_sgi_add_bus(struct i2c_adapter *adap)
 {
-	adap->id |= I2C_ALGO_SGI;
 	adap->algo = &sgi_algo;
 
 	return i2c_add_adapter(adap);
diff --git a/drivers/i2c/algos/i2c-algo-sibyte.c b/drivers/i2c/algos/i2c-algo-sibyte.c
--- a/drivers/i2c/algos/i2c-algo-sibyte.c
+++ b/drivers/i2c/algos/i2c-algo-sibyte.c
@@ -149,8 +149,6 @@ int i2c_sibyte_add_bus(struct i2c_adapte
 	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
 
 	/* register new adapter to i2c module... */
-
-	i2c_adap->id |= I2C_ALGO_SIBYTE;
 	i2c_adap->algo = &i2c_sibyte_algo;
         
         /* Set the frequency to 100 kHz */
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -725,7 +725,7 @@ static int __devinit iic_probe(struct oc
 	adap = &dev->adap;
 	strcpy(adap->name, "IBM IIC");
 	i2c_set_adapdata(adap, dev);
-	adap->id = I2C_ALGO_OCP | I2C_HW_OCP;
+	adap->id = I2C_HW_OCP;
 	adap->algo = &iic_algo;
 	adap->client_register = NULL;
 	adap->client_unregister = NULL;
diff --git a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c
+++ b/drivers/i2c/busses/i2c-isa.c
@@ -49,7 +49,7 @@ static struct i2c_algorithm isa_algorith
 /* There can only be one... */
 static struct i2c_adapter isa_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_ALGO_ISA | I2C_HW_ISA,
+	.id		= I2C_HW_ISA,
 	.class          = I2C_CLASS_HWMON,
 	.algo		= &isa_algorithm,
 	.name		= "ISA main adapter",
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -279,7 +279,7 @@ static struct i2c_algorithm mpc_algo = {
 static struct i2c_adapter mpc_ops = {
 	.owner = THIS_MODULE,
 	.name = "MPC adapter",
-	.id = I2C_ALGO_MPC107 | I2C_HW_MPC107,
+	.id = I2C_HW_MPC107,
 	.algo = &mpc_algo,
 	.class = I2C_CLASS_HWMON,
 	.timeout = 1,
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -521,7 +521,7 @@ mv64xxx_i2c_probe(struct device *dev)
 	drv_data->freq_m = pdata->freq_m;
 	drv_data->freq_n = pdata->freq_n;
 	drv_data->irq = platform_get_irq(pd, 0);
-	drv_data->adapter.id = I2C_ALGO_MV64XXX | I2C_HW_MV64XXX;
+	drv_data->adapter.id = I2C_HW_MV64XXX;
 	drv_data->adapter.algo = &mv64xxx_i2c_algo;
 	drv_data->adapter.owner = THIS_MODULE;
 	drv_data->adapter.class = I2C_CLASS_HWMON;
diff --git a/drivers/media/video/bt832.c b/drivers/media/video/bt832.c
--- a/drivers/media/video/bt832.c
+++ b/drivers/media/video/bt832.c
@@ -188,7 +188,7 @@ static int bt832_probe(struct i2c_adapte
 	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, bt832_attach);
 #else
-	if (adap->id = (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adap->id = I2C_HW_B_BT848)
 		return i2c_probe(adap, &addr_data, bt832_attach);
 #endif
 	return 0;
diff --git a/drivers/media/video/bttv-i2c.c b/drivers/media/video/bttv-i2c.c
--- a/drivers/media/video/bttv-i2c.c
+++ b/drivers/media/video/bttv-i2c.c
@@ -281,7 +281,7 @@ static struct i2c_adapter bttv_i2c_adap_
 	.class         = I2C_CLASS_TV_ANALOG,
 #endif
 	I2C_DEVNAME("bt878"),
-	.id            = I2C_ALGO_BIT | I2C_HW_B_BT848 /* FIXME */,
+	.id            = I2C_HW_B_BT848 /* FIXME */,
 	.algo          = &bttv_algo,
 	.client_register = attach_inform,
 };
diff --git a/drivers/media/video/ir-kbd-i2c.c b/drivers/media/video/ir-kbd-i2c.c
--- a/drivers/media/video/ir-kbd-i2c.c
+++ b/drivers/media/video/ir-kbd-i2c.c
@@ -429,7 +429,7 @@ static int ir_probe(struct i2c_adapter *
 	struct i2c_client c; char buf; int i,rc;
 
 	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
+	case I2C_HW_B_BT848:
 		probe = probe_bttv;
 		break;
 	case I2C_ALGO_SAA7134:
diff --git a/drivers/media/video/ovcamchip/ov6x20.c b/drivers/media/video/ovcamchip/ov6x20.c
--- a/drivers/media/video/ovcamchip/ov6x20.c
+++ b/drivers/media/video/ovcamchip/ov6x20.c
@@ -164,10 +164,10 @@ static int ov6x20_init(struct i2c_client
 	DDEBUG(4, &c->dev, "entered");
 
 	switch (c->adapter->id) {
-	case I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV511:
+	case I2C_HW_SMBUS_OV511:
 		rc = ov_write_regvals(c, regvals_init_6x20_511);
 		break;
-	case I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518:
+	case I2C_HW_SMBUS_OV518:
 		rc = ov_write_regvals(c, regvals_init_6x20_518);
 		break;
 	default:
@@ -338,7 +338,7 @@ static int ov6x20_mode_init(struct i2c_c
 	/******** Palette-specific regs ********/
 
 	/* OV518 needs 8 bit multiplexed in color mode, and 16 bit in B&W */
-	if (c->adapter->id = (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518)) {
+	if (c->adapter->id = I2C_HW_SMBUS_OV518) {
 		if (win->format = VIDEO_PALETTE_GREY)
 			ov_write_mask(c, 0x13, 0x00, 0x20);
 		else
diff --git a/drivers/media/video/ovcamchip/ov6x30.c b/drivers/media/video/ovcamchip/ov6x30.c
--- a/drivers/media/video/ovcamchip/ov6x30.c
+++ b/drivers/media/video/ovcamchip/ov6x30.c
@@ -301,7 +301,7 @@ static int ov6x30_mode_init(struct i2c_c
 	/******** Palette-specific regs ********/
 
 	if (win->format = VIDEO_PALETTE_GREY) {
-		if (c->adapter->id = (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518)) {
+		if (c->adapter->id = I2C_HW_SMBUS_OV518) {
 			/* Do nothing - we're already in 8-bit mode */
 		} else {
 			ov_write_mask(c, 0x13, 0x20, 0x20);
@@ -313,7 +313,7 @@ static int ov6x30_mode_init(struct i2c_c
 		 * Therefore, the OV6630 needs to be in 8-bit multiplexed
 		 * output mode */
 
-		if (c->adapter->id = (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518)) {
+		if (c->adapter->id = I2C_HW_SMBUS_OV518) {
 			/* Do nothing - we want to stay in 8-bit mode */
 			/* Warning: Messing with reg 0x13 breaks OV518 color */
 		} else {
diff --git a/drivers/media/video/ovcamchip/ovcamchip_core.c b/drivers/media/video/ovcamchip/ovcamchip_core.c
--- a/drivers/media/video/ovcamchip/ovcamchip_core.c
+++ b/drivers/media/video/ovcamchip/ovcamchip_core.c
@@ -296,10 +296,10 @@ static int ovcamchip_attach(struct i2c_a
 	 * attach to adapters that are known to contain OV camera chips. */
 
 	switch (adap->id) {
-	case (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV511):
-	case (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518):
-	case (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OVFX2):
-	case (I2C_ALGO_SMBUS | I2C_HW_SMBUS_W9968CF):
+	case I2C_HW_SMBUS_OV511:
+	case I2C_HW_SMBUS_OV518:
+	case I2C_HW_SMBUS_OVFX2:
+	case I2C_HW_SMBUS_W9968CF:
 		PDEBUG(1, "Adapter ID 0x%06x accepted", adap->id);
 		break;
 	default:
diff --git a/drivers/media/video/tda7432.c b/drivers/media/video/tda7432.c
--- a/drivers/media/video/tda7432.c
+++ b/drivers/media/video/tda7432.c
@@ -328,7 +328,7 @@ static int tda7432_probe(struct i2c_adap
 	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda7432_attach);
 #else
-	if (adap->id = (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adap->id = I2C_HW_B_BT848)
 		return i2c_probe(adap, &addr_data, tda7432_attach);
 #endif
 	return 0;
diff --git a/drivers/media/video/tda9875.c b/drivers/media/video/tda9875.c
--- a/drivers/media/video/tda9875.c
+++ b/drivers/media/video/tda9875.c
@@ -262,7 +262,7 @@ static int tda9875_probe(struct i2c_adap
 	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda9875_attach);
 #else
-	if (adap->id = (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adap->id = I2C_HW_B_BT848)
 		return i2c_probe(adap, &addr_data, tda9875_attach);
 #endif
 	return 0;
diff --git a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
--- a/drivers/media/video/tda9887.c
+++ b/drivers/media/video/tda9887.c
@@ -618,8 +618,8 @@ static int tda9887_probe(struct i2c_adap
 		return i2c_probe(adap, &addr_data, tda9887_attach);
 #else
 	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	case I2C_HW_B_BT848:
+	case I2C_HW_B_RIVA:
 	case I2C_ALGO_SAA7134:
 		return i2c_probe(adap, &addr_data, tda9887_attach);
 		break;
diff --git a/drivers/media/video/tuner-3036.c b/drivers/media/video/tuner-3036.c
--- a/drivers/media/video/tuner-3036.c
+++ b/drivers/media/video/tuner-3036.c
@@ -165,7 +165,7 @@ static int 
 tuner_probe(struct i2c_adapter *adap)
 {
 	this_adap = 0;
-	if (adap->id = (I2C_ALGO_BIT | I2C_HW_B_LP))
+	if (adap->id = I2C_HW_B_LP)
 		return i2c_probe(adap, &addr_data, tuner_attach);
 	return 0;
 }
diff --git a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
--- a/drivers/media/video/tvaudio.c
+++ b/drivers/media/video/tvaudio.c
@@ -1098,7 +1098,7 @@ static int tda8425_initialize(struct CHI
 			    /* extern	*/ TDA8425_S1_CH1, /* intern */ TDA8425_S1_OFF,
 			    /* off	*/ TDA8425_S1_OFF, /* on     */ TDA8425_S1_CH2};
 
-	if (chip->c.adapter->id = (I2C_ALGO_BIT | I2C_HW_B_RIVA)) {
+	if (chip->c.adapter->id = I2C_HW_B_RIVA) {
 		memcpy (desc->inputmap, inputmap, sizeof (inputmap));
 	}
 	return 0;
@@ -1555,8 +1555,8 @@ static int chip_probe(struct i2c_adapter
 		return i2c_probe(adap, &addr_data, chip_attach);
 #else
 	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	case I2C_HW_B_BT848:
+	case I2C_HW_B_RIVA:
 	case I2C_ALGO_SAA7134:
 		return i2c_probe(adap, &addr_data, chip_attach);
 	}
diff --git a/drivers/media/video/tveeprom.c b/drivers/media/video/tveeprom.c
--- a/drivers/media/video/tveeprom.c
+++ b/drivers/media/video/tveeprom.c
@@ -534,7 +534,7 @@ static int
 tveeprom_attach_adapter (struct i2c_adapter *adapter)
 {
 	dprintk(1,"%s: id 0x%x\n",__FUNCTION__,adapter->id);
-	if (adapter->id != (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adapter->id != I2C_HW_B_BT848)
 		return 0;
 	return i2c_probe(adapter, &addr_data, tveeprom_detect_client);
 }
diff --git a/drivers/media/video/tvmixer.c b/drivers/media/video/tvmixer.c
--- a/drivers/media/video/tvmixer.c
+++ b/drivers/media/video/tvmixer.c
@@ -276,9 +276,9 @@ static int tvmixer_clients(struct i2c_cl
 #else
 	/* TV card ??? */
 	switch (client->adapter->id) {
-	case I2C_ALGO_BIT | I2C_HW_SMBUS_VOODOO3:
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	case I2C_HW_SMBUS_VOODOO3:
+	case I2C_HW_B_BT848:
+	case I2C_HW_B_RIVA:
 		/* ok, have a look ... */
 		break;
 	default:
diff --git a/drivers/usb/media/w9968cf.c b/drivers/usb/media/w9968cf.c
--- a/drivers/usb/media/w9968cf.c
+++ b/drivers/usb/media/w9968cf.c
@@ -1579,7 +1579,7 @@ static int w9968cf_i2c_init(struct w9968
 	};
 
 	static struct i2c_adapter adap = {
-		.id =                I2C_ALGO_SMBUS | I2C_HW_SMBUS_W9968CF,
+		.id =                I2C_HW_SMBUS_W9968CF,
 		.class =             I2C_CLASS_CAM_DIGITAL,
 		.owner =             THIS_MODULE,
 		.client_register =   w9968cf_i2c_attach_inform,
diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
--- a/drivers/video/matrox/matroxfb_maven.c
+++ b/drivers/video/matrox/matroxfb_maven.c
@@ -1271,7 +1271,7 @@ ERROR0:;
 }
 
 static int maven_attach_adapter(struct i2c_adapter* adapter) {
-	if (adapter->id = (I2C_ALGO_BIT | I2C_HW_B_G400))
+	if (adapter->id = I2C_HW_B_G400)
 		return i2c_probe(adapter, &addr_data, &maven_detect_client);
 	return 0;
 }
diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -218,103 +218,103 @@
  */
 
 /* --- Bit algorithm adapters 						*/
-#define I2C_HW_B_LP	0x00	/* Parallel port Philips style adapter	*/
-#define I2C_HW_B_LPC	0x01	/* Parallel port, over control reg.	*/
-#define I2C_HW_B_SER	0x02	/* Serial line interface		*/
-#define I2C_HW_B_ELV	0x03	/* ELV Card				*/
-#define I2C_HW_B_VELLE	0x04	/* Vellemann K8000			*/
-#define I2C_HW_B_BT848	0x05	/* BT848 video boards			*/
-#define I2C_HW_B_WNV	0x06	/* Winnov Videums			*/
-#define I2C_HW_B_VIA	0x07	/* Via vt82c586b			*/
-#define I2C_HW_B_HYDRA	0x08	/* Apple Hydra Mac I/O			*/
-#define I2C_HW_B_G400	0x09	/* Matrox G400				*/
-#define I2C_HW_B_I810	0x0a	/* Intel I810 				*/
-#define I2C_HW_B_VOO	0x0b	/* 3dfx Voodoo 3 / Banshee      	*/
-#define I2C_HW_B_PPORT  0x0c	/* Primitive parallel port adapter	*/
-#define I2C_HW_B_SAVG	0x0d	/* Savage 4                     	*/
-#define I2C_HW_B_SCX200	0x0e	/* Nat'l Semi SCx200 I2C        	*/
-#define I2C_HW_B_RIVA	0x10	/* Riva based graphics cards		*/
-#define I2C_HW_B_IOC	0x11	/* IOC bit-wiggling			*/
-#define I2C_HW_B_TSUNA  0x12	/* DEC Tsunami chipset			*/
-#define I2C_HW_B_FRODO  0x13    /* 2d3D, Inc. SA-1110 Development Board */
-#define I2C_HW_B_OMAHA  0x14    /* Omaha I2C interface (ARM)		*/
-#define I2C_HW_B_GUIDE  0x15    /* Guide bit-basher			*/
-#define I2C_HW_B_IXP2000 0x16	/* GPIO on IXP2000 systems              */
-#define I2C_HW_B_IXP4XX 0x17	/* GPIO on IXP4XX systems		*/
-#define I2C_HW_B_S3VIA	0x18	/* S3Via ProSavage adapter		*/
-#define I2C_HW_B_ZR36067 0x19	/* Zoran-36057/36067 based boards	*/
-#define I2C_HW_B_PCILYNX 0x1a	/* TI PCILynx I2C adapter		*/
-#define I2C_HW_B_CX2388x 0x1b	/* connexant 2388x based tv cards	*/
+#define I2C_HW_B_LP		0x010000 /* Parallel port Philips style */
+#define I2C_HW_B_LPC		0x010001 /* Parallel port control reg. */
+#define I2C_HW_B_SER		0x010002 /* Serial line interface */
+#define I2C_HW_B_ELV		0x010003 /* ELV Card */
+#define I2C_HW_B_VELLE		0x010004 /* Vellemann K8000 */
+#define I2C_HW_B_BT848		0x010005 /* BT848 video boards */
+#define I2C_HW_B_WNV		0x010006 /* Winnov Videums */
+#define I2C_HW_B_VIA		0x010007 /* Via vt82c586b */
+#define I2C_HW_B_HYDRA		0x010008 /* Apple Hydra Mac I/O */
+#define I2C_HW_B_G400		0x010009 /* Matrox G400 */
+#define I2C_HW_B_I810		0x01000a /* Intel I810 */
+#define I2C_HW_B_VOO		0x01000b /* 3dfx Voodoo 3 / Banshee */
+#define I2C_HW_B_PPORT		0x01000c /* Primitive parallel port adapter */
+#define I2C_HW_B_SAVG		0x01000d /* Savage 4 */
+#define I2C_HW_B_SCX200		0x01000e /* Nat'l Semi SCx200 I2C */
+#define I2C_HW_B_RIVA		0x010010 /* Riva based graphics cards */
+#define I2C_HW_B_IOC		0x010011 /* IOC bit-wiggling */
+#define I2C_HW_B_TSUNA		0x010012 /* DEC Tsunami chipset */
+#define I2C_HW_B_FRODO		0x010013 /* 2d3D SA-1110 Development Board */
+#define I2C_HW_B_OMAHA		0x010014 /* Omaha I2C interface (ARM) */
+#define I2C_HW_B_GUIDE		0x010015 /* Guide bit-basher */
+#define I2C_HW_B_IXP2000	0x010016 /* GPIO on IXP2000 systems */
+#define I2C_HW_B_IXP4XX		0x010017 /* GPIO on IXP4XX systems */
+#define I2C_HW_B_S3VIA		0x010018 /* S3Via ProSavage adapter */
+#define I2C_HW_B_ZR36067	0x010019 /* Zoran-36057/36067 based boards */
+#define I2C_HW_B_PCILYNX	0x01001a /* TI PCILynx I2C adapter */
+#define I2C_HW_B_CX2388x	0x01001b /* connexant 2388x based tv cards */
 
 /* --- PCF 8584 based algorithms					*/
-#define I2C_HW_P_LP	0x00	/* Parallel port interface		*/
-#define I2C_HW_P_ISA	0x01	/* generic ISA Bus inteface card	*/
-#define I2C_HW_P_ELEK	0x02	/* Elektor ISA Bus inteface card	*/
+#define I2C_HW_P_LP		0x020000 /* Parallel port interface */
+#define I2C_HW_P_ISA		0x020001 /* generic ISA Bus inteface card */
+#define I2C_HW_P_ELEK		0x020002 /* Elektor ISA Bus inteface card */
 
 /* --- PCA 9564 based algorithms */
-#define I2C_HW_A_ISA	0x00	/* generic ISA Bus interface card	*/
+#define I2C_HW_A_ISA		0x1a0000 /* generic ISA Bus interface card */
 
 /* --- ACPI Embedded controller algorithms                              */
-#define I2C_HW_ACPI_EC          0x00
+#define I2C_HW_ACPI_EC          0x1f0000
 
 /* --- MPC824x PowerPC adapters						*/
-#define I2C_HW_MPC824X 0x00	/* Motorola 8240 / 8245                 */
+#define I2C_HW_MPC824X		0x100001 /* Motorola 8240 / 8245 */
 
 /* --- MPC8xx PowerPC adapters						*/
-#define I2C_HW_MPC8XX_EPON 0x00	/* Eponymous MPC8xx I2C adapter 	*/
+#define I2C_HW_MPC8XX_EPON	0x110000 /* Eponymous MPC8xx I2C adapter */
 
 /* --- ITE based algorithms						*/
-#define I2C_HW_I_IIC	0x00	/* controller on the ITE */
+#define I2C_HW_I_IIC		0x080000 /* controller on the ITE */
 
 /* --- PowerPC on-chip adapters						*/
-#define I2C_HW_OCP 0x00	/* IBM on-chip I2C adapter 	*/
+#define I2C_HW_OCP		0x120000 /* IBM on-chip I2C adapter */
 
 /* --- Broadcom SiByte adapters						*/
-#define I2C_HW_SIBYTE	0x00
+#define I2C_HW_SIBYTE		0x150000
 
 /* --- SGI adapters							*/
-#define I2C_HW_SGI_VINO	0x00
-#define I2C_HW_SGI_MACE	0x01
+#define I2C_HW_SGI_VINO		0x160000
+#define I2C_HW_SGI_MACE		0x160001
 
 /* --- XSCALE on-chip adapters                          */
-#define I2C_HW_IOP3XX 0x00
+#define I2C_HW_IOP3XX		0x140000
 
 /* --- Au1550 PSC adapters adapters					*/
-#define I2C_HW_AU1550_PSC	0x00
+#define I2C_HW_AU1550_PSC	0x1b0000
 
 /* --- SMBus only adapters						*/
-#define I2C_HW_SMBUS_PIIX4	0x00
-#define I2C_HW_SMBUS_ALI15X3	0x01
-#define I2C_HW_SMBUS_VIA2	0x02
-#define I2C_HW_SMBUS_VOODOO3	0x03
-#define I2C_HW_SMBUS_I801	0x04
-#define I2C_HW_SMBUS_AMD756	0x05
-#define I2C_HW_SMBUS_SIS5595	0x06
-#define I2C_HW_SMBUS_ALI1535	0x07
-#define I2C_HW_SMBUS_SIS630	0x08
-#define I2C_HW_SMBUS_SIS96X	0x09
-#define I2C_HW_SMBUS_AMD8111	0x0a
-#define I2C_HW_SMBUS_SCX200	0x0b
-#define I2C_HW_SMBUS_NFORCE2	0x0c
-#define I2C_HW_SMBUS_W9968CF	0x0d
-#define I2C_HW_SMBUS_OV511	0x0e	/* OV511(+) USB 1.1 webcam ICs	*/
-#define I2C_HW_SMBUS_OV518	0x0f	/* OV518(+) USB 1.1 webcam ICs	*/
-#define I2C_HW_SMBUS_OV519	0x10	/* OV519 USB 1.1 webcam IC	*/
-#define I2C_HW_SMBUS_OVFX2	0x11	/* Cypress/OmniVision FX2 webcam */
+#define I2C_HW_SMBUS_PIIX4	0x040000
+#define I2C_HW_SMBUS_ALI15X3	0x040001
+#define I2C_HW_SMBUS_VIA2	0x040002
+#define I2C_HW_SMBUS_VOODOO3	0x040003
+#define I2C_HW_SMBUS_I801	0x040004
+#define I2C_HW_SMBUS_AMD756	0x040005
+#define I2C_HW_SMBUS_SIS5595	0x040006
+#define I2C_HW_SMBUS_ALI1535	0x040007
+#define I2C_HW_SMBUS_SIS630	0x040008
+#define I2C_HW_SMBUS_SIS96X	0x040009
+#define I2C_HW_SMBUS_AMD8111	0x04000a
+#define I2C_HW_SMBUS_SCX200	0x04000b
+#define I2C_HW_SMBUS_NFORCE2	0x04000c
+#define I2C_HW_SMBUS_W9968CF	0x04000d
+#define I2C_HW_SMBUS_OV511	0x04000e /* OV511(+) USB 1.1 webcam ICs */
+#define I2C_HW_SMBUS_OV518	0x04000f /* OV518(+) USB 1.1 webcam ICs */
+#define I2C_HW_SMBUS_OV519	0x040010 /* OV519 USB 1.1 webcam IC */
+#define I2C_HW_SMBUS_OVFX2	0x040011 /* Cypress/OmniVision FX2 webcam */
 
 /* --- ISA pseudo-adapter						*/
-#define I2C_HW_ISA 0x00
+#define I2C_HW_ISA		0x050000
 
 /* --- IPMI pseudo-adapter						*/
-#define I2C_HW_IPMI 0x00
+#define I2C_HW_IPMI		0x0b0000
 
 /* --- IPMB adapter						*/
-#define I2C_HW_IPMB 0x00
+#define I2C_HW_IPMB		0x0c0000
 
 /* --- MCP107 adapter */
-#define I2C_HW_MPC107 0x00
+#define I2C_HW_MPC107		0x0d0000
 
 /* --- Marvell mv64xxx i2c adapter */
-#define I2C_HW_MV64XXX 0x00
+#define I2C_HW_MV64XXX		0x190000
 
 #endif /* LINUX_I2C_ID_H */
diff --git a/include/linux/i2c-isa.h b/include/linux/i2c-isa.h
--- a/include/linux/i2c-isa.h
+++ b/include/linux/i2c-isa.h
@@ -29,7 +29,7 @@ extern int i2c_isa_del_driver(struct i2c
 /* Detect whether we are on the isa bus. This is only useful to hybrid
    (i2c+isa) drivers. */
 #define i2c_is_isa_adapter(adapptr) \
-        ((adapptr)->id = (I2C_ALGO_ISA | I2C_HW_ISA))
+        ((adapptr)->id = I2C_HW_ISA)
 #define i2c_is_isa_client(clientptr) \
         i2c_is_isa_adapter((clientptr)->adapter)
 

