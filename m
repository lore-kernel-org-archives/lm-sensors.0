From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 27 Jan 2011 17:14:31 +0000
Subject: Re: [lm-sensors] Identifying i2c devices on Asus P8P67 sandybridge
Message-Id: <20110127181431.5b524c99@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D40E39E.4030406@cfl.rr.com>
In-Reply-To: <4D40E39E.4030406@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Phillip,

On Thu, 27 Jan 2011 11:07:41 -0500, Phillip Susi wrote:
> On 1/27/2011 3:15 AM, Jean Delvare wrote:
> > Signed up for an account where? The only way I know to get Nuvoton
> > datasheets is asking for them by e-mail. Did you find another way?
>=20
> I just googled the part number and their web site came right up with a
> link to download the data sheet ( login required ).  I signed up for a
> login, confirmed via email, and downloaded it.
>=20
> http://www.sequoia.co.uk/components/product.php?d=3D1&cy&f(6&p=1425&fmt=
=3Dgrid

Oh, that's not "their website". This is a reseller's website. It's
pretty surprising that they allow visitors to download datasheets when
these aren't available from Nuvoton's website.

> > If any of our drivers is suitable for addition of NCT6776F support,
> > this would most likely be w83627ehf. But only a close look at the
> > datasheet will tell if this is possible and a desirable.
>=20
> Yep, this looks pretty similar so far.
>=20
> > First of all, I am not aware of any ACPI interface for automatic fan
> > speed control, not even for fan speed reporting. All I've ever seen
> > from standard ACPI interfaces are: temperature values with a 1=B0C
> > resolution, and fan on/off switching. As I said, this is very limited.
> > Mind you, there is a reason why Asus came up with their own "standard"
> > (ATK0110).
>=20
> It looks like the ACPI spec allows fans to define up to 10 levels of
> operation.  While that is a bit more coarse than the full 255 pwm
> levels, it should be enough.

Does ACPI allow reporting an unlimited number of voltage values? Does
ACPI allow reporting an unlimited number of fan speeds? Reporting of
temperature values with a resolution better than 1=B0C? Setting low and
high limits for each of these items?

Honestly, I don't know what ACPI allows. What I know is that I've never
seen any implementation going anywhere even remotely near to what a
native hwmon driver can offer.

> > Secondly, if you are going to write the code, writing it in the SSDT
> > won't save you any effort compared to writing native code (except that
> > I find ASL syntax horrible compared to C). The only interest of ACPI
> > implementations is that the OS needs no specific code to handle them,
> > but you still have hardware-specific driving code in the end. Simply,
> > it's in the BIOS, provided by the vendor, instead of being in the OS.
>=20
> The reason I was considering it was so I could send it to Asus and ask
> them to include it in future bios revs so that it just works right out
> of the box in the future.

Wow, you are pretty optimistic. A board vendor accepting code from
external contributors? I bet I will be dead before this happens.

> Having to figure out what hwmon driver to
> load, tell the kernel to let it even though the resources are claimed by
> acpi, then configure sensors and the fancontrol script is a pain.  The
> ACPI temperature just works without any configuration.

Or fails without any configuration, as happened to me on some boards.

> I also find the fancontrol script to be somewhat poor at controlling the
> fans and this really is a function that should be in the kernel and is
> defined by ACPI.

I wholeheartedly agree that pwmconfig and fancontrol suck. They are
afternoon hacks that have grown too old, and I wouldn't recommend
anyone to use them. I wish someone interested would write a proper tool
(i.e. not written in bash to start with) to deal with manual fan speed
control. And automatic fan speed control, too.

I also agree that the ACPI resource conflicts we're seeing on many
boards these days is a pain. But in many cases, the right fix would be
for board vendors to stop claiming resources they don't use.

And even with the two statements above, I still claim that native
hwmon drivers are doing a much better job than any ACPI implementation
I've seen. And don't believe it makes me happy: I would love all
systems to have hardware monitoring support working out of the box
thanks to a brilliant ACPI specification and no-less brilliant
implementations. But I don't expect this to happen any time soon :(

> > Decoded correctly by decode-dimms version 5733. I guess you were using
> > an old version of the script which didn't know about DDR3.
>=20
> They changed the format for DDR3?  Odd.

There is a common part mostly common to all SDRAM formats, and the rest
is type-specific. But the key problem is probably that the script can't
decode a type it doesn't know about. You can look at the source code
(or the JEDEC specs) if you are interested in the details.

> > I am surprised by the tRAS though, it seems way too high, there may be a
> > bug in the script.
>=20
> It should be 6-8-6-24.

Really? Is this what memtest86 is report? It's a long time since I last
saw a memory module with the 3 first digits not being the same.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
