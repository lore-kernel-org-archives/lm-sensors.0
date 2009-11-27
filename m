From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Nov 2009 08:01:16 +0000
Subject: Re: [lm-sensors] /sys/class/hwmon/ numbering
Message-Id: <20091127090116.03af9457@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <18910e4d0911260014m5fe3445cmf423b25e6a68bf50@mail.gmail.com>
In-Reply-To: <18910e4d0911260014m5fe3445cmf423b25e6a68bf50@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Bonjour Charles,

On Thu, 26 Nov 2009 09:14:45 +0100, Charles Pr=E9vot wrote:
> I have some problems configuring the fancontrol script, because each time=
 I
> shutdown my computer, when I reboot my /sys/class/hwmon/ is different
> (subfolders hwmon? are numbered differently).
> What is responsible for this order ?
> How can I configure it to have i fixed order ?
>=20
> my motherboard is a Asus MN2 SLI DELUXE with AMD CPU
> below some results:
>=20
> $ls -l /sys/class/hwmon/hwmon?/
> /sys/class/hwmon/hwmon0/:
> total 0
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 name
> drwxr-xr-x 2 root root    0 2009-11-26 08:51 power
> lrwxrwxrwx 1 root root    0 2009-11-26 08:51 subsystem ->
> ../../../../class/hwmon
> -r--r--r-- 1 root root 4096 2009-11-26 08:51 temp1_crit
> -r--r--r-- 1 root root 4096 2009-11-26 08:35 temp1_input
> -rw-r--r-- 1 root root 4096 2009-11-26 08:51 uevent
>=20
> /sys/class/hwmon/hwmon1/:
> total 0
> lrwxrwxrwx 1 root root    0 2009-11-26 08:30 device -> ../../../ATK0110:00
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan1_input
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan1_label
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan1_max
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan1_min
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan2_input
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan2_label
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan2_max
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan2_min
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan3_input
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan3_label
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan3_max
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan3_min
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_input
> -r--r--r-- 1 root root 4096 2009-11-26 08:27 in0_label
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_max
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_min
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_input
> -r--r--r-- 1 root root 4096 2009-11-26 08:27 in1_label
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_max
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_min
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_input
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 in2_label
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_max
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_min
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_input
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 in3_label
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_max
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_min
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 name
> drwxr-xr-x 2 root root    0 2009-11-26 08:30 power
> lrwxrwxrwx 1 root root    0 2009-11-26 08:30 subsystem ->
> ../../../../../../../class/hwmon
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp1_crit
> -r--r--r-- 1 root root 4096 2009-11-26 08:11 temp1_input
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp1_label
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp1_max
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp2_crit
> -r--r--r-- 1 root root 4096 2009-11-26 08:26 temp2_input
> -r--r--r-- 1 root root 4096 2009-11-26 08:33 temp2_label
> -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp2_max
> -rw-r--r-- 1 root root 4096 2009-11-26 08:30 uevent
>=20
> /sys/class/hwmon/hwmon2/:
> total 0
> lrwxrwxrwx 1 root root    0 2009-11-26 08:35 device -> ../../../it87.656
> drwxr-xr-x 2 root root    0 2009-11-26 08:51 power
> lrwxrwxrwx 1 root root    0 2009-11-26 08:51 subsystem ->
> ../../../../../class/hwmon
> -rw-r--r-- 1 root root 4096 2009-11-26 08:51 uevent
>=20
> $ cat /sys/class/hwmon/hwmon0/name
> acpitz
> $ cat /sys/class/hwmon/hwmon1/name
> atk0110

This is not the question you were asking, but you should NOT be using
drivers asus_atk0110 and it87 together. They access the same piece of
hardware, without synchronization of any form, which is dangerous. If
your kernel is recent enough that it has the asus_atk0110 driver (you
did not tell us the exact kernel version... I guess 2.6.30?) then you
should stop using the it87 driver. Kernel 2.6.31 and later will prevent
you from loading it87 so you better get used to it.

This will indirectly solve your problem, although probably not the way
you would like: the asus_atk0110 driver doesn't offer manual fan speed
control facilities, instead you must select the automatic fan speed
control strategy in the BIOS.

I'm not sure about the ACPI thermal zone, I thought Asus boards did not
have one. Luca, ever seen this before? Is it OK to use both the ACPI
thermal driver and the asus_atk0110 driver at the same time?

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
