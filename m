From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 24 Jul 2008 12:13:53 +0000
Subject: Re: [lm-sensors] [spi-devel-general] [Patch 0/4] IndustrialIO
Message-Id: <48887201.8090300@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <488763AD.4050400@gmail.com>	<20080723174801.GC11009@khazad-dum.debian.net> <48884F04.4070403@tremplin-utc.net>
In-Reply-To: <48884F04.4070403@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Eric Piel <eric.piel@tremplin-utc.net>
Cc: Jonathan Cameron <Jonathan.Cameron@gmail.com>, mgross@linux.intel.com, Dmitry Torokhov <dtor@mail.ru>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, David Brownell <david-b@pacbell.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jean Delvare <khali@linux-fr.org>, spi-devel-general@lists.sourceforge.net, Ben Nizette <bn@niasdigital.com>


>> I'd like to see something done to have the common parts of interfaces of=
 the
>> same class (e.g. accelerometers) be standard.  Like hwmon does with
>> temp#_input, etc.
>>
>> Otherwise you made it easier to write drivers, but did nothing to help
>> userspace to USE the drivers :-)
> Hi,
> I completely agree with Henrique. There already exist 3 accelerometer=20
> drivers in the kernel (and I'm writing a fourth on). What we are=20
> desperately in need of is a _user_ interface. So that a generic program=20
> can pop up and say "Oh, there is an accelerometer on this computer, I'll =

> use it to detect free falls."
Agreed. (though on the whole I don't like testing that particular
functionality ;)
>=20
> IMHO, I think the ADC should have a much more specific and specialised=20
> (user and kernel) API corresponding to the accelerometers. Granted, you=20
> probably had in mind only the accelerometers for industrial usage, but=20
> it would be much better if the current accelerometer drivers had a=20
> reason to be ported to this new subsystem.>=20

> In particular, what I think would be worthy would be:
> * Up to 3 pre-defined axes (X, Y, Z) - that's provided by your current=20
> version of industrialio
> * If the accelerometer is soldered on the computer, define once for all=20
> to which _physical_ movement corresponds which axis (eg: a laptop on its =

> normal position going up has axis Z increasing).
Agreed, though this is more documentation (and strict enforcement on driver=
s)
> * Free fall event. Either it's hardware detected, or the accelerometer=20
> infrastructure will detect it in software.
Hadn't thought of doing that in software - should be relatively straight
forward, though would involve a fairly large overhead if the intention
is to detect it fast enough to park hardware etc. (similar to that for
the ring buffer I guess).  I'll look into getting that done for the next
version (maybe driver specific for now).
> * For each axis, what is the maximum and minimum bound and the unit -=20
> Probably worthy for the whole ADC infrastructure
Agreed - only laziness has prevented me adding the sysfs stuff to output
that sort of thing.
> * Joystick emulation (calibrated so that when the computer is not=20
> moving, all the values are at 0). All the current drivers have it.
Ok, this is a matter of writing an input subsystem element to do this.
It was discussed in the original discussion on lkml and is definitely
on the todo list (I like playing with that sort of thing as well :)
=20
> That's it for my wish-list for accelerometers :-)
>=20
>=20
> Also, a couple of specific comments on the patches:
> * At a quick glance, it seems the VTI SCA3000 driver sends events at 50% =

> and 75% ring full, while the ST LIS3L02DQ driver sends events at 50% and =

> 100%. Why this difference?
I wrote the lis3l02dq driver first, then discovered the VTI only gives hard=
ware
interrupts on those values.  Probably not something that is going to be easy
to standardize in general.  Can easily add more levels if only to ensure a
consistentish set are available.
> * The accelerometer infrastructure has axis offset and axis gain=20
> attributes. However, it seems really specific to the ST accelerometer=20
> (and still, I doubt it's useful for most users as those values are=20
> factory-set to good values).
I'd seriously debate that! For starters that lis3l02dq is reading slightly
over 10g static on my desk.  For the sort of stuff I do with these, the
factory calibration is typically shockingly inaccurate and subject to issues
like temperature of environment etc.
> Shouldn't they be moved to the ST LIS3L02DQ=20
> driver instead of being part of the accelerometer infrastructure?
Based on the other accels I've used (quite a few different ones) these
are pretty standard parameters - and I wish they were there on the VTI chip
as it's calibration is far from perfect.  They are to be found in about half
of all the accelerometers I've come across.
> * It would be also very good to provide a small userspace program=20
> showing how to read an industrialio device (=C3=A0 la evtest).
One is on it's way (oops, should have cleaned that up before posting these
patches)

At the moment the big missing element of the subsystem is an easy way of
querying what is there. (proc interface similar to that for the input subsy=
stem)
The lack of this makes writing remotely generic tests pretty hideous.  Curr=
ently
I have separate ones for each of the drivers which is just plain silly.
I guess for now posting a commented one of those would be a good start and
I'll do so after lunch.

Thanks for taking a look and particularly the accelerometer wish list. I'll=
 see
what I can do!

--
Jonathan Cameron

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
