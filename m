From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun, 09 Aug 2015 10:04:11 +0000
Subject: [lm-sensors] [PATCH] mention sensors-detect(8) in sensors(1)
Message-Id: <20150809100411.GB8036@aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sensors-detect is a useful tool, but some users might be unware of it.
Mention it in the sensors(1) manpage.

--- a/prog/sensors/sensors.1
+++ b/prog/sensors/sensors.1
@@ -87,7 +87,7 @@ for further details.
 .RE
 
 .SH SEE ALSO
-sensors.conf(5)
+sensors.conf(5), sensors-detect(8).
 
 .SH AUTHOR
 Frodo Looijaard and the lm_sensors group

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
