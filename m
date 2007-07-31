From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 31 Jul 2007 01:39:52 +0000
Subject: [lm-sensors] [PATCH] hwmon: fix lm78 detection regression
Message-Id: <11858460011182-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Hans de Goede <j.w.r.degoede@hhs.nl>

Here is a small but important bugfix to the lm78 driver. I found out about this
problem because a Fedora user filed a bug that the lm78 driver no longer worked
on his system: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id$9428

The problem is that sometime ago the isa lm78 detection was made more stringent
and this new code now checks the chip-id, but does not accept a chip-id of 20h,
however a chip-id of 20h is valid, and is excepted in the main probe function
of the driver, see line 551. This fixed also makes the isa detection code
accept the chip-id of 0x20 fixing this issue.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/lm78.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 9fb572f..565c4e6 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -864,7 +864,7 @@ static int __init lm78_isa_found(unsigned short address)
 	/* Determine the chip type */
 	outb_p(LM78_REG_CHIPID, address + LM78_ADDR_REG_OFFSET);
 	val = inb_p(address + LM78_DATA_REG_OFFSET);
-	if (val = 0x00			/* LM78 */
+	if (val = 0x00 || val = 0x20	/* LM78 */
 	 || val = 0x40			/* LM78-J */
 	 || (val & 0xfe) = 0xc0)	/* LM79 */
 		found = 1;
-- 
1.5.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
