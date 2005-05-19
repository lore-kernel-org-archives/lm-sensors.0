From: stefan@desire.ch (Stefan Ott)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [patch] fscpos driver
Message-Id: <20050120175048.GL26072@desire.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050104185338.3296d72d.khali@linux-fr.org>
In-Reply-To: <20050104185338.3296d72d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean

On Thu, Jan 20, 2005 at 06:41:19PM +0100, Jean Delvare wrote:

> Hmm, wouldn't it more efficient to multiply all "mult" constants by 10
> directly?

Indeed, you're right. So here we go:

--- fscpos.c-orig	2005-01-20 03:49:05.000000000 +0100
+++ fscpos.c	2005-01-20 18:44:53.000000000 +0100
@@ -244,19 +244,19 @@
 static ssize_t show_volt_12(struct device *dev, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
-	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[0], 1420));
+	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[0], 14200));
 }
 
 static ssize_t show_volt_5(struct device *dev, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
-	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[1], 660));
+	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[1], 6600));
 }
 
 static ssize_t show_volt_batt(struct device *dev, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
-	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[2], 330));
+	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[2], 3300));
 }
 
 /* Watchdog */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050120/c10b535b/attachment.bin
