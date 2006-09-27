From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:02:00 +0000
Subject: [lm-sensors] [PATCH 29/30] i2c: Constify i2c_algorithm declarations,
Message-Id: <11593190204083-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c: Constify i2c_algorithm declarations, part 2

Make struct i2c_algorithm declarations const in all i2c bus drivers
where it is possible.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: David Brownell <david-b at pacbell.net>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/acpi/i2c_ec.c             |    2 +-
 drivers/i2c/busses/i2c-ali1535.c  |    2 +-
 drivers/i2c/busses/i2c-ali1563.c  |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c  |    2 +-
 drivers/i2c/busses/i2c-amd756.c   |    2 +-
 drivers/i2c/busses/i2c-amd8111.c  |    2 +-
 drivers/i2c/busses/i2c-au1550.c   |    2 +-
 drivers/i2c/busses/i2c-i801.c     |    2 +-
 drivers/i2c/busses/i2c-ibm_iic.c  |    2 +-
 drivers/i2c/busses/i2c-iop3xx.c   |    2 +-
 drivers/i2c/busses/i2c-isa.c      |    2 +-
 drivers/i2c/busses/i2c-mpc.c      |    2 +-
 drivers/i2c/busses/i2c-mv64xxx.c  |    2 +-
 drivers/i2c/busses/i2c-nforce2.c  |    2 +-
 drivers/i2c/busses/i2c-ocores.c   |    2 +-
 drivers/i2c/busses/i2c-omap.c     |    2 +-
 drivers/i2c/busses/i2c-piix4.c    |    2 +-
 drivers/i2c/busses/i2c-powermac.c |    2 +-
 drivers/i2c/busses/i2c-pxa.c      |    2 +-
 drivers/i2c/busses/i2c-s3c2410.c  |    2 +-
 drivers/i2c/busses/i2c-sibyte.c   |    2 +-
 drivers/i2c/busses/i2c-sis5595.c  |    2 +-
 drivers/i2c/busses/i2c-sis630.c   |    2 +-
 drivers/i2c/busses/i2c-sis96x.c   |    2 +-
 drivers/i2c/busses/i2c-stub.c     |    2 +-
 drivers/i2c/busses/i2c-viapro.c   |    2 +-
 drivers/i2c/busses/scx200_acb.c   |    2 +-
 27 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/i2c_ec.c b/drivers/acpi/i2c_ec.c
index 6809c28..6342e61 100644
--- a/drivers/acpi/i2c_ec.c
+++ b/drivers/acpi/i2c_ec.c
@@ -293,7 +293,7 @@ static u32 acpi_ec_smb_func(struct i2c_a
 		I2C_FUNC_SMBUS_I2C_BLOCK | I2C_FUNC_SMBUS_HWPEC_CALC);
 }
 
-static struct i2c_algorithm acpi_ec_smbus_algorithm = {
+static const struct i2c_algorithm acpi_ec_smbus_algorithm = {
 	.smbus_xfer = acpi_ec_smb_access,
 	.functionality = acpi_ec_smb_func,
 };
diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index d3ef46a..e75d339 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -468,7 +468,7 @@ static u32 ali1535_func(struct i2c_adapt
 	    I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
-static struct i2c_algorithm smbus_algorithm = {
+static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= ali1535_access,
 	.functionality	= ali1535_func,
 };
diff --git a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
index e6f6320..33fbb47 100644
--- a/drivers/i2c/busses/i2c-ali1563.c
+++ b/drivers/i2c/busses/i2c-ali1563.c
@@ -367,7 +367,7 @@ static void ali1563_shutdown(struct pci_
 	release_region(ali1563_smba,ALI1563_SMB_IOSIZE);
 }
 
-static struct i2c_algorithm ali1563_algorithm = {
+static const struct i2c_algorithm ali1563_algorithm = {
 	.smbus_xfer	= ali1563_access,
 	.functionality	= ali1563_func,
 };
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
index 7a5c094..3f11b6e 100644
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -463,7 +463,7 @@ static u32 ali15x3_func(struct i2c_adapt
 	    I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
-static struct i2c_algorithm smbus_algorithm = {
+static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= ali15x3_access,
 	.functionality	= ali15x3_func,
 };
diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
index 1750ded..2d21afd 100644
--- a/drivers/i2c/busses/i2c-amd756.c
+++ b/drivers/i2c/busses/i2c-amd756.c
@@ -294,7 +294,7 @@ static u32 amd756_func(struct i2c_adapte
 	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_PROC_CALL;
 }
 
-static struct i2c_algorithm smbus_algorithm = {
+static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= amd756_access,
 	.functionality	= amd756_func,
 };
diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index e5ef560..0fbc718 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -316,7 +316,7 @@ static u32 amd8111_func(struct i2c_adapt
 		I2C_FUNC_SMBUS_I2C_BLOCK | I2C_FUNC_SMBUS_HWPEC_CALC;
 }
 
-static struct i2c_algorithm smbus_algorithm = {
+static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer = amd8111_access,
 	.functionality = amd8111_func,
 };
diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 7a005dd..d7e7c35 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -287,7 +287,7 @@ au1550_func(struct i2c_adapter *adap)
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
-static struct i2c_algorithm au1550_algo = {
+static const struct i2c_algorithm au1550_algo = {
 	.master_xfer	= au1550_xfer,
 	.functionality	= au1550_func,
 };
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 7be1d0a..bbb2fbe 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -434,7 +434,7 @@ static u32 i801_func(struct i2c_adapter 
 	     | (isich4 ? I2C_FUNC_SMBUS_HWPEC_CALC : 0);
 }
 
-static struct i2c_algorithm smbus_algorithm = {
+static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= i801_access,
 	.functionality	= i801_func,
 };
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 0599bbd..5bccb5d 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -625,7 +625,7 @@ static u32 iic_func(struct i2c_adapter *
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR;
 }
 
-static struct i2c_algorithm iic_algo = {
+static const struct i2c_algorithm iic_algo = {
 	.master_xfer 	= iic_xfer,
 	.functionality	= iic_func
 };
diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 48c5693..8e41315 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -401,7 +401,7 @@ iop3xx_i2c_func(struct i2c_adapter *adap
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
-static struct i2c_algorithm iop3xx_i2c_algo = {
+static const struct i2c_algorithm iop3xx_i2c_algo = {
 	.master_xfer	= iop3xx_i2c_master_xfer,
 	.algo_control	= iop3xx_i2c_algo_control,
 	.functionality	= iop3xx_i2c_func,
diff --git a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
index 7a8d2c1..4380653 100644
--- a/drivers/i2c/busses/i2c-isa.c
+++ b/drivers/i2c/busses/i2c-isa.c
@@ -43,7 +43,7 @@ #include <linux/platform_device.h>
 static u32 isa_func(struct i2c_adapter *adapter);
 
 /* This is the actual algorithm we define */
-static struct i2c_algorithm isa_algorithm = {
+static const struct i2c_algorithm isa_algorithm = {
 	.functionality	= isa_func,
 };
 
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 377ab40..155a986 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -272,7 +272,7 @@ static u32 mpc_functionality(struct i2c_
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
-static struct i2c_algorithm mpc_algo = {
+static const struct i2c_algorithm mpc_algo = {
 	.master_xfer = mpc_xfer,
 	.functionality = mpc_functionality,
 };
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index ac5cde1..eacbaf7 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -431,7 +431,7 @@ mv64xxx_i2c_xfer(struct i2c_adapter *ada
 	return num;
 }
 
-static struct i2c_algorithm mv64xxx_i2c_algo = {
+static const struct i2c_algorithm mv64xxx_i2c_algo = {
 	.master_xfer = mv64xxx_i2c_xfer,
 	.functionality = mv64xxx_i2c_functionality,
 };
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index 604b49e..e0292e4 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -109,7 +109,7 @@ static s32 nforce2_access(struct i2c_ada
 static u32 nforce2_func(struct i2c_adapter *adapter);
 
 
-static struct i2c_algorithm smbus_algorithm = {
+static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer = nforce2_access,
 	.functionality = nforce2_func,
 };
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 5928240..952a28d 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -199,7 +199,7 @@ static u32 ocores_func(struct i2c_adapte
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
-static struct i2c_algorithm ocores_algorithm = {
+static const struct i2c_algorithm ocores_algorithm = {
 	.master_xfer	= ocores_xfer,
 	.functionality	= ocores_func,
 };
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a129af9..81d87d2 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -526,7 +526,7 @@ omap_i2c_isr(int this_irq, void *dev_id,
 	return count ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static struct i2c_algorithm omap_i2c_algo = {
+static const struct i2c_algorithm omap_i2c_algo = {
 	.master_xfer	= omap_i2c_xfer,
 	.functionality	= omap_i2c_func,
 };
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 8f2f65b..30c7a1b 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -376,7 +376,7 @@ static u32 piix4_func(struct i2c_adapter
 	    I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
-static struct i2c_algorithm smbus_algorithm = {
+static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= piix4_access,
 	.functionality	= piix4_func,
 };
diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index d658d91..a508cb9 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -175,7 +175,7 @@ static u32 i2c_powermac_func(struct i2c_
 }
 
 /* For now, we only handle smbus */
-static struct i2c_algorithm i2c_powermac_algorithm = {
+static const struct i2c_algorithm i2c_powermac_algorithm = {
 	.smbus_xfer	= i2c_powermac_smbus_xfer,
 	.master_xfer	= i2c_powermac_master_xfer,
 	.functionality	= i2c_powermac_func,
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index ee114b4..cd4ad98 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -926,7 +926,7 @@ static u32 i2c_pxa_functionality(struct 
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
-static struct i2c_algorithm i2c_pxa_algorithm = {
+static const struct i2c_algorithm i2c_pxa_algorithm = {
 	.master_xfer	= i2c_pxa_xfer,
 	.functionality	= i2c_pxa_functionality,
 };
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 5d2950e..9ebe429 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -566,7 +566,7 @@ static u32 s3c24xx_i2c_func(struct i2c_a
 
 /* i2c bus registration info */
 
-static struct i2c_algorithm s3c24xx_i2c_algorithm = {
+static const struct i2c_algorithm s3c24xx_i2c_algorithm = {
 	.master_xfer		= s3c24xx_i2c_xfer,
 	.functionality		= s3c24xx_i2c_func,
 };
diff --git a/drivers/i2c/busses/i2c-sibyte.c b/drivers/i2c/busses/i2c-sibyte.c
index 96c9e7b..8f2b1f0 100644
--- a/drivers/i2c/busses/i2c-sibyte.c
+++ b/drivers/i2c/busses/i2c-sibyte.c
@@ -132,7 +132,7 @@ static u32 bit_func(struct i2c_adapter *
 
 /* -----exported algorithm data: -------------------------------------	*/
 
-static struct i2c_algorithm i2c_sibyte_algo = {
+static const struct i2c_algorithm i2c_sibyte_algo = {
 	.smbus_xfer	= smbus_xfer,
 	.functionality	= bit_func,
 };
diff --git a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
index b57ab74..38bbfd8 100644
--- a/drivers/i2c/busses/i2c-sis5595.c
+++ b/drivers/i2c/busses/i2c-sis5595.c
@@ -358,7 +358,7 @@ static u32 sis5595_func(struct i2c_adapt
 	    I2C_FUNC_SMBUS_PROC_CALL;
 }
 
-static struct i2c_algorithm smbus_algorithm = {
+static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= sis5595_access,
 	.functionality	= sis5595_func,
 };
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index acb75e2..dec0baf 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -450,7 +450,7 @@ exit:
 }
 
 
-static struct i2c_algorithm smbus_algorithm = {
+static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= sis630_access,
 	.functionality	= sis630_func,
 };
diff --git a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
index 1a73c05..7fd07fb 100644
--- a/drivers/i2c/busses/i2c-sis96x.c
+++ b/drivers/i2c/busses/i2c-sis96x.c
@@ -242,7 +242,7 @@ static u32 sis96x_func(struct i2c_adapte
 	    I2C_FUNC_SMBUS_PROC_CALL;
 }
 
-static struct i2c_algorithm smbus_algorithm = {
+static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= sis96x_access,
 	.functionality	= sis96x_func,
 };
diff --git a/drivers/i2c/busses/i2c-stub.c b/drivers/i2c/busses/i2c-stub.c
index 8cf374d..a54adc5 100644
--- a/drivers/i2c/busses/i2c-stub.c
+++ b/drivers/i2c/busses/i2c-stub.c
@@ -115,7 +115,7 @@ static u32 stub_func(struct i2c_adapter 
 		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA;
 }
 
-static struct i2c_algorithm smbus_algorithm = {
+static const struct i2c_algorithm smbus_algorithm = {
 	.functionality	= stub_func,
 	.smbus_xfer	= stub_xfer,
 };
diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
index 1ccc0fb..efc6bbf 100644
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -299,7 +299,7 @@ static u32 vt596_func(struct i2c_adapter
 	return func;
 }
 
-static struct i2c_algorithm smbus_algorithm = {
+static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= vt596_access,
 	.functionality	= vt596_func,
 };
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index eae9e81..32aab0d 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -383,7 +383,7 @@ static u32 scx200_acb_func(struct i2c_ad
 }
 
 /* For now, we only handle combined mode (smbus) */
-static struct i2c_algorithm scx200_acb_algorithm = {
+static const struct i2c_algorithm scx200_acb_algorithm = {
 	.smbus_xfer	= scx200_acb_smbus_xfer,
 	.functionality	= scx200_acb_func,
 };
-- 
1.4.2.1


