From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [PATCH] I2C update for 2.6.9
Message-Id: <10982315042830@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1098231504304@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1867.7.2, 2004/09/13 21:29:32-07:00, greg@kroah.com

I2C: fix up __iomem marking for i2c bus drivers

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-i810.c      |    2 +-
 drivers/i2c/busses/i2c-prosavage.c |    6 +++---
 drivers/i2c/busses/i2c-savage4.c   |    2 +-
 drivers/i2c/busses/i2c-voodoo3.c   |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-i810.c b/drivers/i2c/busses/i2c-i810.c
--- a/drivers/i2c/busses/i2c-i810.c	2004-10-19 16:55:21 -07:00
+++ b/drivers/i2c/busses/i2c-i810.c	2004-10-19 16:55:21 -07:00
@@ -70,7 +70,7 @@
 #define CYCLE_DELAY		10
 #define TIMEOUT			(HZ / 2)
 
-static void *ioaddr;
+static void __iomem *ioaddr;
 
 /* The i810 GPIO registers have individual masks for each bit
    so we never have to read before writing. Nice. */
diff -Nru a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- a/drivers/i2c/busses/i2c-prosavage.c	2004-10-19 16:55:21 -07:00
+++ b/drivers/i2c/busses/i2c-prosavage.c	2004-10-19 16:55:21 -07:00
@@ -68,7 +68,7 @@
 #define MAX_BUSSES	2
 
 struct s_i2c_bus {
-	void	*mmvga;
+	void __iomem *mmvga;
 	int	i2c_reg;
 	int	adap_ok;
 	struct i2c_adapter		adap;
@@ -76,7 +76,7 @@
 };
 
 struct s_i2c_chip {
-	void	*mmio;
+	void __iomem *mmio;
 	struct s_i2c_bus	i2c_bus[MAX_BUSSES];
 };
 
@@ -181,7 +181,7 @@
 /*
  * adapter initialisation
  */
-static int i2c_register_bus(struct pci_dev *dev, struct s_i2c_bus *p, u8 *mmvga, u32 i2c_reg)
+static int i2c_register_bus(struct pci_dev *dev, struct s_i2c_bus *p, void __iomem *mmvga, u32 i2c_reg)
 {
 	int ret;
 	p->adap.owner	  = THIS_MODULE;
diff -Nru a/drivers/i2c/busses/i2c-savage4.c b/drivers/i2c/busses/i2c-savage4.c
--- a/drivers/i2c/busses/i2c-savage4.c	2004-10-19 16:55:21 -07:00
+++ b/drivers/i2c/busses/i2c-savage4.c	2004-10-19 16:55:21 -07:00
@@ -73,7 +73,7 @@
 #define TIMEOUT			(HZ / 2)
 
 
-static void *ioaddr;
+static void __iomem *ioaddr;
 
 /* The sav GPIO registers don't have individual masks for each bit
    so we always have to read before writing. */
diff -Nru a/drivers/i2c/busses/i2c-voodoo3.c b/drivers/i2c/busses/i2c-voodoo3.c
--- a/drivers/i2c/busses/i2c-voodoo3.c	2004-10-19 16:55:21 -07:00
+++ b/drivers/i2c/busses/i2c-voodoo3.c	2004-10-19 16:55:21 -07:00
@@ -61,7 +61,7 @@
 #define TIMEOUT		(HZ / 2)
 
 
-static void *ioaddr;
+static void __iomem *ioaddr;
 
 /* The voo GPIO registers don't have individual masks for each bit
    so we always have to read before writing. */

