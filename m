From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:36 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop i2c_driver.{owner,name}, 7 of 11
Message-Id: <11365852564182@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11365852541748@kroah.com>
In-Reply-To: <11365852541748@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop i2c_driver.{owner,name}, 7 of 11

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the drivers for ppc arch.

Signed-off-by: Laurent Riffard <laurent.riffard at free.fr>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit e100fe103e679372b3d1d6e9d32fd3ab57484be2
tree b45c17d6c44523f8ea51f84cd59e942e9d4dfc34
parent d74cdab1cad1e5895d8928eeeb2ac469f8410d2e
author Laurent Riffard <laurent.riffard at free.fr> Sat, 26 Nov 2005 20:48:35 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:23 -0800

 sound/ppc/keywest.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index fd8e2e6..d532924 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -41,7 +41,10 @@ static int keywest_attach_adapter(struct
 static int keywest_detach_client(struct i2c_client *client);
 
 struct i2c_driver keywest_driver = {  
-	.name = "PMac Keywest Audio",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "PMac Keywest Audio",
+	},
 	.id = I2C_DRIVERID_KEYWEST,
 	.attach_adapter = &keywest_attach_adapter,
 	.detach_client = &keywest_detach_client,


