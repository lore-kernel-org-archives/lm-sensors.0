From: MC Matti <mcmatti17@googlemail.com>
Date: Sun, 06 Dec 2009 15:51:43 +0000
Subject: Re: [lm-sensors] Zotac itx-f sensor i2cdump
Message-Id: <45354d3e0912060751ja76f489s6b27f8449af2a910@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45354d3e0912020755s5c8f2c00rc9c5611c204ae719@mail.gmail.com>
In-Reply-To: <45354d3e0912020755s5c8f2c00rc9c5611c204ae719@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

2009/12/3 Jean Delvare <khali@linux-fr.org>:
> You might as well take your chance and force the lm90 driver to treat
> your chip as a lm86:
>
> modprobe lm90 force_lm86=3D0,0x4c.
>
> Now if your house burn, I'm not responsible, OK? ;)
>
:)
I couldn't resist.
Up to now the MoBo hasn't exploded or catched fire etc...
But it may happen.
Heres what I did:

root@localhost:~# modprobe lm90 force_lm86=3D0,0x4c
root@localhost:~# dmesg | tail -2
[   18.363869] i2c /dev entries driver
[   22.060013] eth0: no IPv6 routers present

root@localhost:~# sensors
lm86-i2c-0-4c
Adapter: SMBus nForce2 adapter at 4d00
temp1:       +44.0=B0C  (low  =3D -40.0=B0C, high =3D +70.0=B0C)
                      (crit =3D +85.0=B0C, hyst =3D +75.0=B0C)
temp2:       +57.9=B0C  (low  =3D -40.0=B0C, high =3D +70.0=B0C)
                      (crit =3D +110.0=B0C, hyst =3D +100.0=B0C)

mcmatti

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
