From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 26 May 2009 09:09:10 +0000
Subject: Re: [lm-sensors] lm-sensors chip support
Message-Id: <4A1BB1B6.4060905@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <0331509C72A4CE4F925973DC8EC98E1B0165EC68@AMSACEX2.americas.ad.flextronics.com>
In-Reply-To: <0331509C72A4CE4F925973DC8EC98E1B0165EC68@AMSACEX2.americas.ad.flextronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 05/25/2009 05:17 PM, Rob Bloom wrote:
> Hi,
>
> I'm in a project which is looking at using lm-sensors to monitor the
> following chips on various circuit boards:
>
> - ADM1032ARMZ (temp sensor)
> - MAX6639 (temp sensor)
> - POWR1014A (power monitor)
> - SA56004EDP (temp sensor)
>
> I cross-checked these against the lm-sensors list of supported chips
> (http://www.lm-sensors.org/wiki/Devices) and find that only the 1st one
> is supported.
>
> Do you know if there are any plans to develop support for the latter 3
> in the list?

If it is not listed on the wiki then usually no drivers are being
developed for it.

> If there are no plans and no compatibilities, is there documentation you
> can point me to that describes a framework for adding a driver to be
> supported by lm-sensors.  I'd like to consider this if this is not
> difficult.
>

Writing new hwmon drivers usually is pretty straight forward. I would start
with the 2 temp drivers which generally speaking are easy. What you can do
is get an i2c-tiny-usb:
http://www.harbaum.org/till/i2c_tiny_usb/

Which is a small pcb with a =C5=B3C on it which plugs into usb on one side =
and
talks i2c on the other, get a few samples and connect those to the i2c bus,
and then start writing your driver.

A good example of a simple temp only hwmon driver for an i2c temp monitor
IC is the new driver for TI tmp401 / tmp411 IC's which you can find here:
http://www.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-h=
wmon/

> As I understand it, there is no chip-specific code in lm-sensors; to add
> support, one must add driver code into the kernel itself (ie. no code is
> added to the lm-sensors domain).  Is this correct?

Correct.

> Is there an example
> of a driver that was supported recently that I can use as an
> example/framework?
>

See above. Don't hesitate to ask any more questions if you have any I'm
always happy to help get people up to speed with hwmon driver development.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
