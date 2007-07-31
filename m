From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 31 Jul 2007 01:39:54 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add missing __devexit tags in various
Message-Id: <11858460011764-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070722120948.0609d79b@hyperion.delvare>
In-Reply-To: <20070722120948.0609d79b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

On Sun, 22 Jul 2007 00:30:56 +0200, Gabriel C wrote:
> I noticed this warnings on current git:
>
> drivers/hwmon/pc87360.c:1082: warning: 'pc87360_remove' defined but not used
> drivers/hwmon/sis5595.c:580: warning: 'sis5595_remove' defined but not used
> drivers/hwmon/smsc47m1.c:608: warning: 'smsc47m1_remove' defined but not used
> drivers/hwmon/via686a.c:648: warning: 'via686a_remove' defined but not used
> drivers/hwmon/vt8231.c:755: warning: 'vt8231_remove' defined but not used

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/it87.c     |    2 +-
 drivers/hwmon/pc87360.c  |    2 +-
 drivers/hwmon/sis5595.c  |    2 +-
 drivers/hwmon/smsc47m1.c |    2 +-
 drivers/hwmon/via686a.c  |    2 +-
 drivers/hwmon/vt8231.c   |    4 ++--
 drivers/hwmon/w83627hf.c |    2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index eff6036..d75dba9 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -252,7 +252,7 @@ struct it87_data {
 
 
 static int it87_probe(struct platform_device *pdev);
-static int it87_remove(struct platform_device *pdev);
+static int __devexit it87_remove(struct platform_device *pdev);
 
 static int it87_read_value(struct it87_data *data, u8 reg);
 static void it87_write_value(struct it87_data *data, u8 reg, u8 value);
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index cb72526..f57c75d 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -220,7 +220,7 @@ struct pc87360_data {
  */
 
 static int pc87360_probe(struct platform_device *pdev);
-static int pc87360_remove(struct platform_device *pdev);
+static int __devexit pc87360_remove(struct platform_device *pdev);
 
 static int pc87360_read_value(struct pc87360_data *data, u8 ldi, u8 bank,
 			      u8 reg);
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 83321b2..92956eb 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -187,7 +187,7 @@ struct sis5595_data {
 static struct pci_dev *s_bridge;	/* pointer to the (only) sis5595 */
 
 static int sis5595_probe(struct platform_device *pdev);
-static int sis5595_remove(struct platform_device *pdev);
+static int __devexit sis5595_remove(struct platform_device *pdev);
 
 static int sis5595_read_value(struct sis5595_data *data, u8 reg);
 static void sis5595_write_value(struct sis5595_data *data, u8 reg, u8 value);
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 1de2f2b..338ee4f 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -134,7 +134,7 @@ struct smsc47m1_sio_data {
 
 
 static int smsc47m1_probe(struct platform_device *pdev);
-static int smsc47m1_remove(struct platform_device *pdev);
+static int __devexit smsc47m1_remove(struct platform_device *pdev);
 static struct smsc47m1_data *smsc47m1_update_device(struct device *dev,
 		int init);
 
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 24a6851..696c8a2 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -314,7 +314,7 @@ struct via686a_data {
 static struct pci_dev *s_bridge;	/* pointer to the (only) via686a */
 
 static int via686a_probe(struct platform_device *pdev);
-static int via686a_remove(struct platform_device *pdev);
+static int __devexit via686a_remove(struct platform_device *pdev);
 
 static inline int via686a_read_value(struct via686a_data *data, u8 reg)
 {
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index c604972..3e63eaf 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -167,7 +167,7 @@ struct vt8231_data {
 
 static struct pci_dev *s_bridge;
 static int vt8231_probe(struct platform_device *pdev);
-static int vt8231_remove(struct platform_device *pdev);
+static int __devexit vt8231_remove(struct platform_device *pdev);
 static struct vt8231_data *vt8231_update_device(struct device *dev);
 static void vt8231_init_device(struct vt8231_data *data);
 
@@ -751,7 +751,7 @@ exit_release:
 	return err;
 }
 
-static int vt8231_remove(struct platform_device *pdev)
+static int __devexit vt8231_remove(struct platform_device *pdev)
 {
 	struct vt8231_data *data = platform_get_drvdata(pdev);
 	int i;
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 1ce7817..7a4a15f 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -387,7 +387,7 @@ struct w83627hf_sio_data {
 
 
 static int w83627hf_probe(struct platform_device *pdev);
-static int w83627hf_remove(struct platform_device *pdev);
+static int __devexit w83627hf_remove(struct platform_device *pdev);
 
 static int w83627hf_read_value(struct w83627hf_data *data, u16 reg);
 static int w83627hf_write_value(struct w83627hf_data *data, u16 reg, u16 value);
-- 
1.5.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
