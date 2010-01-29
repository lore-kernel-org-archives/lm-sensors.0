From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 29 Jan 2010 08:37:40 +0000
Subject: Re: [lm-sensors] Help with asus_atk0110 module
Message-Id: <68676e01001290037o64afca82ra3ad2a5556ecb0e6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 29, 2010 at 5:17 AM, Juliano F. Ravasi <jravasi@gmail.com> wrote:
> Hello,
>
> I have an Asus P5VDC-X motherboard that used to work with the w83627ehf
> module, so I could read temperature sensors and adjust PWM outputs...
> until 2.6.31. I found that it was replaced by your asus_atk0110 module
> (source: <https://launchpad.net/bugs/382211>). However, I can't make it
> work in my computer.
>
> I would like to have your help to determine what is wrong. The driver
> loads ok, but /sys/class/hwmon is empty, not a single entry. The kernel
> log (dmesg) is completely silent while loading the driver, so I have no
> idea if the driver is not correct, or if it isn't detecting any sensor,
> or what. Is there any way to debug this?

The module complains when it encounters an error, otherwise is very silent...
In this case it seems that it's not even trying to attach to the hwmon
interface.

I need a copy of the DSDT (/sys/firmware/acpi/tables/DSDT).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
