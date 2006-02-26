From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 26 Feb 2006 18:53:51 +0000
Subject: [lm-sensors] lm_sensors install question (newbie)
Message-Id: <xboUvzAs.1140980031.4740150.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <4400AAFE.6000602@attglobal.net>
In-Reply-To: <4400AAFE.6000602@attglobal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Meir,

> I upgraded to "i2c/lm_sensors 2.10.0" on my two machines:
>
> Hardware: 1) Toshiba P25 S609 laptop. Chipset: Intel 865PE + ICH5.
>           2) Desktop with KT40A-ANH 'Mach 4' motherboard. Chipset: Via
>              KT400A CD + Via 8235CE.
> Software: Linux kernel 2.4.26, Slackware 10.0.
>
> Results:  Desktop now machine WORKS!
>           Laptop still does NOT detect any chips.

It's very frequent that laptops have no chips lm_sensors recognizes, so
I wouldn't look any further in that direction.

More often than not, the only temperature source for laptops is ACPI.
Assuming you have ACPI support turned on in your kernel, try loading the
"thermal" kernel module, then look in /proc/acpi/thermal_zone. If you
have files there, read them to find the system temperature. A more
convenient way to read the values is by using the "acpi" command line
client. Slackware doesn't package it, but you can download the sources
[1] and compile it by yourself easily.

[1] http://grahame.angrygoats.net/acpi.shtml

--
Jean Delvare

