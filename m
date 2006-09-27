From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:39 +0000
Subject: [lm-sensors] [PATCH 8/30] i2c-sibyte: Kip Walker is gone
Message-Id: <11593189461772-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-sibyte: Kip Walker is gone

Kip Walker no longer works at Broadcom, and his e-mail address there
bounces back, so let's drop it.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/i2c-sibyte.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sibyte.c b/drivers/i2c/busses/i2c-sibyte.c
index f516eb7..96c9e7b 100644
--- a/drivers/i2c/busses/i2c-sibyte.c
+++ b/drivers/i2c/busses/i2c-sibyte.c
@@ -217,6 +217,6 @@ static void __exit i2c_sibyte_exit(void)
 module_init(i2c_sibyte_init);
 module_exit(i2c_sibyte_exit);
 
-MODULE_AUTHOR("Kip Walker <kwalker at broadcom.com>, Steven J. Hill <sjhill at realitydiluted.com>");
+MODULE_AUTHOR("Kip Walker (Broadcom Corp.), Steven J. Hill <sjhill at realitydiluted.com>");
 MODULE_DESCRIPTION("SMBus adapter routines for SiByte boards");
 MODULE_LICENSE("GPL");
-- 
1.4.2.1


