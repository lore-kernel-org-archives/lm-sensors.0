From: gregkh@suse.de (Greg KH)
Date: Mon, 12 Sep 2005 22:10:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: w83627hf: no reset by default
Message-Id: <1126555519741@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: w83627hf: no reset by default

Make the reset of the chips in w83627hf optional rather than the
default. This reset has been causing trouble several times already. It
may even go completely away unless it proves to be useful to at least
one user.

Closes bug #5168:
http://bugzilla.kernel.org/show_bug.cgi?idQ68

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2251cf1a4b37bd483501614c2d78f5b8286f20d7
tree 40fee772d99be7e5d810ec9b493d98fadcaa4218
parent 0db9714a0ca2a1a36721a2e90fbfcbdf3d5ff117
author Jean Delvare <khali@linux-fr.org> Sun, 04 Sep 2005 22:52:17 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 09 Sep 2005 14:34:21 -0700

 drivers/hwmon/w83627hf.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -64,6 +64,10 @@ static unsigned short address;
 /* Insmod parameters */
 enum chips { any_chip, w83627hf, w83627thf, w83697hf, w83637hf };
 
+static int reset;
+module_param(reset, bool, 0);
+MODULE_PARM_DESC(reset, "Set to one to reset chip on load");
+
 static int init = 1;
 module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
@@ -1279,7 +1283,15 @@ static void w83627hf_init_client(struct 
 	int type = data->type;
 	u8 tmp;
 
-	if(init) {
+	if (reset) {
+		/* Resetting the chip has been the default for a long time,
+		   but repeatedly caused problems (fans going to full
+		   speed...) so it is now optional. It might even go away if
+		   nobody reports it as being useful, as I see very little
+		   reason why this would be needed at all. */
+		dev_info(&client->dev, "If reset=1 solved a problem you were "
+			 "having, please report!\n");
+
 		/* save this register */
 		i = w83627hf_read_value(client, W83781D_REG_BEEP_CONFIG);
 		/* Reset all except Watchdog values and last conversion values

