From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jul 2011 18:35:20 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (lm90) Simplify handling of
Message-Id: <20110724203520.07a3f202@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The optional extended local temperature register can never have
address 0, as this address is already used by another register. Thus
we can get rid of flag LM90_HAVE_LOCAL_EXT and simply rely on
reg_local_ext being non-zero to determine if a given chip has this
extension or not. This makes the code more simple.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Stijn Devriendt <sdevrien@cisco.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
Notes:
* This patch fixes a bug as a side effect: chip type max6657 lacked
  the definition of reg_local_ext. I can submit a separate patch for
  this, or it can be fixed in the patch which broke it (as it isn't in
  Linus' tree yet) and I'll adjust this one accordingly, or this patch
  can be merged in the patch which broke it altogether. All options
  are fine with me. Guenter?
* Another approach would be to keep MAX6657_REG_R_LOCAL_TEMPL, but set
  it automatically in lm90_probe(). Opinions?

 drivers/hwmon/lm90.c |   22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

--- linux-3.0-rc6.orig/drivers/hwmon/lm90.c	2011-07-07 13:30:02.000000000 +0200
+++ linux-3.0-rc6/drivers/hwmon/lm90.c	2011-07-07 13:35:10.000000000 +0200
@@ -170,7 +170,6 @@ enum chips { lm90, adm1032, lm99, lm86,
 #define LM90_FLAG_ADT7461_EXT	(1 << 0) /* ADT7461 extended mode	*/
 /* Device features */
 #define LM90_HAVE_OFFSET	(1 << 1) /* temperature offset register	*/
-#define LM90_HAVE_LOCAL_EXT	(1 << 2) /* extended local temperature	*/
 #define LM90_HAVE_REM_LIMIT_EXT	(1 << 3) /* extended remote limit	*/
 #define LM90_HAVE_EMERGENCY	(1 << 4) /* 3rd upper (emergency) limit	*/
 #define LM90_HAVE_EMERGENCY_ALARM (1 << 5)/* emergency alarm		*/
@@ -214,8 +213,7 @@ struct lm90_params {
 	u16 alert_alarms;	/* Which alarm bits trigger ALERT# */
 				/* Upper 8 bits for max6695/96 */
 	u8 max_convrate;	/* Maximum conversion rate register value */
-	u8 reg_local_ext;	/* Local extension register if
-				   LM90_HAVE_LOCAL_EXT is set*/
+	u8 reg_local_ext;	/* Extended local temp register (optional) */
 };
 
 static const struct lm90_params lm90_params[] = {
@@ -247,18 +245,17 @@ static const struct lm90_params lm90_par
 		.max_convrate = 9,
 	},
 	[max6646] = {
-		.flags = LM90_HAVE_LOCAL_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 6,
 		.reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
 	},
 	[max6657] = {
-		.flags = LM90_HAVE_LOCAL_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
+		.reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
 	},
 	[max6659] = {
-		.flags = LM90_HAVE_LOCAL_EXT | LM90_HAVE_EMERGENCY,
+		.flags = LM90_HAVE_EMERGENCY,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
 		.reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
@@ -269,7 +266,7 @@ static const struct lm90_params lm90_par
 		.max_convrate = 7,
 	},
 	[max6696] = {
-		.flags = LM90_HAVE_LOCAL_EXT | LM90_HAVE_EMERGENCY
+		.flags = LM90_HAVE_EMERGENCY
 		  | LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3,
 		.alert_alarms = 0x187c,
 		.max_convrate = 6,
@@ -281,8 +278,7 @@ static const struct lm90_params lm90_par
 		.max_convrate = 8,
 	},
 	[sa56004] = {
-		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_LOCAL_EXT,
+		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 		.reg_local_ext = SA56004_REG_R_LOCAL_TEMPL,
@@ -475,7 +471,7 @@ static struct lm90_data *lm90_update_dev
 		lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT, &data->temp8[3]);
 		lm90_read_reg(client, LM90_REG_R_TCRIT_HYST, &data->temp_hyst);
 
-		if (data->flags & LM90_HAVE_LOCAL_EXT) {
+		if (data->reg_local_ext) {
 			lm90_read16(client, LM90_REG_R_LOCAL_TEMP,
 				    data->reg_local_ext,
 				    &data->temp11[4]);
@@ -1396,15 +1392,11 @@ static int lm90_probe(struct i2c_client
 
 	/* Set chip capabilities */
 	data->flags = lm90_params[data->kind].flags;
+	data->reg_local_ext = lm90_params[data->kind].reg_local_ext;
 
 	/* Set maximum conversion rate */
 	data->max_convrate = lm90_params[data->kind].max_convrate;
 
-	if (data->flags & LM90_HAVE_LOCAL_EXT) {
-		data->reg_local_ext = lm90_params[data->kind].reg_local_ext;
-		WARN_ON(data->reg_local_ext = 0);
-	}
-
 	/* Initialize the LM90 chip */
 	lm90_init_client(new_client);
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
