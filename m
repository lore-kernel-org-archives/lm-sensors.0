From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 24 Jul 2007 21:36:00 +0000
Subject: [lm-sensors] PATCH: hwmon-lm78-detect-isa-with-chipid-0x20.patch
Message-Id: <46A670C0.2020403@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040604030304010106090906"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040604030304010106090906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mark,

Here is a small but important bugfix to the lm78 driver. I found out about this
problem because a Fedora user filed a bug that the lm78 driver no longer worked
on his system: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=249428

The problem is that sometime ago the isa lm78 detection was made more stringent
and this new code now checks the chip-id, but does not accept a chip-id of 20h,
however a chip-id of 20h is valid, and is excepted in the main probe function
of the driver, see line 551. This fixed also makes the isa detection code
accept the chip-id of 0x20 fixing this issue.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Please include this in the next batch to be send to Linus so that it will get 
into 2.6.23, this is a regression rendering the lm78 driver not working in 
certain cases.

Regards,

Hans

--------------040604030304010106090906
Content-Type: text/x-patch; name="hwmon-lm78-detect-isa-with-chipid-0x20.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-lm78-detect-isa-with-chipid-0x20.patch"

Mark,

Here is a small but important bugfix to the lm78 driver. I found out about this
problem because a Fedora user filed a bug that the lm78 driver no longer worked
on his system: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=249428

The problem is that sometime ago the isa lm78 detection was made more stringent
and this new code now checks the chip-id, but does not accept a chip-id of 20h,
however a chip-id of 20h is valid, and is excepted in the main probe function
of the driver, see line 551. This fixed also makes the isa detection code
accept the chip-id of 0x20 fixing this issue.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up linux-2.6.22.x86_64/drivers/hwmon/lm78.c~ linux-2.6.22.x86_64/drivers/hwmon/lm78.c
--- linux-2.6.22.x86_64/drivers/hwmon/lm78.c~	2007-07-24 23:26:10.000000000 +0200
+++ linux-2.6.22.x86_64/drivers/hwmon/lm78.c	2007-07-24 23:26:10.000000000 +0200
@@ -864,7 +864,7 @@ static int __init lm78_isa_found(unsigne
 	/* Determine the chip type */
 	outb_p(LM78_REG_CHIPID, address + LM78_ADDR_REG_OFFSET);
 	val = inb_p(address + LM78_DATA_REG_OFFSET);
-	if (val == 0x00			/* LM78 */
+	if (val == 0x00 || val == 0x20	/* LM78 */
 	 || val == 0x40			/* LM78-J */
 	 || (val & 0xfe) == 0xc0)	/* LM79 */
 		found = 1;

--------------040604030304010106090906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040604030304010106090906--
