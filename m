From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Sun, 29 Nov 2009 20:32:37 +0000
Subject: Re: [lm-sensors] ADT7490 support
Message-Id: <alpine.DEB.2.00.0911291531110.3257@p34.internal.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463747160-2110862040-1259526757=:3257"
List-Id: <lm-sensors.vger.kernel.org>
References: <64c68f1f0910261310y7a04f31du290bd6ff10dc0c1a@mail.gmail.com>
In-Reply-To: <64c68f1f0910261310y7a04f31du290bd6ff10dc0c1a@mail.gmail.com>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-2110862040-1259526757=:3257
Content-Type: TEXT/PLAIN; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Sun, 29 Nov 2009, Jean Delvare wrote:

> Justin, James,
>
> I have added support for the ADT7490 to the adt7475 driver. My current
> work is available for you to test if you are still interested:
>
> http://khali.linux-fr.org/devel/misc/adt7490/
>
> This is a standalone driver, you'll need a proper build environment
> then type "make" the load the driver.
>
> If you prefer, I can also provide a patch for whatever kernel version
> you're running.
>
> There are still a few configuration cases that aren't properly
> supported, I'll work on that later as my time permits.
>
> --=20
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

Hello,

First test run is as follows:

$ make
   CC [M]  /home/user/a/adt7475.o
   Building modules, stage 2.
   MODPOST 1 modules
   CC      /home/user/a/adt7475.mod.o
   LD [M]  /home/user/a/adt7475.ko
0.44user 0.12system 0:01.73elapsed 32%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (12major+93517minor)pagefaults 0swaps

$ sudo insmod adt7475.ko=20
$

$ sensors
adt7490-i2c-0-2c
Adapter: SMBus I801 adapter at 7000
in0:         +1.52 V  (min =3D  +0.00 V, max =3D  +3.31 V)=20
in1:         +0.87 V  (min =3D  +0.00 V, max =3D  +2.99 V)=20
in2:         +3.31 V  (min =3D  +0.00 V, max =3D  +4.39 V)=20
in3:         +5.12 V  (min =3D  +0.00 V, max =3D  +6.68 V)=20
in4:        +12.01 V  (min =3D  +0.00 V, max =3D +15.69 V)=20
in5:         +2.21 V  (min =3D  +0.00 V, max =3D  +4.48 V)=20
fan1:       1345 RPM  (min =3D    0 RPM)
fan2:       1415 RPM  (min =3D    0 RPM)
fan3:        767 RPM  (min =3D    0 RPM)
fan4:        978 RPM  (min =3D    0 RPM)
temp1:         FAULT  (low  =3D -127.0=B0C, high =3D +127.0=B0C)  ALARM
                       (crit =3D +100.0=B0C, hyst =3D +100.0=B0C)=20
temp2:       +42.2=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
                       (crit =3D +65.0=B0C, hyst =3D +61.0=B0C)=20
temp3:       +46.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
                       (crit =3D +65.0=B0C, hyst =3D +61.0=B0C)

Why does temp1 say fault?  All of the temps in the BIOS report properly.

James, does this happen to you too?

Justin.

---1463747160-2110862040-1259526757=:3257
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
---1463747160-2110862040-1259526757=:3257--
