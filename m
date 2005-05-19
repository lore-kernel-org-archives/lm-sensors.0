From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH] I2C: Fix broken force parameter handling
Message-Id: <11123113951584@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11123113951873@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2348, 2005/03/31 14:32:17-08:00, khali@linux-fr.org

[PATCH] I2C: Fix broken force parameter handling

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

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2005-03-31 15:16:10 -08:00
+++ b/drivers/i2c/i2c-core.c	2005-03-31 15:16:10 -08:00
@@ -715,7 +715,7 @@
 		   at all */
 		found = 0;
 
-		for (i = 0; !found && (address_data->force[i] != I2C_CLIENT_END); i += 3) {
+		for (i = 0; !found && (address_data->force[i] != I2C_CLIENT_END); i += 2) {
 			if (((adap_id = address_data->force[i]) || 
 			     (address_data->force[i] = ANY_I2C_BUS)) &&
 			     (addr = address_data->force[i+1])) {

