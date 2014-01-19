From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
Date: Sun, 19 Jan 2014 14:36:52 +0000
Subject: [lm-sensors] [PATCH] Spelling fixes
Message-Id: <1390142212-3914-1-git-send-email-ville.skytta@iki.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

---
 etc/sensors.conf.eg             | 6 +++---
 prog/sensors/chips.c            | 2 +-
 prog/tellerstats/gather.sh      | 2 +-
 prog/tellerstats/tellerstats.sh | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/etc/sensors.conf.eg b/etc/sensors.conf.eg
index 542e2ea..d8fc9fc 100644
--- a/etc/sensors.conf.eg
+++ b/etc/sensors.conf.eg
@@ -1980,9 +1980,9 @@ chip "f71805f-*" "f71872f-*"
 
 
 # Abit Uguru sensor part configuration.
-# The Abit Uguru is relativly straight forward to configure.
+# The Abit Uguru is relatively straight forward to configure.
 # label statements:
-# The voltage (in) temp and fan sensors are usualy in the same order as listed
+# The voltage (in) temp and fan sensors are usually in the same order as listed
 # in the BIOS, but not always!
 # compute statements:
 # The temp and fan sensors don't need any compute statements. Most voltage
@@ -1994,7 +1994,7 @@ chip "f71805f-*" "f71872f-*"
 # mutiplier, 5 volt the 1.788 and 12 volt the 4.153.
 # set statements:
 # The Abit BIOS sets reasonable treshholds and allows changing them, thus
-# set statements may be ommited. The abituguru kernel driver does support
+# set statements may be omitted. The abituguru kernel driver does support
 # them if you want to add them.
 #
 # The configuration below is for the Kv8Pro and AV8 this is the default as this
diff --git a/prog/sensors/chips.c b/prog/sensors/chips.c
index 7112419..d0e556c 100644
--- a/prog/sensors/chips.c
+++ b/prog/sensors/chips.c
@@ -115,7 +115,7 @@ static int get_label_size(const sensors_chip_name *name)
 	int i;
 	const sensors_feature *iter;
 	char *label;
-	unsigned int max_size = 11;	/* 11 as minumum label width */
+	unsigned int max_size = 11;	/* 11 as minimum label width */
 
 	i = 0;
 	while ((iter = sensors_get_features(name, &i))) {
diff --git a/prog/tellerstats/gather.sh b/prog/tellerstats/gather.sh
index 131837d..6f018ea 100755
--- a/prog/tellerstats/gather.sh
+++ b/prog/tellerstats/gather.sh
@@ -26,7 +26,7 @@
 
 # generic tellerstats init BEGIN
 
-# get config information from /etc/tellerstats.conf or whereever we are pointed
+# get config information from /etc/tellerstats.conf or wherever we are pointed
 
 if [ -z "$TELLERSTATS_CONF" ]
 then
diff --git a/prog/tellerstats/tellerstats.sh b/prog/tellerstats/tellerstats.sh
index 954a20c..21153f3 100755
--- a/prog/tellerstats/tellerstats.sh
+++ b/prog/tellerstats/tellerstats.sh
@@ -23,7 +23,7 @@
 
 # generic tellerstats init BEGIN
 
-# get config information from /etc/tellerstats.conf or whereever we are pointed
+# get config information from /etc/tellerstats.conf or wherever we are pointed
 
 if [ -z "$TELLERSTATS_CONF" ]
 then
-- 
1.8.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
