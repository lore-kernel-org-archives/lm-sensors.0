From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Feb 2014 19:24:36 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <20140211192436.GA16188@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
In-Reply-To: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Feb 11, 2014 at 10:54:55AM +0100, J=FCrgen Fuchsberger wrote:
> Hi,
>=20
> On 02/11/2014 08:32 AM, Juerg Haefliger wrote:
> > Hi Juergen,
> >=20
> > You're likely to get better help by contacting the LM sensors mailing
> > list (cc'ed). I've been out of it for a bit.
>=20
> Thanks!
> >=20
> >=20
> >> Dear Juerg,
> >>
> >> I keep getting Errors of this kind:
> >>
> >> Feb 10 09:51:09 wegc203094 kernel: [  156.372033] dme1737 1-002c: Read
> >> from register 0x6d failed! Please report to the driver maintainer.
> >> Feb 10 09:53:09 wegc203094 kernel: [  276.472043] dme1737 1-002c: Read
> >> from register 0x69 failed! Please report to the driver maintainer.
> >=20
> > Can you post all messages from the driver from the time it was loaded?
>=20
> Feb 10 09:48:47 wegc203094 kernel: [    8.368070] i2c i2c-1: Found a
> DME1737 chip at 0x2c (rev 0x8a).
> Feb 10 09:48:47 wegc203094 kernel: [    8.384103] dme1737 1-002c:
> Optional features: pwm3=3Dno, pwm5=3Dno, pwm6=3Dno, fan3=3Dno, fan4=3Dno,=
 fan5=3Dno,
> fan6=3Dno.
> Feb 10 09:4
>=20
>=20
> > What's the model of the machine you're using?
> Hmm, unfortunately I don't know. Is there a way to find out without
> opening the server? (I mean by sw-tools?)
>=20
If this is a PC, "sudo dmidecode" might tell you a lot.

> > What do you get when running the sensors-detect script?
>=20
> ~ % sensors
>=20
>=20
sensors-detect, not sensors ;-).

Anyway, can you provide the output of "sudo i2cdump -y -f 1 0x2c" ?
That might actually help more.

Also, are the errors persistent or sporadic ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
