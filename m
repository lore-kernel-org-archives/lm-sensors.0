From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:36 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop i2c_driver.{owner,name}, 6 of 11
Message-Id: <11365852563063@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11365852541748@kroah.com>
In-Reply-To: <11365852541748@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop i2c_driver.{owner,name}, 6 of 11

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the OSS drivers.

Signed-off-by: Laurent Riffard <laurent.riffard at free.fr>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit d74cdab1cad1e5895d8928eeeb2ac469f8410d2e
tree 67f0d77998c9c6bb1affbee5daf6320e07f06149
parent 604f28e2b8d34cbaf08f0351374645f161335a82
author Laurent Riffard <laurent.riffard at free.fr> Sat, 26 Nov 2005 20:46:32 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:23 -0800

 sound/oss/dmasound/dac3550a.c   |    6 ++++--
 sound/oss/dmasound/tas_common.c |    6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/oss/dmasound/dac3550a.c b/sound/oss/dmasound/dac3550a.c
index 3402a66..835e0cf 100644
--- a/sound/oss/dmasound/dac3550a.c
+++ b/sound/oss/dmasound/dac3550a.c
@@ -41,8 +41,10 @@ static int daca_detect_client(struct i2c
 static int daca_detach_client(struct i2c_client *client);
 
 struct i2c_driver daca_driver = {  
-	.owner			= THIS_MODULE,
-	.name			= "DAC3550A driver  V " DACA_VERSION,
+	.driver = {
+		.owner		= THIS_MODULE,
+		.name		= "DAC3550A driver  V " DACA_VERSION,
+	},
 	.id			= I2C_DRIVERID_DACA,
 	.attach_adapter		= daca_attach_adapter,
 	.detach_client		= daca_detach_client,
diff --git a/sound/oss/dmasound/tas_common.c b/sound/oss/dmasound/tas_common.c
index 7e3d517..bd6910a 100644
--- a/sound/oss/dmasound/tas_common.c
+++ b/sound/oss/dmasound/tas_common.c
@@ -47,8 +47,10 @@ static int tas_attach_adapter(struct i2c
 static int tas_detach_client(struct i2c_client *);
 
 struct i2c_driver tas_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "tas",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "tas",
+	},
 	.attach_adapter	= tas_attach_adapter,
 	.detach_client	= tas_detach_client,
 };


