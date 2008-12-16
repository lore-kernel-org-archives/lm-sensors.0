From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 16 Dec 2008 16:18:24 +0000
Subject: [lm-sensors] PATCH: f71882fg: fix fan_to/from_reg prototypes
Message-Id: <4947D4D0.3020405@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000808010303090808080402"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000808010303090808080402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean,

The RPM after conversion from / before conversion to a register value can be
much more then 65535 (up to 1500000), so putting this into an u16 can cause
overflows. This changes the functions to use an int to store / get RPM instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

--------------000808010303090808080402
Content-Type: text/plain;
 name="hwmon-f71882fg-18-fix-fan-reg-funcs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-f71882fg-18-fix-fan-reg-funcs.patch"

The RPM after conversion from / before conversion to a register value can be
much more then 65535 (up to 1500000), so putting this into an u16 can cause
overflows. This changes the functions to use an int to store / get RPM instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- f71882fg.c.17-applied	2008-12-15 16:30:57.000000000 +0100
+++ f71882fg.c	2008-12-16 17:14:53.000000000 +0100
@@ -810,12 +810,12 @@ static inline void superio_exit(int base
 	outb(SIO_LOCK_KEY, base);
 }
 
-static inline u16 fan_from_reg(u16 reg)
+static inline int fan_from_reg(u16 reg)
 {
 	return reg ? (1500000 / reg) : 0;
 }
 
-static inline u16 fan_to_reg(u16 fan)
+static inline u16 fan_to_reg(int fan)
 {
 	return fan ? (1500000 / fan) : 0;
 }

--------------000808010303090808080402
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000808010303090808080402--
