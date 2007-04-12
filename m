From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Thu, 12 Apr 2007 05:57:28 +0000
Subject: Re: [lm-sensors] Hardware monitoring subsystem maintainer
Message-Id: <461dca480d7ec@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

This is comments from someone who is newbie to this list.

Dnia 11-04-2007 o godz. 11:24 Hans de Goede napisa=B3(a):
> Rudolf Marek wrote:
> > Maybe we could try following:
> >=20
> > 1) person post the driver
> > 2) quick review could be done critical fixes only, driver
goes to -mm
> > 3) review that goes deeper - check for interface conformity
and all the=20
> > stuff which could break - fixes for non-critical stuff
> > 4) after this driver goes to Linus tree at the very beginning
for the=20
> > merge cycle marked as EXPERIMENTAL
> > 5) if the person agrees to be in MAINTAINER final review may
be done and=20
> > EXPERIMENTAL could be removed. (This is step which might
involve all=20
> > steps to make the driver really perfect ;)
> >=20

I suppose that 3 reviews are too much.  I would suggest to merge
a driver/patch as experimental just after deep review. The
experimental status can be removed if two persons (including
author if he has tested) can confirm it works. One cannot find
all problems in one turn. They will pop up later, but you will
get wider base of testers if it is in the mainline.

The third review (to removed the experimental status) seems to be
waste of your time.

> 1a) We need a set of review guidelines / a review checklist.
Here is a start:

Maybe these guidelines can be described in more details and with
links or names of documents with more description.

> * Must follow kernel coding style guidelines

Is there any tool to check this? If there is one, a basic
instruction how to use it would be great.

> * sysfs interface must be in accordance with
Documentation/hwmon/sysfs

The documentation is still confusing to me. Can someone of you
update it to answer these questions directly?

A. What is meaning of 0 and 1 values in pwmX_enable ?
B. How to stop the fan (pwmX_enable =3D 1 and pwmX =3D 0 was
suggested to someone on the list)?
C. How t o handle situation if the pwm register minimum value (0)
does not stop the fan, but there is a separate bit to do it? (do
stop emulate with the bit when 0 is written to pwmX?)

> * proper locking to avoid 2 simultaneous attempts to
communicate with the
>    device when for example multiple sysfs files get read at once.

An example or two common errors would be great help.

> * check the code for any obvious programming errors, like:
>    -not freeing resources (in error paths and in general)
>    -overrunning an array
>    -not checking return values of calls to other parts of the
kernel
>    -of by one errors / bad loops
>    -etc.

List them, so a newbie can check the code against it.

> 1b) We need to decide somehow who can do reviews. For now I say
anyone who
>    already maintains atleast one hwmon driver. But thats just a
wild shot better
>    ideas are welcome.
>=20

There are volunteers already. In order to lessen their work you
can require to follow the guidelines (if they got described) by
authors of patches . The fewer simple errors will reduce your work.

Regards,
Krzysztof

----------------------------------------------------
Diane Wei Liang "OKO JADEITU" - =B6wiatowy bestseller, przeczytaj=20
o zderzeniu historii i tera=BCniejszo=B6ci Chin w znakomitej powie=B6ci=20
o mi=B3o=B6ci i przebaczeniu - Kliknij i zobacz:
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fksiazki.wp.pl%2Fkatalog%2Fksiazki%2Fk=
siazka.html%3Fkw%3D36284&sid=1098



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
