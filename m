From: gregkh@suse.de (Greg Kroah-Hartman)
Date: Tue, 14 Feb 2006 06:48:21 +0000
Subject: [lm-sensors] [PATCH 3/5] w83627hf: Document the reset module
Message-Id: <1139899701293-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Document the reset module parameter which was recently added to the
w83627hf driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 Documentation/hwmon/w83627hf |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

a40f0b0f2466483fad94e62177272d6a5711e50a
diff --git a/Documentation/hwmon/w83627hf b/Documentation/hwmon/w83627hf
index 5d23776..bbeaba6 100644
--- a/Documentation/hwmon/w83627hf
+++ b/Documentation/hwmon/w83627hf
@@ -36,6 +36,10 @@ Module Parameters
   (default is 1)
   Use 'init=0' to bypass initializing the chip.
   Try this if your computer crashes when you load the module.
+* reset: int
+  (default is 0)
+  The driver used to reset the chip on load, but does no more. Use
+  'reset=1' to restore the old behavior. Report if you need to do this.
 
 Description
 -----------



