From: Juerg Haefliger <juergh@gmail.com>
Date: Wed, 12 Feb 2014 09:37:56 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <CADLDEKtFPeA82mwQR5Y56KpOzx-V4wL9CD4jKCUii08Q9eERhQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
In-Reply-To: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Feb 12, 2014 at 9:52 AM, J=FCrgen Fuchsberger <
juergen.fuchsberger@uni-graz.at> wrote:
>
>
>
> On 02/11/2014 08:24 PM, Guenter Roeck wrote:
> > On Tue, Feb 11, 2014 at 10:54:55AM +0100, J=FCrgen Fuchsberger wrote:
> >> Hi,
> >>
> >> On 02/11/2014 08:32 AM, Juerg Haefliger wrote:
> >>> Hi Juergen,
> >>>
> >>> You're likely to get better help by contacting the LM sensors mailing
> >>> list (cc'ed). I've been out of it for a bit.
> >>
> >> Thanks!
> >>>
> >>>
> >>>> Dear Juerg,
> >>>>
> >>>> I keep getting Errors of this kind:
> >>>>
> >>>> Feb 10 09:51:09 wegc203094 kernel: [  156.372033] dme1737 1-002c:
Read
> >>>> from register 0x6d failed! Please report to the driver maintainer.
> >>>> Feb 10 09:53:09 wegc203094 kernel: [  276.472043] dme1737 1-002c:
Read
> >>>> from register 0x69 failed! Please report to the driver maintainer.
> >>>
> >>> Can you post all messages from the driver from the time it was loaded?
> >>
> >> Feb 10 09:48:47 wegc203094 kernel: [    8.368070] i2c i2c-1: Found a
> >> DME1737 chip at 0x2c (rev 0x8a).
> >> Feb 10 09:48:47 wegc203094 kernel: [    8.384103] dme1737 1-002c:
> >> Optional features: pwm3=3Dno, pwm5=3Dno, pwm6=3Dno, fan3=3Dno, fan4=3D=
no,
fan5=3Dno,
> >> fan6=3Dno.
> >> Feb 10 09:4
> >>
> >>
> >>> What's the model of the machine you're using?
> >> Hmm, unfortunately I don't know. Is there a way to find out without
> >> opening the server? (I mean by sw-tools?)
> >>
> > If this is a PC, "sudo dmidecode" might tell you a lot.
> >
> OK, thanks. Looks like it's a Tyan S2932/S2932-E/S2932-SI board. I
> attached the dmidecode info.
>
> >>> What do you get when running the sensors-detect script?
> >>
> >> ~ % sensors
> >>
> >>
> > sensors-detect, not sensors ;-).
> >
> > Anyway, can you provide the output of "sudo i2cdump -y -f 1 0x2c" ?
> > That might actually help more.
>
> Debian package lm-sensors does not provide i2cdump so I did
sensors-detect:

i2cdump is provided by the i2c-tools package.

...Juerg


> Driver `to-be-written':
>   * ISA bus, address 0xca8
>     Chip `IPMI BMC KCS' (confidence: 8)
>
> Driver `dme1737':
>   * Bus `SMBus nForce2 adapter at 2e00'
>     Busdriver `i2c_nforce2', I2C address 0x2c
>     Chip `dme1737' (confidence: 6)
>
> Driver `lm85':
>   * Bus `SMBus nForce2 adapter at 2e00'
>     Busdriver `i2c_nforce2', I2C address 0x2d
>     Chip `emc6d103' (confidence: 6)
>   * Bus `SMBus nForce2 adapter at 2e00'
>     Busdriver `i2c_nforce2', I2C address 0x2e
>     Chip `emc6d103' (confidence: 6)
>
> Note: there is no driver for IPMI BMC KCS yet.
> Check http://www.lm-sensors.org/wiki/Devices for updates.
>
> To load everything that is needed, add this to /etc/modules:
> #----cut here----
> # Chip drivers
> dme1737
> lm85
> #----cut here----
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones!
>
> Do you want to add these lines automatically to /etc/modules? (yes/NO)
>
> Unloading i2c-dev... OK
> Unloading cpuid... OK
>
>
>
> >
> > Also, are the errors persistent or sporadic ?
> >
> Persistent, current messages contains 703 error lines.
>
> Juergen.
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
