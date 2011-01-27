From: Phillip Susi <psusi@cfl.rr.com>
Date: Thu, 27 Jan 2011 16:07:41 +0000
Subject: Re: [lm-sensors] Identifying i2c devices on Asus P8P67 sandybridge
Message-Id: <4D41984D.70207@cfl.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D40E39E.4030406@cfl.rr.com>
In-Reply-To: <4D40E39E.4030406@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 1/27/2011 3:15 AM, Jean Delvare wrote:
> Signed up for an account where? The only way I know to get Nuvoton
> datasheets is asking for them by e-mail. Did you find another way?

I just googled the part number and their web site came right up with a
link to download the data sheet ( login required ).  I signed up for a
login, confirmed via email, and downloaded it.

http://www.sequoia.co.uk/components/product.php?d=3D1&cy&f(6&p=1425&fmt=3Dg=
rid

> If any of our drivers is suitable for addition of NCT6776F support,
> this would most likely be w83627ehf. But only a close look at the
> datasheet will tell if this is possible and a desirable.

Yep, this looks pretty similar so far.

> First of all, I am not aware of any ACPI interface for automatic fan
> speed control, not even for fan speed reporting. All I've ever seen
> from standard ACPI interfaces are: temperature values with a 1=B0C
> resolution, and fan on/off switching. As I said, this is very limited.
> Mind you, there is a reason why Asus came up with their own "standard"
> (ATK0110).

It looks like the ACPI spec allows fans to define up to 10 levels of
operation.  While that is a bit more coarse than the full 255 pwm
levels, it should be enough.

> Secondly, if you are going to write the code, writing it in the SSDT
> won't save you any effort compared to writing native code (except that
> I find ASL syntax horrible compared to C). The only interest of ACPI
> implementations is that the OS needs no specific code to handle them,
> but you still have hardware-specific driving code in the end. Simply,
> it's in the BIOS, provided by the vendor, instead of being in the OS.

The reason I was considering it was so I could send it to Asus and ask
them to include it in future bios revs so that it just works right out
of the box in the future.  Having to figure out what hwmon driver to
load, tell the kernel to let it even though the resources are claimed by
acpi, then configure sensors and the fancontrol script is a pain.  The
ACPI temperature just works without any configuration.

I also find the fancontrol script to be somewhat poor at controlling the
fans and this really is a function that should be in the kernel and is
defined by ACPI.

> Decoded correctly by decode-dimms version 5733. I guess you were using
> an old version of the script which didn't know about DDR3.

They changed the format for DDR3?  Odd.

> I am surprised by the tRAS though, it seems way too high, there may be a
> bug in the script.

It should be 6-8-6-24.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
