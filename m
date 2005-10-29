From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:03:33 +0000
Subject: [lm-sensors] [PATCH] i2c: Discard explicit static initializations
Message-Id: <11305336572834@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Discard explicit static initializations to 0

Kill explicit static initializations to 0 in 10 i2c drivers.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/i2c/algos/i2c-algo-pca.c    |    2 +-
 drivers/i2c/algos/i2c-algo-sibyte.c |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c    |    4 ++--
 drivers/i2c/busses/i2c-amd756.c     |    2 +-
 drivers/i2c/busses/i2c-iop3xx.c     |    2 +-
 drivers/i2c/busses/i2c-piix4.c      |    8 ++++----
 drivers/i2c/busses/i2c-sis5595.c    |    4 ++--
 drivers/i2c/busses/i2c-sis630.c     |    2 +-
 drivers/i2c/busses/i2c-sis96x.c     |    2 +-
 drivers/i2c/busses/i2c-via.c        |    2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

---
commit 605070952f0b41caaa211c47b02eeac703529008
tree 2fd15a6609ed602877164eec399fcae0919f64ea
parent b918ecd2429e1a89b846d9e49ca4520b963c13e8
author Jean Delvare <khali@linux-fr.org> Sun, 25 Sep 2005 16:23:07 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:06 -0700

 drivers/i2c/algos/i2c-algo-pca.c    |    2 +-
 drivers/i2c/algos/i2c-algo-sibyte.c |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c    |    4 ++--
 drivers/i2c/busses/i2c-amd756.c     |    2 +-
 drivers/i2c/busses/i2c-iop3xx.c     |    2 +-
 drivers/i2c/busses/i2c-piix4.c      |    8 ++++----
 drivers/i2c/busses/i2c-sis5595.c    |    4 ++--
 drivers/i2c/busses/i2c-sis630.c     |    2 +-
 drivers/i2c/busses/i2c-sis96x.c     |    2 +-
 drivers/i2c/busses/i2c-via.c        |    2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index beb10ed..82946ac 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -34,7 +34,7 @@
 #define DEB2(fmt, args...) do { if (i2c_debug>=2) printk(fmt, ## args); } while(0)
 #define DEB3(fmt, args...) do { if (i2c_debug>=3) printk(fmt, ## args); } while(0)
 
-static int i2c_debug=0;
+static int i2c_debug;
 
 #define pca_outw(adap, reg, val) adap->write_byte(adap, reg, val)
 #define pca_inw(adap, reg) adap->read_byte(adap, reg)
diff --git a/drivers/i2c/algos/i2c-algo-sibyte.c b/drivers/i2c/algos/i2c-algo-sibyte.c
index 8ed5ad1..938848a 100644
--- a/drivers/i2c/algos/i2c-algo-sibyte.c
+++ b/drivers/i2c/algos/i2c-algo-sibyte.c
@@ -42,7 +42,7 @@
 
 /* module parameters:
  */
-static int bit_scan=0;	/* have a look at what's hanging 'round		*/
+static int bit_scan;	/* have a look at what's hanging 'round		*/
 
 
 static int smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr, 
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
index b3f50bf..e13d60c 100644
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -125,12 +125,12 @@
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the device at the given address. */
-static u16 force_addr = 0;
+static u16 force_addr;
 module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the i2c controller");
 
-static unsigned short ali15x3_smba = 0;
+static unsigned short ali15x3_smba;
 
 static int ali15x3_setup(struct pci_dev *ALI15X3_dev)
 {
diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
index 6ad0603..3bbac2f 100644
--- a/drivers/i2c/busses/i2c-amd756.c
+++ b/drivers/i2c/busses/i2c-amd756.c
@@ -86,7 +86,7 @@
 #define AMD756_BLOCK_DATA	0x05
 
 
-static unsigned short amd756_ioport = 0;
+static unsigned short amd756_ioport;
 
 /* 
   SMBUS event = I/O 28-29 bit 11
diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 7bd9102..745e3a5 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -43,7 +43,7 @@
 #include "i2c-iop3xx.h"
 
 /* global unit counter */
-static int i2c_id = 0;
+static int i2c_id;
 
 static inline unsigned char 
 iic_cook_addr(struct i2c_msg *msg) 
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 6d48a4d..1b2d3eb 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -90,13 +90,13 @@ struct sd {
 
 /* If force is set to anything different from 0, we forcibly enable the
    PIIX4. DANGEROUS! */
-static int force = 0;
+static int force;
 module_param (force, int, 0);
 MODULE_PARM_DESC(force, "Forcibly enable the PIIX4. DANGEROUS!");
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the PIIX4 at the given address. VERY DANGEROUS! */
-static int force_addr = 0;
+static int force_addr;
 module_param (force_addr, int, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Forcibly enable the PIIX4 at the given address. "
@@ -104,14 +104,14 @@ MODULE_PARM_DESC(force_addr,
 
 /* If fix_hstcfg is set to anything different from 0, we reset one of the
    registers to be a valid value. */
-static int fix_hstcfg = 0;
+static int fix_hstcfg;
 module_param (fix_hstcfg, int, 0);
 MODULE_PARM_DESC(fix_hstcfg,
 		"Fix config register. Needed on some boards (Force CPCI735).");
 
 static int piix4_transaction(void);
 
-static unsigned short piix4_smba = 0;
+static unsigned short piix4_smba;
 static struct i2c_adapter piix4_adapter;
 
 static struct dmi_system_id __devinitdata piix4_dmi_table[] = {
diff --git a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
index 080318d..3fd38f4 100644
--- a/drivers/i2c/busses/i2c-sis5595.c
+++ b/drivers/i2c/busses/i2c-sis5595.c
@@ -123,11 +123,11 @@ static int blacklist[] = {
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the device at the given address. */
-static u16 force_addr = 0;
+static u16 force_addr;
 module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr, "Initialize the base address of the i2c controller");
 
-static unsigned short sis5595_base = 0;
+static unsigned short sis5595_base;
 
 static u8 sis5595_read(u8 reg)
 {
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index 86f0f44..44c4e68 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -101,7 +101,7 @@ module_param(force, bool, 0);
 MODULE_PARM_DESC(force, "Forcibly enable the SIS630. DANGEROUS!");
 
 /* acpi base address */
-static unsigned short acpi_base = 0;
+static unsigned short acpi_base;
 
 /* supported chips */
 static int supported[] = {
diff --git a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
index ead2ff3..9ddd910 100644
--- a/drivers/i2c/busses/i2c-sis96x.c
+++ b/drivers/i2c/busses/i2c-sis96x.c
@@ -83,7 +83,7 @@
 #define SIS96x_BLOCK_DATA 0x05
 
 static struct i2c_adapter sis96x_adapter;
-static u16 sis96x_smbus_base = 0;
+static u16 sis96x_smbus_base;
 
 static inline u8 sis96x_read(u8 reg)
 {
diff --git a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
index 040b8ab..0b3edd4 100644
--- a/drivers/i2c/busses/i2c-via.c
+++ b/drivers/i2c/busses/i2c-via.c
@@ -45,7 +45,7 @@
 #define IOSPACE		0x06
 #define IOTEXT		"via-i2c"
 
-static u16 pm_io_base = 0;
+static u16 pm_io_base;
 
 /*
    It does not appear from the datasheet that the GPIO pins are

