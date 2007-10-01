From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 01 Oct 2007 18:51:26 +0000
Subject: Re: [lm-sensors] dme1737 error messages
Message-Id: <191fb4ca0710011151j4fe81ban7a61db5e60a5d3d1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Borislav,

Can you please run 'i2cdump 0 0x2e' and post the output?

...juerg


On 9/27/07, Borislav Davitkov <davitkov@gmail.com> wrote:
> Hi,
>
> Thanks for adding support for this chip.
> I have a PTGD1-LA (Puffer) mobo.
> http://h10025.www1.hp.com/ewfrf/wc/genericDocument?cc=3Dus&docname=C00208=
497&lc=3Den#
> It is made by ASUS for HP, so it has the A8000 chip.
>
> After updating my kernel to 2.6.23-rc7 and lm-sensors to 2.10.4 I managed=
 to
> get  it working. However, dmesg  shows these messages:
>
> dmesg| grep dme
> dme1737 0-002e: Optional features: pwm3=3Dyes, pwm5=3Dno, pwm6=3Dno, fan3=
=3Dno,
> fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> dme1737 0-002e: Optional features: pwm3=3Dyes, pwm5=3Dno, pwm6=3Dno, fan3=
=3Dno,
> fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> dme1737 0-002e: Optional features: pwm3=3Dyes, pwm5=3Dno, pwm6=3Dno, fan3=
=3Dno,
> fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> dme1737 0-002e: Read from register 0x46 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x47 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x22 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x48 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x49 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x23 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x4a failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x4b failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x24 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x4c failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x4d failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x99 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x9b failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x9c failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x9a failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x9d failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x9e failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x25 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x4e failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x4f failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x1f failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x26 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x50 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x51 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x1d failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x27 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x52 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x53 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x1e failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x84 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x85 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x86 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x87 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x88 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x28 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x29 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x54 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x55 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x90 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x2a failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x2b failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x56 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x57 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x91 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x2e failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x2f failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x5a failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x5b failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x93 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x30 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x5f failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x5c failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x64 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x31 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x60 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x5d failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x65 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x32 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x61 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x5e failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x66 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x62 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x63 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x67 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x6a failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x68 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x6b failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x69 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x6c failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x6d failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x6e failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x41 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x42 failed! Please report to the driv=
er
> maintainer.
> dme1737 0-002e: Read from register 0x83 failed! Please report to the driv=
er
> maintainer.
>
> So I am reporting to the driver maintainer. :)
> I will be more that happy if I could help in some way.
>
> Regards,
> Borislav
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
