From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Sep 2013 12:45:20 +0000
Subject: Re: [lm-sensors] +12 Voltage Constantly at +10.48 V on ASUS M5A78LE
Message-Id: <20130919124520.GA24088@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130918110156.Horde.yeEgEajJkz1f9borvfxiyA4@webmail.df.eu>
In-Reply-To: <20130918110156.Horde.yeEgEajJkz1f9borvfxiyA4@webmail.df.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 19, 2013 at 10:00:46AM +0200, Sascha Haupt wrote:
> Dear Guenter
> 
> thank you for the quick answer.
> 
> 
> We also had the idea to plug an multimeter between mass (black) and
> the +12V wire (yellow).
> The voltage was good at approx 12V.
> 
> Finally, I figured out that ACPI returned an incorrect value to the
> operating system.
> 
> 
> Therefore, I did the following:
> 
> Step 1: Get voltage values from the BIOS
> 
> VCORE =>  1.392 V
> +3.3V =>  3.304 V
> +5V   =>  5.130 V
> +12V  => 12.105 V
> 
> Step 2: Get the raw data from the sys-filesystem
> 
> cat /sys/class/hwmon/hwmon1/in1_input
> 3304
> cat /sys/class/hwmon/hwmon1/in2_input
> 5130
> cat /sys/class/hwmon/hwmon1/in3_input
> 10543
> 
> Step 3: Calculate values for sensors.conf
> 
> 3304 / 3304 = 1.0
> 5130 / 5130 = 1.0
> 12105 / 10543 = 1.14816
> 
> So only 12V needs a correction.
> 
> Step 4: Created file /etc/sensors.d/atk0110-acpi.conf
> 
> chip "atk0110-acpi-*"
>   compute in3 @ * 1.14816, @ / 1.14816
> 
> 
> I am still unsure why other machines with the same mainboard provide
> correct values.
> If I find a free time slot, I will check if all boards have the same
> BIOS version and settings.

Probably not, which would also explain your fan speedd problem.

Guenter

> At the moment, the solution above is ok for me.
> 
> 
> Thank you for your help.
> 
> Best regards
> Sascha
> 
> 
> Zitat von Guenter Roeck <linux@roeck-us.net>:
> 
> >On Wed, Sep 18, 2013 at 11:01:56AM +0200, Sascha Haupt wrote:
> >>
> >>Dear @ll,
> >>
> >>I am monitoring multiple systems (with Asus M5A78LE mainboards)
> >>using sensors and Munin.
> >>
> >>On one of the nodes, the +12 V value is constantly reported to be
> >>+10.48 Volt which
> >>causes Munin to report a warning (value outside 10.92 to 13.08 Volt range).
> >>The value seems to be close to +12 V on all other nodes.
> >>
> >>One idea was that the system reduces voltage to save power.
> >>Therefore I caused some load on the node:
> >>
> >>root:/home/root # md5sum /dev/urandom &
> >>root:/home/root # md5sum /dev/urandom &
> >>root:/home/root # md5sum /dev/urandom &
> >>root:/home/root # md5sum /dev/urandom &
> >>
> >>What I can see is that the 1.4 V value is now constanly at 1.38 V.
> >>Previously, it jumped between 1.01 V and 1.38 V.
> >
> >Makes sense, as the CPU voltage changes with load.
> >
> >>However, there is no difference in the +12 V value.
> >>
> >12V voltage does not usually change baed on power states.
> >
> >>I do not understand why the 12 V value stays at such an low voltage.
> >>
> >>May any power saving options cause that behaviour (when yes, which
> >>settings can cause that)?
> >>Do you have any ideas how I can localise the cause of the +10.48 Volt value?
> >>
> >Maybe there is a problem with that system ? Can you measure the
> >voltage at the
> >power supply ? That may even be related to the fan problem you
> >reported earlier
> >if that is on the same system, as the fans operate on 12V.
> >
> >Guenter
> >
> >>Thanks for your help.
> >>
> >>Best regards
> >>Sascha Haupt
> >>
> >>
> >>
> >>_______________________________________________
> >>lm-sensors mailing list
> >>lm-sensors@lm-sensors.org
> >>http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >>
> 
> 
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
