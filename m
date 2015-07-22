From: Denis Carikli <denis@eukrea.com>
Date: Wed, 22 Jul 2015 16:30:20 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: ads7828: Add devicetree documentation
Message-Id: <1437582620-2294-3-git-send-email-denis@eukrea.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437582620-2294-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1437582620-2294-1-git-send-email-denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 00f8652..d77d412 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -95,6 +95,8 @@ stm,m41t00		Serial Access TIMEKEEPER
 stm,m41t62		Serial real-time clock (RTC) with alarm
 stm,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
 taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
+ti,ads7828		8-Channels, 12-bit ADC
+ti,ads7830		8-Channels, 8-bit ADC
 ti,tsc2003		I2C Touch-Screen Controller
 ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
 ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
-- 
2.4.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
