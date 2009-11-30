From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 30 Nov 2009 23:47:27 +0000
Subject: [lm-sensors] [PATCH] therm_adt746x: Record pwm invert bit at module
Message-Id: <20091130234727.GA10295@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel <linux-kernel@vger.kernel.org>

In commit 0512a9a8e277a9de2820211eef964473b714ae65, we unilaterally zero the
"pwm invert" bit in the fan behavior configuration register.  On my PowerBook
G4, this results in the fans going to full speed at low temperature and
shutting off at high temperature because the pwm invert bit is supposed to be
set.

Therefore, record the pwm invert bit at driver load time, and write the bit
into the fan behavior control register.  This restores correct behavior on my
PBG4 and should work around the bit being set to the wrong value after
suspend/resume (which is what the original patch was trying to fix).  It also
fixes a minor omission where the pwm invert bit correction is NOT performed
when switching into automatic mode.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/macintosh/therm_adt746x.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)


diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 556f0fe..386a797 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -79,6 +79,7 @@ struct thermostat {
 	u8			limits[3];
 	int			last_speed[2];
 	int			last_var[2];
+	int			pwm_inv[2];
 };
 
 static enum {ADT7460, ADT7467} therm_type;
@@ -229,19 +230,23 @@ static void write_fan_speed(struct thermostat *th, int speed, int fan)
 	
 	if (speed >= 0) {
 		manual = read_reg(th, MANUAL_MODE[fan]);
+		manual &= ~INVERT_MASK;
 		write_reg(th, MANUAL_MODE[fan],
-			(manual|MANUAL_MASK) & (~INVERT_MASK));
+			manual | MANUAL_MASK | th->pwm_inv[fan]);
 		write_reg(th, FAN_SPD_SET[fan], speed);
 	} else {
 		/* back to automatic */
 		if(therm_type = ADT7460) {
 			manual = read_reg(th,
 				MANUAL_MODE[fan]) & (~MANUAL_MASK);
-
+			manual &= ~INVERT_MASK;
+			manual |= th->pwm_inv[fan];
 			write_reg(th,
 				MANUAL_MODE[fan], manual|REM_CONTROL[fan]);
 		} else {
 			manual = read_reg(th, MANUAL_MODE[fan]);
+			manual &= ~INVERT_MASK;
+			manual |= th->pwm_inv[fan];
 			write_reg(th, MANUAL_MODE[fan], manual&(~AUTO_MASK));
 		}
 	}
@@ -418,6 +423,10 @@ static int probe_thermostat(struct i2c_client *client,
 
 	thermostat = th;
 
+	/* record invert bit status because fw can corrupt it after suspend */
+	th->pwm_inv[0] = read_reg(th, MANUAL_MODE[0]) & INVERT_MASK;
+	th->pwm_inv[1] = read_reg(th, MANUAL_MODE[1]) & INVERT_MASK;
+
 	/* be sure to really write fan speed the first time */
 	th->last_speed[0] = -2;
 	th->last_speed[1] = -2;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
