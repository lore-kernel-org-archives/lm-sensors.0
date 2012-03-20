From: Jonathan Nieder <jrnieder@gmail.com>
Date: Tue, 20 Mar 2012 23:16:57 +0000
Subject: Re: [lm-sensors] asus_atk0110: i8042: keys get stuck and keyboard stops responding
Message-Id: <20120320231656.GC12339@burratino>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Luca et al,

Several people have been finding the PS/2 keyboard and mouse suddenly
stop working a few hours after loading the asus_atk0110 module on
machines using the Asus P7P55D or P7P55D-E board.  For example:

GSR wrote[1]:

> Newly installed machine and every few hours the PS/2 keyboard dies
> leaving a key stuck, but the USB mouse still works. Focusing different
> windows shows something being typed or a modifier key taking effect
> (depends, each time is a different key
[...]
> Accesing the machine via ssh shows the system still works, allows
> changing VT with chvt (just to see what they have, no input allowed),
> killing programs or rebooting, but no obvious way to recover the kbd
> other than restart.
[...]
> ACPI: EC: GPE storm detected, transactions will use polling mode
> atkbd serio0: Unknown key pressed (translated set 2, code 0x8b on isa0060/serio0).
> atkbd serio0: Use 'setkeycodes e00b <keycode>' to make it known.
[...]
> DMI 2.6 present.
> DMI: System manufacturer System Product Name/P7P55D, BIOS 1807    07/22/2010
[...]
> After searching some more and finding I am not alone with respect to
> stuck keyboard, I also found that someone suggests (in
> https://bugzilla.redhat.com/show_bug.cgi?idg6446 ) to invoke
>
> echo -n reconnect > /sys/devices/platform/i8042/serio0/drvctl
>
> and so far it seems to recover the keyboard

Some people reporting the problem cc-ed.  Problem seems to exist in
kernels as old as 2.6.32 and as new as 3.3-rc6.

From [2] I see that you tracked it down to a BIOS problem.  So I am
curious: would there be a way to detect affected machines and
automatically work around this?  Toy patch just to give the idea
follows.

[1] http://bugs.debian.org/662895
[2] http://thread.gmane.org/gmane.linux.drivers.sensors/24194/focus&426

diff --git i/drivers/hwmon/asus_atk0110.c w/drivers/hwmon/asus_atk0110.c
index 00e98517f94c..494090df89f2 100644
--- i/drivers/hwmon/asus_atk0110.c
+++ w/drivers/hwmon/asus_atk0110.c
@@ -38,6 +38,19 @@ static const struct dmi_system_id __initconst atk_force_new_if[] = {
 	{ }
 };
 
+static const struct dmi_system_id __initconst atk0110_blacklist[] = {
+	{
+		/* http://bugs.debian.org/662895 */
+		.ident = "Asus P7P55D",
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "P7P55D")
+		}
+	},
+	{ }
+};
+
 /* Minimum time between readings, enforced in order to avoid
  * hogging the CPU.
  */
@@ -1439,6 +1452,9 @@ static int __init atk0110_init(void)
 	if (dmi_check_system(atk_force_new_if))
 		new_if = true;
 
+	if (dmi_check_system(atk0110_blacklist))
+		return -ENODEV;
+
 	ret = acpi_bus_register_driver(&atk_driver);
 	if (ret)
 		pr_info("acpi_bus_register_driver failed: %d\n", ret);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
