From: Ben Gamari <bgamari.foss@gmail.com>
Date: Sun, 08 Dec 2013 21:02:17 +0000
Subject: [lm-sensors] [PATCH 2/3] dt: Remove redundant entry from trivial devices
Message-Id: <1386536538-14861-2-git-send-email-bgamari.foss@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1386536538-14861-1-git-send-email-bgamari.foss@gmail.com>
In-Reply-To: <1386536538-14861-1-git-send-email-bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Ben Gamari <bgamari.foss@gmail.com>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 9c3a684..c475c3a 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -12,8 +12,7 @@ Compatible		Vendor / Chip
 ad,adt7411		I2C Digital 8-channel 10-bit ADC and temperature sensor
 ad,ad7414		SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
 ad,adm9240		ADM9240:  Complete System Hardware Monitor for uProcessor-Based Systems
-adi,adt7461		+/-1C TDM Extended Temp Range I.C
-adt7461			+/-1C TDM Extended Temp Range I.C
+adi,adt7461		+/-1C SMBus digital thermometer
 at,24c08		i2c serial eeprom  (24cxx)
 atmel,24c02		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
-- 
1.8.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
