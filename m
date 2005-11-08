From: gregkh@suse.de (Greg KH)
Date: Tue, 08 Nov 2005 06:53:23 +0000
Subject: [lm-sensors] [PATCH] i2c: ds1337 BCD conversion fix
Message-Id: <11314291491841@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: ds1337 BCD conversion fix

Fix BCD value errors when month=9, moving the increment inside the
BIN2BCD macro.
Fix similar code for the weekday value, just for consistency.

This bug was reported by Michael Burian <dynmail1@gassner-waagen.at>.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ef9627464490fe67235bbd5724d55345b92c0315
tree 62ddcf3b6eaac8c723a09ab174c4afe330c135a3
parent a852daa00ad91350fe603da47becaf3d5af4f2bd
author James Chapman <jchapman@katalix.com> Sun, 06 Nov 2005 23:07:38 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 07 Nov 2005 21:46:37 -0800

 drivers/i2c/chips/ds1337.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
index 01b0370..02682fb 100644
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -164,9 +164,9 @@ static int ds1337_set_datetime(struct i2
 	buf[1] = BIN2BCD(dt->tm_sec);
 	buf[2] = BIN2BCD(dt->tm_min);
 	buf[3] = BIN2BCD(dt->tm_hour);
-	buf[4] = BIN2BCD(dt->tm_wday) + 1;
+	buf[4] = BIN2BCD(dt->tm_wday + 1);
 	buf[5] = BIN2BCD(dt->tm_mday);
-	buf[6] = BIN2BCD(dt->tm_mon) + 1;
+	buf[6] = BIN2BCD(dt->tm_mon + 1);
 	val = dt->tm_year;
 	if (val >= 100) {
 		val -= 100;

