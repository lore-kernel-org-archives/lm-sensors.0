From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 13 Oct 2011 14:40:53 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (w83627ehf) Skip reading unused
Message-Id: <20111013164053.3ce93e37@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When in6 is missing, don't read the corresponding registers, it's a
waste of time. The logic is similar to what we do for fans and
temperatures.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
This patch and the following one have been sitting on my drive for too
long, it's about time to get them reviewed and merged.

 drivers/hwmon/w83627ehf.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.39-rc0.orig/drivers/hwmon/w83627ehf.c	2011-03-18 14:56:30.000000000 +0100
+++ linux-2.6.39-rc0/drivers/hwmon/w83627ehf.c	2011-03-18 16:25:29.000000000 +0100
@@ -770,6 +770,9 @@ static struct w83627ehf_data *w83627ehf_
 
 		/* Measured voltages and limits */
 		for (i = 0; i < data->in_num; i++) {
+			if ((i = 6) && data->in6_skip)
+				continue;
+
 			data->in[i] = w83627ehf_read_value(data,
 				      W83627EHF_REG_IN(i));
 			data->in_min[i] = w83627ehf_read_value(data,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
