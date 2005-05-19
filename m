From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: [PATCH 2.6] I2C: Fix broken force parameter handling
Message-Id: <20050327192856.6827c93d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I just noticed a nasty bug in the way the "force" parameter is handled
for non-sensors i2c chip drivers. The "force" parameter supposedy is a
list of adapter, address *pairs* where supported chips are
unquestionably assumed to be. However, after handling one pair, the i2c
core code searches for the next one *three* values later, not two. So
with the current code, the second and third pairs wouldn't be properly
handled. The fourth one would be, and so on.

As a side note, this questions the need of an array parameter handling
up to 24 of such pairs, when obviously nobody ever required more than
one for the past 6 years.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.12-rc1-mm3/drivers/i2c/i2c-core.c.orig	2005-03-26 07:00:03.000000000 +0100
+++ linux-2.6.12-rc1-mm3/drivers/i2c/i2c-core.c	2005-03-27 18:53:02.000000000 +0200
@@ -715,7 +715,7 @@
 		   at all */
 		found = 0;
 
-		for (i = 0; !found && (address_data->force[i] != I2C_CLIENT_END); i += 3) {
+		for (i = 0; !found && (address_data->force[i] != I2C_CLIENT_END); i += 2) {
 			if (((adap_id = address_data->force[i]) || 
 			     (address_data->force[i] = ANY_I2C_BUS)) &&
 			     (addr = address_data->force[i+1])) {


-- 
Jean Delvare
