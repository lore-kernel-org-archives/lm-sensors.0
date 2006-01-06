From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:36 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop i2c_driver.{owner,name}, 10 of 11
Message-Id: <11365852563252@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11365852541748@kroah.com>
In-Reply-To: <11365852541748@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop i2c_driver.{owner,name}, 10 of 11

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the drivers for arm arch.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
CC: Laurent Riffard <laurent.riffard at free.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit b33a665dba55c83f08cdd62aba1cd2672bccdd80
tree 42d6c3a15739007a092ac56e887c1f5022ce426c
parent 1a7edcdca618d25564690c2df27c2c5c6e9f6316
author Jean Delvare <khali at linux-fr.org> Sat, 26 Nov 2005 20:54:10 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:24 -0800

 arch/arm/mach-pxa/akita-ioexp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/akita-ioexp.c b/arch/arm/mach-pxa/akita-ioexp.c
index b6bff55..6f7b965 100644
--- a/arch/arm/mach-pxa/akita-ioexp.c
+++ b/arch/arm/mach-pxa/akita-ioexp.c
@@ -124,8 +124,10 @@ static int max7310_detach_client(struct 
 }
 
 static struct i2c_driver max7310_i2c_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "akita-max7310",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "akita-max7310",
+	},
 	.id		= I2C_DRIVERID_AKITAIOEXP,
 	.attach_adapter	= max7310_attach_adapter,
 	.detach_client	= max7310_detach_client,


