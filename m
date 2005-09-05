From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:44 +0000
Subject: [lm-sensors] [PATCH] I2C: Kill i2c_algorithm.name (1/7)
Message-Id: <11259567701398@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Kill i2c_algorithm.name (1/7)

The name member of the i2c_algorithm is never used, although all
drivers conscientiously fill it. We can drop it completely, this
structure doesn't need to have a name.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 975185880d55676b1352047e82a0cb84173c6c28
tree 613fdd41f1f967d3795144aae304ce20d3e40b19
parent 4c9337da37c877e53a64696fc8524f642d446cba
author Jean Delvare <khali@linux-fr.org> Thu, 11 Aug 2005 23:33:24 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:27 -0700

 drivers/i2c/algos/i2c-algo-bit.c                  |    1 -
 drivers/i2c/algos/i2c-algo-ite.c                  |    1 -
 drivers/i2c/algos/i2c-algo-pca.c                  |    1 -
 drivers/i2c/algos/i2c-algo-pcf.c                  |    1 -
 drivers/i2c/algos/i2c-algo-sgi.c                  |    1 -
 drivers/i2c/algos/i2c-algo-sibyte.c               |    1 -
 drivers/i2c/busses/i2c-ali1535.c                  |    1 -
 drivers/i2c/busses/i2c-ali1563.c                  |    1 -
 drivers/i2c/busses/i2c-ali15x3.c                  |    1 -
 drivers/i2c/busses/i2c-amd756.c                   |    1 -
 drivers/i2c/busses/i2c-amd8111.c                  |    1 -
 drivers/i2c/busses/i2c-au1550.c                   |    1 -
 drivers/i2c/busses/i2c-i801.c                     |    1 -
 drivers/i2c/busses/i2c-ibm_iic.c                  |    1 -
 drivers/i2c/busses/i2c-iop3xx.c                   |    1 -
 drivers/i2c/busses/i2c-isa.c                      |    1 -
 drivers/i2c/busses/i2c-keywest.c                  |    1 -
 drivers/i2c/busses/i2c-mpc.c                      |    1 -
 drivers/i2c/busses/i2c-mv64xxx.c                  |    1 -
 drivers/i2c/busses/i2c-nforce2.c                  |    1 -
 drivers/i2c/busses/i2c-piix4.c                    |    1 -
 drivers/i2c/busses/i2c-s3c2410.c                  |    1 -
 drivers/i2c/busses/i2c-sis5595.c                  |    1 -
 drivers/i2c/busses/i2c-sis630.c                   |    1 -
 drivers/i2c/busses/i2c-sis96x.c                   |    1 -
 drivers/i2c/busses/i2c-stub.c                     |    1 -
 drivers/i2c/busses/i2c-viapro.c                   |    1 -
 drivers/i2c/busses/scx200_acb.c                   |    1 -
 drivers/media/common/saa7146_i2c.c                |    1 -
 drivers/media/dvb/b2c2/flexcop-i2c.c              |    1 -
 drivers/media/dvb/dvb-usb/cxusb.c                 |    1 -
 drivers/media/dvb/dvb-usb/dibusb-common.c         |    1 -
 drivers/media/dvb/dvb-usb/digitv.c                |    1 -
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    1 -
 drivers/media/video/bttv-i2c.c                    |    1 -
 drivers/media/video/saa7134/saa7134-i2c.c         |    1 -
 drivers/usb/media/w9968cf.c                       |    1 -
 include/linux/i2c.h                               |    1 -
 38 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -519,7 +519,6 @@ static u32 bit_func(struct i2c_adapter *
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm i2c_bit_algo = {
-	.name		= "Bit-shift algorithm",
 	.id		= I2C_ALGO_BIT,
 	.master_xfer	= bit_xfer,
 	.functionality	= bit_func,
diff --git a/drivers/i2c/algos/i2c-algo-ite.c b/drivers/i2c/algos/i2c-algo-ite.c
--- a/drivers/i2c/algos/i2c-algo-ite.c
+++ b/drivers/i2c/algos/i2c-algo-ite.c
@@ -713,7 +713,6 @@ static u32 iic_func(struct i2c_adapter *
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm iic_algo = {
-	.name		= "ITE IIC algorithm",
 	.id		= I2C_ALGO_IIC,
 	.master_xfer	= iic_xfer,
 	.algo_control	= algo_control, /* ioctl */
diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -356,7 +356,6 @@ static int pca_init(struct i2c_algo_pca_
 }
 
 static struct i2c_algorithm pca_algo = {
-	.name		= "PCA9564 algorithm",
 	.id		= I2C_ALGO_PCA,
 	.master_xfer	= pca_xfer,
 	.functionality	= pca_func,
diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -459,7 +459,6 @@ static u32 pcf_func(struct i2c_adapter *
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm pcf_algo = {
-	.name		= "PCF8584 algorithm",
 	.id		= I2C_ALGO_PCF,
 	.master_xfer	= pcf_xfer,
 	.functionality	= pcf_func,
diff --git a/drivers/i2c/algos/i2c-algo-sgi.c b/drivers/i2c/algos/i2c-algo-sgi.c
--- a/drivers/i2c/algos/i2c-algo-sgi.c
+++ b/drivers/i2c/algos/i2c-algo-sgi.c
@@ -158,7 +158,6 @@ static u32 sgi_func(struct i2c_adapter *
 }
 
 static struct i2c_algorithm sgi_algo = {
-	.name		= "SGI algorithm",
 	.id		= I2C_ALGO_SGI,
 	.master_xfer	= sgi_xfer,
 	.functionality	= sgi_func,
diff --git a/drivers/i2c/algos/i2c-algo-sibyte.c b/drivers/i2c/algos/i2c-algo-sibyte.c
--- a/drivers/i2c/algos/i2c-algo-sibyte.c
+++ b/drivers/i2c/algos/i2c-algo-sibyte.c
@@ -135,7 +135,6 @@ static u32 bit_func(struct i2c_adapter *
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm i2c_sibyte_algo = {
-	.name		= "SiByte algorithm",
 	.id		= I2C_ALGO_SIBYTE,
 	.smbus_xfer	= smbus_xfer,
 	.algo_control	= algo_control, /* ioctl */
diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -472,7 +472,6 @@ static u32 ali1535_func(struct i2c_adapt
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-i2c SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= ali1535_access,
 	.functionality	= ali1535_func,
diff --git a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c
+++ b/drivers/i2c/busses/i2c-ali1563.c
@@ -366,7 +366,6 @@ static void ali1563_shutdown(struct pci_
 }
 
 static struct i2c_algorithm ali1563_algorithm = {
-	.name		= "Non-i2c SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= ali1563_access,
 	.functionality	= ali1563_func,
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -462,7 +462,6 @@ static u32 ali15x3_func(struct i2c_adapt
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= ali15x3_access,
 	.functionality	= ali15x3_func,
diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c
+++ b/drivers/i2c/busses/i2c-amd756.c
@@ -295,7 +295,6 @@ static u32 amd756_func(struct i2c_adapte
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= amd756_access,
 	.functionality	= amd756_func,
diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -323,7 +323,6 @@ static u32 amd8111_func(struct i2c_adapt
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name = "Non-I2C SMBus 2.0 adapter",
 	.id = I2C_ALGO_SMBUS,
 	.smbus_xfer = amd8111_access,
 	.functionality = amd8111_func,
diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -283,7 +283,6 @@ au1550_func(struct i2c_adapter *adap)
 }
 
 static struct i2c_algorithm au1550_algo = {
-	.name		= "Au1550 algorithm",
 	.id		= I2C_ALGO_AU1550,
 	.master_xfer	= au1550_xfer,
 	.functionality	= au1550_func,
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -535,7 +535,6 @@ static u32 i801_func(struct i2c_adapter 
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= i801_access,
 	.functionality	= i801_func,
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -627,7 +627,6 @@ static u32 iic_func(struct i2c_adapter *
 }
 
 static struct i2c_algorithm iic_algo = {
-	.name 		= "IBM IIC algorithm",
 	.id   		= I2C_ALGO_OCP,
 	.master_xfer 	= iic_xfer,
 	.functionality	= iic_func
diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -399,7 +399,6 @@ iop3xx_i2c_func(struct i2c_adapter *adap
 }
 
 static struct i2c_algorithm iop3xx_i2c_algo = {
-	.name		= "IOP3xx I2C algorithm",
 	.id		= I2C_ALGO_IOP3XX,
 	.master_xfer	= iop3xx_i2c_master_xfer,
 	.algo_control	= iop3xx_i2c_algo_control,
diff --git a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c
+++ b/drivers/i2c/busses/i2c-isa.c
@@ -43,7 +43,6 @@ static u32 isa_func(struct i2c_adapter *
 
 /* This is the actual algorithm we define */
 static struct i2c_algorithm isa_algorithm = {
-	.name		= "ISA bus algorithm",
 	.id		= I2C_ALGO_ISA,
 	.functionality	= isa_func,
 };
diff --git a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
--- a/drivers/i2c/busses/i2c-keywest.c
+++ b/drivers/i2c/busses/i2c-keywest.c
@@ -498,7 +498,6 @@ keywest_func(struct i2c_adapter * adapte
 
 /* For now, we only handle combined mode (smbus) */
 static struct i2c_algorithm keywest_algorithm = {
-	.name		= "Keywest i2c",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= keywest_smbus_xfer,
 	.master_xfer	= keywest_xfer,
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -272,7 +272,6 @@ static u32 mpc_functionality(struct i2c_
 }
 
 static struct i2c_algorithm mpc_algo = {
-	.name = "MPC algorithm",
 	.id = I2C_ALGO_MPC107,
 	.master_xfer = mpc_xfer,
 	.functionality = mpc_functionality,
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -433,7 +433,6 @@ mv64xxx_i2c_xfer(struct i2c_adapter *ada
 }
 
 static struct i2c_algorithm mv64xxx_i2c_algo = {
-	.name = MV64XXX_I2C_CTLR_NAME " algorithm",
 	.id = I2C_ALGO_MV64XXX,
 	.master_xfer = mv64xxx_i2c_xfer,
 	.functionality = mv64xxx_i2c_functionality,
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -110,7 +110,6 @@ static u32 nforce2_func(struct i2c_adapt
 
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name = "Non-I2C SMBus adapter",
 	.id = I2C_ALGO_SMBUS,
 	.smbus_xfer = nforce2_access,
 	.functionality = nforce2_func,
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -399,7 +399,6 @@ static u32 piix4_func(struct i2c_adapter
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= piix4_access,
 	.functionality	= piix4_func,
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -568,7 +568,6 @@ static u32 s3c24xx_i2c_func(struct i2c_a
 /* i2c bus registration info */
 
 static struct i2c_algorithm s3c24xx_i2c_algorithm = {
-	.name			= "S3C2410-I2C-Algorithm",
 	.master_xfer		= s3c24xx_i2c_xfer,
 	.functionality		= s3c24xx_i2c_func,
 };
diff --git a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c
+++ b/drivers/i2c/busses/i2c-sis5595.c
@@ -357,7 +357,6 @@ static u32 sis5595_func(struct i2c_adapt
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= sis5595_access,
 	.functionality	= sis5595_func,
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -448,7 +448,6 @@ exit:
 
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= sis630_access,
 	.functionality	= sis630_func,
diff --git a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c
+++ b/drivers/i2c/busses/i2c-sis96x.c
@@ -249,7 +249,6 @@ static u32 sis96x_func(struct i2c_adapte
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= sis96x_access,
 	.functionality	= sis96x_func,
diff --git a/drivers/i2c/busses/i2c-stub.c b/drivers/i2c/busses/i2c-stub.c
--- a/drivers/i2c/busses/i2c-stub.c
+++ b/drivers/i2c/busses/i2c-stub.c
@@ -109,7 +109,6 @@ static u32 stub_func(struct i2c_adapter 
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.functionality	= stub_func,
 	.smbus_xfer	= stub_xfer,
diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -286,7 +286,6 @@ static u32 vt596_func(struct i2c_adapter
 }
 
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= vt596_access,
 	.functionality	= vt596_func,
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -395,7 +395,6 @@ static u32 scx200_acb_func(struct i2c_ad
 
 /* For now, we only handle combined mode (smbus) */
 static struct i2c_algorithm scx200_acb_algorithm = {
-	.name		= "NatSemi SCx200 ACCESS.bus",
 	.id		= I2C_ALGO_SMBUS,
 	.smbus_xfer	= scx200_acb_smbus_xfer,
 	.functionality	= scx200_acb_func,
diff --git a/drivers/media/common/saa7146_i2c.c b/drivers/media/common/saa7146_i2c.c
--- a/drivers/media/common/saa7146_i2c.c
+++ b/drivers/media/common/saa7146_i2c.c
@@ -387,7 +387,6 @@ static int saa7146_i2c_xfer(struct i2c_a
 
 /* exported algorithm data */
 static struct i2c_algorithm saa7146_algo = {
-	.name		= "saa7146 i2c algorithm",
 	.id		= I2C_ALGO_SAA7146,
 	.master_xfer	= saa7146_i2c_xfer,
 	.functionality	= saa7146_i2c_func,
diff --git a/drivers/media/dvb/b2c2/flexcop-i2c.c b/drivers/media/dvb/b2c2/flexcop-i2c.c
--- a/drivers/media/dvb/b2c2/flexcop-i2c.c
+++ b/drivers/media/dvb/b2c2/flexcop-i2c.c
@@ -172,7 +172,6 @@ static u32 flexcop_i2c_func(struct i2c_a
 }
 
 static struct i2c_algorithm flexcop_algo = {
-	.name			= "FlexCop I2C algorithm",
 	.id				= I2C_ALGO_BIT,
 	.master_xfer	= flexcop_master_xfer,
 	.functionality	= flexcop_i2c_func,
diff --git a/drivers/media/dvb/dvb-usb/cxusb.c b/drivers/media/dvb/dvb-usb/cxusb.c
--- a/drivers/media/dvb/dvb-usb/cxusb.c
+++ b/drivers/media/dvb/dvb-usb/cxusb.c
@@ -141,7 +141,6 @@ static u32 cxusb_i2c_func(struct i2c_ada
 }
 
 static struct i2c_algorithm cxusb_i2c_algo = {
-	.name          = "Conexant USB I2C algorithm",
 	.id            = I2C_ALGO_BIT,
 	.master_xfer   = cxusb_i2c_xfer,
 	.functionality = cxusb_i2c_func,
diff --git a/drivers/media/dvb/dvb-usb/dibusb-common.c b/drivers/media/dvb/dvb-usb/dibusb-common.c
--- a/drivers/media/dvb/dvb-usb/dibusb-common.c
+++ b/drivers/media/dvb/dvb-usb/dibusb-common.c
@@ -156,7 +156,6 @@ static u32 dibusb_i2c_func(struct i2c_ad
 }
 
 struct i2c_algorithm dibusb_i2c_algo = {
-	.name          = "DiBcom USB I2C algorithm",
 	.id            = I2C_ALGO_BIT,
 	.master_xfer   = dibusb_i2c_xfer,
 	.functionality = dibusb_i2c_func,
diff --git a/drivers/media/dvb/dvb-usb/digitv.c b/drivers/media/dvb/dvb-usb/digitv.c
--- a/drivers/media/dvb/dvb-usb/digitv.c
+++ b/drivers/media/dvb/dvb-usb/digitv.c
@@ -77,7 +77,6 @@ static u32 digitv_i2c_func(struct i2c_ad
 }
 
 static struct i2c_algorithm digitv_i2c_algo = {
-	.name          = "Nebula DigiTV USB I2C algorithm",
 	.id            = I2C_ALGO_BIT,
 	.master_xfer   = digitv_i2c_xfer,
 	.functionality = digitv_i2c_func,
diff --git a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
+++ b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
@@ -1472,7 +1472,6 @@ static void frontend_init(struct ttusb* 
 
 
 static struct i2c_algorithm ttusb_dec_algo = {
-	.name		= "ttusb dec i2c algorithm",
 	.id		= I2C_ALGO_BIT,
 	.master_xfer	= master_xfer,
 	.functionality	= functionality,
diff --git a/drivers/media/video/bttv-i2c.c b/drivers/media/video/bttv-i2c.c
--- a/drivers/media/video/bttv-i2c.c
+++ b/drivers/media/video/bttv-i2c.c
@@ -270,7 +270,6 @@ static int bttv_i2c_xfer(struct i2c_adap
 }
 
 static struct i2c_algorithm bttv_algo = {
-	.name          = "bt878",
 	.id            = I2C_ALGO_BIT | I2C_HW_B_BT848 /* FIXME */,
 	.master_xfer   = bttv_i2c_xfer,
 	.algo_control  = algo_control,
diff --git a/drivers/media/video/saa7134/saa7134-i2c.c b/drivers/media/video/saa7134/saa7134-i2c.c
--- a/drivers/media/video/saa7134/saa7134-i2c.c
+++ b/drivers/media/video/saa7134/saa7134-i2c.c
@@ -370,7 +370,6 @@ static int attach_inform(struct i2c_clie
 }
 
 static struct i2c_algorithm saa7134_algo = {
-	.name          = "saa7134",
 	.id            = I2C_ALGO_SAA7134,
 	.master_xfer   = saa7134_i2c_xfer,
 	.algo_control  = algo_control,
diff --git a/drivers/usb/media/w9968cf.c b/drivers/usb/media/w9968cf.c
--- a/drivers/usb/media/w9968cf.c
+++ b/drivers/usb/media/w9968cf.c
@@ -1573,7 +1573,6 @@ static int w9968cf_i2c_init(struct w9968
 	int err = 0;
 
 	static struct i2c_algorithm algo = {
-		.name =          "W996[87]CF algorithm",
 		.id =            I2C_ALGO_SMBUS,
 		.smbus_xfer =    w9968cf_i2c_smbus_xfer,
 		.algo_control =  w9968cf_i2c_control,
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -192,7 +192,6 @@ static inline char *i2c_clientname(struc
  * to name two of the most common.
  */
 struct i2c_algorithm {
-	char name[32];				/* textual description 	*/
 	unsigned int id;
 
 	/* If an adapter algorithm can't do I2C-level access, set master_xfer

