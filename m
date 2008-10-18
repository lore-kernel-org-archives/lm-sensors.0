From: naga vamsi krishna talupula <tnvkrishna@hotmail.com>
Date: Sat, 18 Oct 2008 07:07:01 +0000
Subject: Re: [lm-sensors] configure lm-sensors on ubuntu 64bit
Message-Id: <BAY135-W318771DD4B7AC520C165A2C72D0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY135-W51DB5FEF0C7B978E02C484C7320@phx.gbl>
In-Reply-To: <BAY135-W51DB5FEF0C7B978E02C484C7320@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Sorry , my long mail can be frustrating .....
But please consider , because my laptop temperature stays below 50C only I =
if keep it idle ,
even simple browsing makes it shoot to 55-60 C .....
=20

> Hii ,
> This is the first time I am using this mailing list .
> Forgive me if I break any convention used.
>=20
> My problem is that I am not able to configure lm-sensors on my laptop.
> Specs:
>=20
> { Ubuntu 8.04 64bit
> Kernel : 2.6.24-21(generic)
> acer 5920g.
> Please ask if any extra info. is needed . }
>=20
> I followed the method to configure lm-sensors as given here :: http://ubu=
ntuforums.org/showthread.php?t'80 ::.
>=20
> The outputs to terminal are:=20
>=20
> krishna@talupula:~/Downloads$ sudo ./mkdev.sh=20
> [sudo] password for krishna:=20
> /dev/i2c-0
> /dev/i2c-1
> /dev/i2c-2
> /dev/i2c-3
> /dev/i2c-4
> /dev/i2c-5
> /dev/i2c-6
> /dev/i2c-7
> /dev/i2c-8
> /dev/i2c-9
> /dev/i2c-10
> /dev/i2c-11
> /dev/i2c-12
> /dev/i2c-13
> /dev/i2c-14
> /dev/i2c-15
> /dev/i2c-16
> /dev/i2c-17
> /dev/i2c-18
> /dev/i2c-19
> /dev/i2c-20
> /dev/i2c-21
> /dev/i2c-22
> /dev/i2c-23
> /dev/i2c-24
> /dev/i2c-25
> /dev/i2c-26
> /dev/i2c-27
> /dev/i2c-28
> /dev/i2c-29
> /dev/i2c-30
> /dev/i2c-31
>=20
> After sudo sensors-detect
>=20
> The last few lines are (I just pressed enter when ever it asks for (YES/n=
o) or (yes/NO)):
>=20
> #----cut here----
> # Chip drivers
> coretemp
> #----cut here----
>=20
> Then
>=20
> krishna@talupula:~/Downloads$ sudo /etc/init.d/module-init-tools
> [sudo] password for krishna:=20
>  * Loading kernel modules...
> * Loading manual drivers...     [ok]
>=20
> Then added the below four lines to /etc/modprobe.d/local
>=20
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
>=20
> Then added the following 4 lines to /etc/modules
>=20
> #----cut here----
> # Chip drivers
> coretemp
> #----cut here----
>=20
> Now typed sensors in terminal , the output was :
>=20
> krishna@talupula:~/Downloads$ sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +46.0=B0C  (crit =3D +85.0=B0C)                 =20
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +46.0=B0C  (crit =3D +85.0=B0C) =20
>=20
> I THINK THAT THIS IS A WRONG OUTPUT ( I HAVE READ IT IN UBUNTU FORUMS )
>=20
> Could you please help to configure my lm-sensors ........=20
> My laptop is getting too hot and the fans would only start at 60degrees (=
i saw the temperature in the applet in ubuntu panel)
>=20
> Sorry for my long mail ....
> Please ask me if you need amy extra information .
> _________________________________________________________________
> Searching for the best deals on travel? Visit MSN Travel.
> http://in.msn.com/coxandkings
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_________________________________________________________________
Searching for weekend getaways? Try Live.com
http://www.live.com/?scope=3Dvideo&form=3DMICOAL
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
