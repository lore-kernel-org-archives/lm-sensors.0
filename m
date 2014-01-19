From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
Date: Sun, 19 Jan 2014 14:32:25 +0000
Subject: [lm-sensors] [PATCH] Do not order services after syslog.target
Message-Id: <1390141945-3610-1-git-send-email-ville.skytta@iki.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

http://www.freedesktop.org/wiki/Software/systemd/syslog/
https://fedorahosted.org/fpc/ticket/177#comment:2
http://lists.opensuse.org/archive/opensuse-packaging/2013-05/msg00102.html
---
 prog/init/lm_sensors.service | 1 -
 prog/init/sensord.service    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/prog/init/lm_sensors.service b/prog/init/lm_sensors.service
index 2a6243d..7d3bf80 100644
--- a/prog/init/lm_sensors.service
+++ b/prog/init/lm_sensors.service
@@ -1,6 +1,5 @@
 [Unit]
 Description=Initialize hardware monitoring sensors
-After=syslog.target
 
 [Service]
 EnvironmentFile=/etc/sysconfig/lm_sensors
diff --git a/prog/init/sensord.service b/prog/init/sensord.service
index 47fcab2..2448bee 100644
--- a/prog/init/sensord.service
+++ b/prog/init/sensord.service
@@ -1,7 +1,6 @@
 [Unit]
 Description=Log hardware monitoring data
 After=lm_sensors.service
-After=syslog.target
 
 [Service]
 EnvironmentFile=/etc/sysconfig/sensord
-- 
1.8.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
