From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 12 Aug 2007 18:47:31 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627ehf) don't assume bank 0
Message-Id: <11869444521360-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

Don't assume that the default bank is 0. For one thing, we don't even
set it to 0 when the driver is loaded, so the initial state might be
different. For another, something (say, the BIOS) might access the chip
and leave with the bank set to something different, so assuming that
the bank value is 0 is not safe.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/w83627ehf.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index bca7fbc..d9a9ec7 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -309,18 +309,16 @@ static inline int is_word_sized(u16 reg)
 	      || (reg & 0x00ff) = 0x55));
 }
 
-/* We assume that the default bank is 0, thus the following two functions do
-   nothing for registers which live in bank 0. For others, they respectively
-   set the bank register to the correct value (before the register is
-   accessed), and back to 0 (afterwards). */
+/* Registers 0x50-0x5f are banked */
 static inline void w83627ehf_set_bank(struct w83627ehf_data *data, u16 reg)
 {
-	if (reg & 0xff00) {
+	if ((reg & 0x00f0) = 0x50) {
 		outb_p(W83627EHF_REG_BANK, data->addr + ADDR_REG_OFFSET);
 		outb_p(reg >> 8, data->addr + DATA_REG_OFFSET);
 	}
 }
 
+/* Not strictly necessary, but play it safe for now */
 static inline void w83627ehf_reset_bank(struct w83627ehf_data *data, u16 reg)
 {
 	if (reg & 0xff00) {
-- 
1.5.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
