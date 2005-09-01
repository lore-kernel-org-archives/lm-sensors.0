From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 01 Sep 2005 00:11:16 +0000
Subject: [lm-sensors] [patch 1/2] pc87360 vref-int-ext - fix int/ext vref
Message-Id: <200508312210.j7VMAS6k008322@harpo.jimc.earth>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

01	pc87360-01-fix-vref-ext-int-mixup.patch

fixes a 1-line bug in the internal vs external voltage reference
selection, Old code used vrefint when vrefext was chosen, and vice
versa.


[jimc@harpo pset-pc87360-vref]$ diffstat pc87360-0*
 2 files changed, 30 insertions(+), 2 deletions(-)


Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>




diff -ruNp -X exclude-diffs gkh-i2c/drivers/hwmon/pc87360.c V-1/drivers/hwmon/pc87360.c
--- gkh-i2c/drivers/hwmon/pc87360.c	2005-08-31 06:54:47.000000000 -0600
+++ V-1/drivers/hwmon/pc87360.c	2005-08-31 15:14:21.000000000 -0600
@@ -798,7 +798,7 @@ static int pc87360_detect(struct i2c_ada
 			i &= pc87360_read_value(data, LD_TEMP, NO_BANK,
 						PC87365_REG_TEMP_CONFIG);
 		}
-		data->in_vref = (i&0x02) ? 3025 : 2966;
+		data->in_vref = (i&0x02) ? 2966 : 3025;
 		dev_dbg(&new_client->dev, "Using %s reference voltage\n",
 			(i&0x02) ? "external" : "internal");
 
