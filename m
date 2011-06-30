From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 30 Jun 2011 09:59:53 +0000
Subject: Re: [lm-sensors] Using Asus P5Q-E sensors/pwm
Message-Id: <CAKPcRGr6JW=7A5635F45uAnO3ebW4ncAW0uPh+po+LN7k90img@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110628194643.GM21173@epicure.lazyet.homelinux.net>
In-Reply-To: <20110628194643.GM21173@epicure.lazyet.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 28, 2011 at 9:46 PM, Etienne Buira
<etienne.buira.lists@free.fr> wrote:
> Hi all. Hope I'm not hitting the wrong place. Searched a bit the
> archives/google, but nothing that I could get working.
>
> I run an Asus P5Q-E, and try to get PWM working.
>
> Currently, I can read temperatures and fan speeds using asus_atk0110
> modules. Unfortunately, all files in /sys/class/hwmon/hwmon0 (excepted
> uevent) and /sys/class/hwmon/hwmon0/device are read-only, and there is
> no pwm* files.

This is expected, asus_atk0110 allows only monitoring. You can set a
fan profile in the BIOS though  (it's called Q-FAN).

[...]
> When I try to insmod w83627ehf (after rmmoding asus_atk0110):
> Jun 28 16:23:33 localhost kernel: w83627ehf: Found W83667HG chip at 0x290
> Jun 28 16:23:33 localhost kernel: ACPI: resource w83627ehf [io  0x0295-0x0296] conflicts with ACPI region HWRE [io  0x0290-0x0299 pref window disabled]
> Jun 28 16:23:33 localhost kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> (didn't try the acpi_enforce_resources=lax, don't know the probability
> of bad things to happen, but felt cold about it)

Yes, loading of the native driver (w83627ehf) is blocked by default
because the BIOS claims the chip for itself.
The only controlled way for accessing the monitoring data is the
ATK0110 interface.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
