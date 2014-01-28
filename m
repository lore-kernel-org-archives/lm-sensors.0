From: "Frederic @ GMX" <freederic@gmx.com>
Date: Tue, 28 Jan 2014 10:20:44 +0000
Subject: Re: [lm-sensors] FanControl can not auto"load"
Message-Id: <1390904444.3506.43.camel@X4-955>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-TZlkjdqa53SicXJiDPuR"
List-Id: <lm-sensors.vger.kernel.org>
References: <1390846853.4041.38.camel@X4-955>
In-Reply-To: <1390846853.4041.38.camel@X4-955>
To: lm-sensors@vger.kernel.org


--=-TZlkjdqa53SicXJiDPuR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean.

Content de te retrouver en ligne... depuis 2008

Le mardi 28 janvier 2014 =C3=A0 08:12 +0100, Jean Delvare a =C3=A9crit :
> Hi Frederic,
>=20
> On Mon, 27 Jan 2014 19:20:53 +0100, Frederic @ GMX wrote:
> > As request, here is some system information :
> > ...//...
> >=20
> >       * Motherboard vendor and model :=20
> >=20
> > Gigabyte GA-880GM-UD2H=20
> >=20
> >       * Lm_sensors and kernel versions :=20
> >=20
> > LM v 3.3.2 (from the Debian deposite) / Kernel 3.2.0-4-amd64
> >=20
> >       * The output of sensors :=20
> >=20
> > frederic@X4-955:~$ sensors
> > k10temp-pci-00c3
> > Adapter: PCI adapter
> > AM10 Core:    +29.9=C2=B0C  (high =3D +70.0=C2=B0C)
> >                        (crit =3D +79.0=C2=B0C, hyst =3D +77.0=C2=B0C)
> >=20
> > it8720-isa-0228
> > Adapter: ISA adapter
> > Vcore:        +1.02 V  (min =3D  +0.80 V, max =3D  +1.50 V)
> > Vram:         +1.60 V  (min =3D  +1.52 V, max =3D  +1.68 V)
> > +3.3V:        +2.83 V  (min =3D  +3.14 V, max =3D  +3.47 V)  ALARM
> > +5V:          +5.00 V  (min =3D  +4.76 V, max =3D  +5.24 V)
> > +12V:        +12.17 V  (min =3D +11.40 V, max =3D +12.62 V)
> > +5V_SNB:      +4.82 V  (min =3D  +0.00 V, max =3D  +6.68 V)
> > Vbat:         +3.28 V =20
> > CPU Fan:     1569 RPM  (min =3D  500 RPM)
> > SYS Fan:     1445 RPM  (min =3D  700 RPM)
> > CPU Temp:     +27.0=C2=B0C  (low  =3D +20.0=C2=B0C, high =3D +70.0=C2=
=B0C)  sensor =3D
> > thermistor
> > MB Temp:      +28.0=C2=B0C  (low  =3D +20.0=C2=B0C, high =3D +60.0=C2=
=B0C)  sensor =3D
> > thermal diode
> > NBr Temp:     +27.0=C2=B0C  (low  =3D +20.0=C2=B0C, high =3D +60.0=C2=
=B0C)  sensor =3D
> > thermistor
> > intrusion0:  OK
> >=20
> > (...)
> > So, the problem is Fancontrol don't want to load on the boot sequence.
> >=20
> > What I done ?
> >=20
> > On begining all was running fine. Fancontrol adjust my fans.
>=20
> Did it work reliably multiple times?

Yes. it was working since ... 2008 when we (you) help me to setup
lm-sensors
I stay on debian and update/upgrade from debian 5.x to 7.3 now without
any trouble.


> > I attemps to update lm-sensors, not from the debian deposite,but from
> > the download area , here.
>=20
> Why did you want to update in the first place? What problem were you
> trying to solve?
A stupid raison :(=20
1 - I change my CPU Cooler from a Cooler Master Hyper TX3 to a Scythe
Mugen 3=20
2 - I would like change my CPU to jump to a AMD FX series ... with a new mo=
therboard.
3 - I want make a lm-sensors config to check/remember the links between
sensors componants, parameters and fans
So, as I beleived I can change this config and swith back with my
previous backed-up config ... it was a dream.
I forgot the manual install of the downloaded package was not the same
way of an "official debian package"

> Distributions have their own way to integrate lm-sensors in the system,
> so even if you have to update, it's better to try and find a package
> for your distribution.
Yes, I has forgot how was hard to setup few year ago.


> Did you uninstall the Debian package at this point?
Now, i remove the downloaded package and use debian packages :
lm-sensors & fancontrol.


> > I follow exactly word by word the process describe in the INSTALL file
> > include in the tar file.
> > Also, I install the flex and bison packages.
> > then, as root, I run :
> >=20
> >      1. make install
> >      2. make user_install (I don't remember where I found/read this
> >         command,... maybe in the makefile itself)
>=20
> "make install" is sufficient, it calls target "user_install" internally
> but the user doesn't have to know that.
good to now for the futur on any other "make"

> > No error on these commands.
> > But, fancontrol don't drive fans.
> > So, I expect if I remove/uninstall this release, everything will be bac=
k
> > fine :( :(
> >=20
> > But NO !
> >=20
> > I deleted the=20
> > /usr/local/lib
> > /usr/local/bin
> > /usr/local/sbin
> > /usr/local/ and all other
>=20
> If you had compiled other packages from source, you may have deleted
> unrelated files which is definitely not a good idea.
It was the first time I run a "make"

> > Nothing changed after reboot ; fan stay on MAX !
> >=20
> > So, I restaure previous directories and run :
> >=20
> >      1. make user_uninstall
>=20
> Again this target is not documented. "make uninstall" is enough.
>=20
> > Next reboot, same situation.
> >=20
> > So, I run Synaptic (which I always use for install/remove/update
> > packages) and I remove fancontrol and lm-sensors.
> > Then reboot and I install back the both packages from Synaptic.
> > I run sensors-detect, pwmconfig. All run fine without error.
> >=20
> > I run fancontrol as root. Fancontrol drive my fans.
> > But on reboot, fancontrol don't start.
> > Before all the operation, I never change manualy something for run
> > fancontrol on boot.
>=20
> FWIW I can't see how anything you did may have influenced the starting
> of fancontrol at boot time. lm-sensors installs to /usr/local by
> default, it wouldn't have messed with your system configuration.
no comment ;)

> > What I have to check/correct ?
>=20
> The way services are started at boot time is distribution specific. I
> am not familiar with Debian so I can't really help there.
I had some doubts about the services.=20
On the donwloaded installation where is set the service startup ?
May be there is always the link available and the re-install don't
update this informations ?
I have to question Google about service on debian distri.

>  I can only provide generic advice:
> * Check that you don't have both /etc/sensors.conf
>   and /etc/sensors3.conf.
Done : I have only sensors3.conf
but, remember, I start fancontrol manualy from a terminal and it run
fine even the terminal is open.

> * Check that you don't have both /etc/modprobe.d/lm_sensors.conf
>   and /etc/modprobe.d/lm_sensors.
I have none of them

> * Check if the fancontrol daemon is running:
>   # ps -ef | grep fancontrol
  frederic@X4-955:~$ ps -ef | grep fancontrol
  frederic  4355  4312  0 10:56 pts/1    00:00:00 grep fancontrol

!!! So it's mean that fancontrol run ???
but fan are full speed.
I run a terminal with :
root@X4-955:/home/frederic# /etc/init.d/fancontrol start
[ ok ] Starting fan speed regulator: fancontrol.

then fan speed slow down !



> * Check the system logs for information:
>   # grep fancontrol /var/log/*
> * If any log file has fancontrol-related messages, open it to get all
>   the details.
>=20
root@X4-955:/home/frederic# grep fancontrol /var/log/*
a lot of lines=20
/var/log/dpkg.log:2014-01-25 14:36:34 status installed fancontrol:all
1:3.3.2-2+deb7u1
*file attached*
I install for update via distri
as no update, I remove completly and install it back.
Install bison, flex and lot of "anything"
I don't see any information about the "manual install of the lastest
downloaded version.

thanks for you support.





--=-TZlkjdqa53SicXJiDPuR
Content-Disposition: attachment; filename="dpkg.log"
Content-Type: text/x-log; name="dpkg.log"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


2014-01-25 14:36:34 startup packages remove
2014-01-25 14:36:34 status installed fancontrol:all 1:3.3.2-2+deb7u1
2014-01-25 14:36:39 remove fancontrol:all 1:3.3.2-2+deb7u1 <aucun>
2014-01-25 14:36:39 status half-configured fancontrol:all 1:3.3.2-2+deb7u1
2014-01-25 14:36:39 status half-installed fancontrol:all 1:3.3.2-2+deb7u1
2014-01-25 14:36:40 status triggers-pending man-db:amd64 2.6.2-1
2014-01-25 14:36:40 status half-installed fancontrol:all 1:3.3.2-2+deb7u1
2014-01-25 14:36:40 status config-files fancontrol:all 1:3.3.2-2+deb7u1
2014-01-25 14:36:40 status config-files fancontrol:all 1:3.3.2-2+deb7u1
2014-01-25 14:36:40 trigproc man-db:amd64 2.6.2-1 <aucun>
2014-01-25 14:36:40 status half-configured man-db:amd64 2.6.2-1
2014-01-25 14:36:42 status installed man-db:amd64 2.6.2-1
2014-01-26 11:16:05 startup packages purge
2014-01-26 11:16:05 status installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:16:10 remove lm-sensors:amd64 1:3.3.2-2+deb7u1 <aucun>
2014-01-26 11:16:10 status half-configured lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:16:10 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:16:10 status triggers-pending man-db:amd64 2.6.2-1
2014-01-26 11:16:10 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:16:11 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:16:11 purge lm-sensors:amd64 1:3.3.2-2+deb7u1 <aucun>
2014-01-26 11:16:11 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:16:11 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:16:11 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:16:11 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:16:11 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:16:11 status not-installed lm-sensors:amd64 <aucun>
2014-01-26 11:16:11 trigproc man-db:amd64 2.6.2-1 <aucun>
2014-01-26 11:16:11 status half-configured man-db:amd64 2.6.2-1
2014-01-26 11:16:14 status installed man-db:amd64 2.6.2-1
2014-01-26 11:18:38 startup archives unpack
2014-01-26 11:18:38 install libsysfs2:amd64 <aucun> 2.1.0+repack-2
2014-01-26 11:18:38 status half-installed libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:18:38 status unpacked libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:18:38 status unpacked libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:18:38 install libsysfs-dev:amd64 <aucun> 2.1.0+repack-2
2014-01-26 11:18:38 status half-installed libsysfs-dev:amd64 2.1.0+repack-2
2014-01-26 11:18:39 status unpacked libsysfs-dev:amd64 2.1.0+repack-2
2014-01-26 11:18:39 status unpacked libsysfs-dev:amd64 2.1.0+repack-2
2014-01-26 11:18:40 startup packages configure
2014-01-26 11:18:40 configure libsysfs2:amd64 2.1.0+repack-2 <aucun>
2014-01-26 11:18:40 status unpacked libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:18:40 status half-configured libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:18:40 status installed libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:18:40 configure libsysfs-dev:amd64 2.1.0+repack-2 <aucun>
2014-01-26 11:18:40 status unpacked libsysfs-dev:amd64 2.1.0+repack-2
2014-01-26 11:18:40 status half-configured libsysfs-dev:amd64 2.1.0+repack-2
2014-01-26 11:18:40 status installed libsysfs-dev:amd64 2.1.0+repack-2
2014-01-26 11:22:40 startup archives unpack
2014-01-26 11:22:40 install libbison-dev:amd64 <aucun> 1:2.5.dfsg-2.1
2014-01-26 11:22:40 status half-installed libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 11:22:41 status unpacked libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 11:22:41 status unpacked libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 11:22:41 install bison:amd64 <aucun> 1:2.5.dfsg-2.1
2014-01-26 11:22:41 status half-installed bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:22:41 status triggers-pending man-db:amd64 2.6.2-1
2014-01-26 11:22:41 status half-installed bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:22:42 status unpacked bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:22:42 status unpacked bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:22:42 trigproc man-db:amd64 2.6.2-1 2.6.2-1
2014-01-26 11:22:42 status half-configured man-db:amd64 2.6.2-1
2014-01-26 11:22:43 status installed man-db:amd64 2.6.2-1
2014-01-26 11:22:44 startup packages configure
2014-01-26 11:22:44 configure libbison-dev:amd64 1:2.5.dfsg-2.1 <aucun>
2014-01-26 11:22:44 status unpacked libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 11:22:44 status half-configured libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 11:22:44 status installed libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 11:22:44 configure bison:amd64 1:2.5.dfsg-2.1 <aucun>
2014-01-26 11:22:44 status unpacked bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:22:44 status half-configured bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:22:45 status installed bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:23:15 startup archives unpack
2014-01-26 11:23:15 install flex:amd64 <aucun> 2.5.35-10.1
2014-01-26 11:23:15 status half-installed flex:amd64 2.5.35-10.1
2014-01-26 11:23:15 status triggers-pending install-info:amd64 4.13a.dfsg.1-10
2014-01-26 11:23:15 status half-installed flex:amd64 2.5.35-10.1
2014-01-26 11:23:15 status triggers-pending man-db:amd64 2.6.2-1
2014-01-26 11:23:15 status half-installed flex:amd64 2.5.35-10.1
2014-01-26 11:23:15 status unpacked flex:amd64 2.5.35-10.1
2014-01-26 11:23:15 status unpacked flex:amd64 2.5.35-10.1
2014-01-26 11:23:16 trigproc install-info:amd64 4.13a.dfsg.1-10 4.13a.dfsg.1-10
2014-01-26 11:23:16 status half-configured install-info:amd64 4.13a.dfsg.1-10
2014-01-26 11:23:16 status installed install-info:amd64 4.13a.dfsg.1-10
2014-01-26 11:23:16 trigproc man-db:amd64 2.6.2-1 2.6.2-1
2014-01-26 11:23:16 status half-configured man-db:amd64 2.6.2-1
2014-01-26 11:23:17 status installed man-db:amd64 2.6.2-1
2014-01-26 11:23:18 startup packages configure
2014-01-26 11:23:18 configure flex:amd64 2.5.35-10.1 <aucun>
2014-01-26 11:23:18 status unpacked flex:amd64 2.5.35-10.1
2014-01-26 11:23:18 status half-configured flex:amd64 2.5.35-10.1
2014-01-26 11:23:18 status installed flex:amd64 2.5.35-10.1
2014-01-26 11:32:40 startup archives unpack
2014-01-26 11:32:46 install lm-sensors:amd64 <aucun> 1:3.3.2-2+deb7u1
2014-01-26 11:32:46 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:32:46 status triggers-pending man-db:amd64 2.6.2-1
2014-01-26 11:32:47 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:32:47 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:32:47 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:32:47 trigproc man-db:amd64 2.6.2-1 2.6.2-1
2014-01-26 11:32:47 status half-configured man-db:amd64 2.6.2-1
2014-01-26 11:32:50 status installed man-db:amd64 2.6.2-1
2014-01-26 11:32:51 startup packages configure
2014-01-26 11:32:51 configure lm-sensors:amd64 1:3.3.2-2+deb7u1 <aucun>
2014-01-26 11:32:51 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:32:51 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:32:51 status half-configured lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:32:51 status installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:33:21 startup packages purge
2014-01-26 11:33:21 status installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:33:21 remove lm-sensors:amd64 1:3.3.2-2+deb7u1 <aucun>
2014-01-26 11:33:21 status half-configured lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:33:21 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:33:22 status triggers-pending man-db:amd64 2.6.2-1
2014-01-26 11:33:22 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:33:22 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:33:22 purge lm-sensors:amd64 1:3.3.2-2+deb7u1 <aucun>
2014-01-26 11:33:22 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:33:22 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:33:22 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:33:22 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:33:22 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:33:22 status not-installed lm-sensors:amd64 <aucun>
2014-01-26 11:33:22 trigproc man-db:amd64 2.6.2-1 <aucun>
2014-01-26 11:33:22 status half-configured man-db:amd64 2.6.2-1
2014-01-26 11:33:24 status installed man-db:amd64 2.6.2-1
2014-01-26 11:39:54 startup packages purge
2014-01-26 11:39:54 status installed bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:39:54 remove bison:amd64 1:2.5.dfsg-2.1 <aucun>
2014-01-26 11:39:54 status half-configured bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:39:54 status half-installed bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:39:54 status triggers-pending man-db:amd64 2.6.2-1
2014-01-26 11:39:54 status half-installed bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:39:55 status config-files bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:39:55 status config-files bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:39:55 status config-files bison:amd64 1:2.5.dfsg-2.1
2014-01-26 11:39:55 status not-installed bison:amd64 <aucun>
2014-01-26 11:39:55 status installed libsysfs-dev:amd64 2.1.0+repack-2
2014-01-26 11:39:55 remove libsysfs-dev:amd64 2.1.0+repack-2 <aucun>
2014-01-26 11:39:55 status half-configured libsysfs-dev:amd64 2.1.0+repack-2
2014-01-26 11:39:55 status half-installed libsysfs-dev:amd64 2.1.0+repack-2
2014-01-26 11:39:55 status config-files libsysfs-dev:amd64 2.1.0+repack-2
2014-01-26 11:39:55 status config-files libsysfs-dev:amd64 2.1.0+repack-2
2014-01-26 11:39:55 status config-files libsysfs-dev:amd64 2.1.0+repack-2
2014-01-26 11:39:55 status not-installed libsysfs-dev:amd64 <aucun>
2014-01-26 11:39:56 status installed libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:39:56 remove libsysfs2:amd64 2.1.0+repack-2 <aucun>
2014-01-26 11:39:56 status half-configured libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:39:56 status half-installed libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:39:56 status config-files libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:39:56 purge libsysfs2:amd64 2.1.0+repack-2 <aucun>
2014-01-26 11:39:56 status config-files libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:39:56 status config-files libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:39:56 status config-files libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:39:56 status config-files libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:39:56 status config-files libsysfs2:amd64 2.1.0+repack-2
2014-01-26 11:39:56 status not-installed libsysfs2:amd64 <aucun>
2014-01-26 11:39:56 trigproc man-db:amd64 2.6.2-1 <aucun>
2014-01-26 11:39:56 status half-configured man-db:amd64 2.6.2-1
2014-01-26 11:39:58 status installed man-db:amd64 2.6.2-1
2014-01-26 11:40:47 startup packages remove
2014-01-26 11:40:47 status installed libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 11:40:47 remove libbison-dev:amd64 1:2.5.dfsg-2.1 <aucun>
2014-01-26 11:40:47 status half-configured libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 11:40:47 status half-installed libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 11:40:47 status config-files libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 11:40:47 status config-files libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 11:40:47 status config-files libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 11:40:47 status not-installed libbison-dev:amd64 <aucun>
2014-01-26 11:40:47 status installed libfreerdp-plugins-standard:amd64 1.0.1-1.1+deb7u2
2014-01-26 11:40:47 remove libfreerdp-plugins-standard:amd64 1.0.1-1.1+deb7u2 <aucun>
2014-01-26 11:40:47 status half-configured libfreerdp-plugins-standard:amd64 1.0.1-1.1+deb7u2
2014-01-26 11:40:47 status half-installed libfreerdp-plugins-standard:amd64 1.0.1-1.1+deb7u2
2014-01-26 11:40:48 status config-files libfreerdp-plugins-standard:amd64 1.0.1-1.1+deb7u2
2014-01-26 11:40:48 status config-files libfreerdp-plugins-standard:amd64 1.0.1-1.1+deb7u2
2014-01-26 11:40:48 status config-files libfreerdp-plugins-standard:amd64 1.0.1-1.1+deb7u2
2014-01-26 11:40:48 status not-installed libfreerdp-plugins-standard:amd64 <aucun>
2014-01-26 11:40:48 status installed libfreerdp1:amd64 1.0.1-1.1+deb7u2
2014-01-26 11:40:48 remove libfreerdp1:amd64 1.0.1-1.1+deb7u2 <aucun>
2014-01-26 11:40:48 status half-configured libfreerdp1:amd64 1.0.1-1.1+deb7u2
2014-01-26 11:40:48 status half-installed libfreerdp1:amd64 1.0.1-1.1+deb7u2
2014-01-26 11:40:48 status config-files libfreerdp1:amd64 1.0.1-1.1+deb7u2
2014-01-26 11:40:48 status config-files libfreerdp1:amd64 1.0.1-1.1+deb7u2
2014-01-26 11:40:48 status installed libssh-4:amd64 0.5.4-1
2014-01-26 11:40:48 remove libssh-4:amd64 0.5.4-1 <aucun>
2014-01-26 11:40:48 status half-configured libssh-4:amd64 0.5.4-1
2014-01-26 11:40:48 status half-installed libssh-4:amd64 0.5.4-1
2014-01-26 11:40:49 status config-files libssh-4:amd64 0.5.4-1
2014-01-26 11:40:49 status config-files libssh-4:amd64 0.5.4-1
2014-01-26 11:40:49 status installed python-gpgme:amd64 0.2-3
2014-01-26 11:40:49 remove python-gpgme:amd64 0.2-3 <aucun>
2014-01-26 11:40:49 status half-configured python-gpgme:amd64 0.2-3
2014-01-26 11:40:49 status half-installed python-gpgme:amd64 0.2-3
2014-01-26 11:40:49 status config-files python-gpgme:amd64 0.2-3
2014-01-26 11:40:49 status config-files python-gpgme:amd64 0.2-3
2014-01-26 11:40:50 status config-files python-gpgme:amd64 0.2-3
2014-01-26 11:40:50 status not-installed python-gpgme:amd64 <aucun>
2014-01-26 11:49:16 startup packages remove
2014-01-26 11:49:16 status installed flex:amd64 2.5.35-10.1
2014-01-26 11:49:21 remove flex:amd64 2.5.35-10.1 <aucun>
2014-01-26 11:49:21 status half-configured flex:amd64 2.5.35-10.1
2014-01-26 11:49:21 status half-installed flex:amd64 2.5.35-10.1
2014-01-26 11:49:21 status triggers-pending man-db:amd64 2.6.2-1
2014-01-26 11:49:22 status half-installed flex:amd64 2.5.35-10.1
2014-01-26 11:49:22 status triggers-pending install-info:amd64 4.13a.dfsg.1-10
2014-01-26 11:49:22 status half-installed flex:amd64 2.5.35-10.1
2014-01-26 11:49:22 status config-files flex:amd64 2.5.35-10.1
2014-01-26 11:49:22 status config-files flex:amd64 2.5.35-10.1
2014-01-26 11:49:22 status config-files flex:amd64 2.5.35-10.1
2014-01-26 11:49:22 status not-installed flex:amd64 <aucun>
2014-01-26 11:49:22 trigproc man-db:amd64 2.6.2-1 <aucun>
2014-01-26 11:49:22 status half-configured man-db:amd64 2.6.2-1
2014-01-26 11:49:24 status installed man-db:amd64 2.6.2-1
2014-01-26 11:49:24 trigproc install-info:amd64 4.13a.dfsg.1-10 <aucun>
2014-01-26 11:49:24 status half-configured install-info:amd64 4.13a.dfsg.1-10
2014-01-26 11:49:25 status installed install-info:amd64 4.13a.dfsg.1-10
2014-01-26 11:56:57 startup archives unpack
2014-01-26 11:57:02 install lm-sensors:amd64 <aucun> 1:3.3.2-2+deb7u1
2014-01-26 11:57:02 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:57:02 status triggers-pending man-db:amd64 2.6.2-1
2014-01-26 11:57:02 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:57:02 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:57:02 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:57:02 trigproc man-db:amd64 2.6.2-1 2.6.2-1
2014-01-26 11:57:02 status half-configured man-db:amd64 2.6.2-1
2014-01-26 11:57:05 status installed man-db:amd64 2.6.2-1
2014-01-26 11:57:06 startup packages configure
2014-01-26 11:57:06 configure lm-sensors:amd64 1:3.3.2-2+deb7u1 <aucun>
2014-01-26 11:57:06 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:57:06 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:57:06 status half-configured lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 11:57:07 status installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:07:16 startup packages purge
2014-01-26 12:07:16 status installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:07:21 remove lm-sensors:amd64 1:3.3.2-2+deb7u1 <aucun>
2014-01-26 12:07:21 status half-configured lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:07:21 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:07:21 status triggers-pending man-db:amd64 2.6.2-1
2014-01-26 12:07:21 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:07:21 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:07:21 purge lm-sensors:amd64 1:3.3.2-2+deb7u1 <aucun>
2014-01-26 12:07:21 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:07:22 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:07:22 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:07:22 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:07:22 status config-files lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:07:22 status not-installed lm-sensors:amd64 <aucun>
2014-01-26 12:07:22 trigproc man-db:amd64 2.6.2-1 <aucun>
2014-01-26 12:07:22 status half-configured man-db:amd64 2.6.2-1
2014-01-26 12:07:26 status installed man-db:amd64 2.6.2-1
2014-01-26 12:21:48 startup archives unpack
2014-01-26 12:21:48 install flex:amd64 <aucun> 2.5.35-10.1
2014-01-26 12:21:48 status half-installed flex:amd64 2.5.35-10.1
2014-01-26 12:21:48 status triggers-pending install-info:amd64 4.13a.dfsg.1-10
2014-01-26 12:21:48 status half-installed flex:amd64 2.5.35-10.1
2014-01-26 12:21:48 status triggers-pending man-db:amd64 2.6.2-1
2014-01-26 12:21:48 status half-installed flex:amd64 2.5.35-10.1
2014-01-26 12:21:49 status unpacked flex:amd64 2.5.35-10.1
2014-01-26 12:21:49 status unpacked flex:amd64 2.5.35-10.1
2014-01-26 12:21:49 install libbison-dev:amd64 <aucun> 1:2.5.dfsg-2.1
2014-01-26 12:21:49 status half-installed libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 12:21:49 status unpacked libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 12:21:49 status unpacked libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 12:21:49 install bison:amd64 <aucun> 1:2.5.dfsg-2.1
2014-01-26 12:21:49 status half-installed bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:21:50 status half-installed bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:21:50 status unpacked bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:21:50 status unpacked bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:21:50 trigproc install-info:amd64 4.13a.dfsg.1-10 4.13a.dfsg.1-10
2014-01-26 12:21:50 status half-configured install-info:amd64 4.13a.dfsg.1-10
2014-01-26 12:21:51 status installed install-info:amd64 4.13a.dfsg.1-10
2014-01-26 12:21:51 trigproc man-db:amd64 2.6.2-1 2.6.2-1
2014-01-26 12:21:51 status half-configured man-db:amd64 2.6.2-1
2014-01-26 12:21:52 status installed man-db:amd64 2.6.2-1
2014-01-26 12:21:53 startup packages configure
2014-01-26 12:21:53 configure flex:amd64 2.5.35-10.1 <aucun>
2014-01-26 12:21:53 status unpacked flex:amd64 2.5.35-10.1
2014-01-26 12:21:53 status half-configured flex:amd64 2.5.35-10.1
2014-01-26 12:21:53 status installed flex:amd64 2.5.35-10.1
2014-01-26 12:21:53 configure libbison-dev:amd64 1:2.5.dfsg-2.1 <aucun>
2014-01-26 12:21:53 status unpacked libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 12:21:53 status half-configured libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 12:21:53 status installed libbison-dev:amd64 1:2.5.dfsg-2.1
2014-01-26 12:21:53 configure bison:amd64 1:2.5.dfsg-2.1 <aucun>
2014-01-26 12:21:53 status unpacked bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:21:53 status half-configured bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:21:54 status installed bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:26:38 startup packages remove
2014-01-26 12:26:38 status installed bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:26:38 remove bison:amd64 1:2.5.dfsg-2.1 <aucun>
2014-01-26 12:26:38 status half-configured bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:26:39 status half-installed bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:26:39 status triggers-pending man-db:amd64 2.6.2-1
2014-01-26 12:26:39 status half-installed bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:26:39 status config-files bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:26:39 status config-files bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:26:39 status config-files bison:amd64 1:2.5.dfsg-2.1
2014-01-26 12:26:39 status not-installed bison:amd64 <aucun>
2014-01-26 12:26:39 status installed flex:amd64 2.5.35-10.1
2014-01-26 12:26:39 remove flex:amd64 2.5.35-10.1 <aucun>
2014-01-26 12:26:39 status half-configured flex:amd64 2.5.35-10.1
2014-01-26 12:26:39 status half-installed flex:amd64 2.5.35-10.1
2014-01-26 12:26:39 status half-installed flex:amd64 2.5.35-10.1
2014-01-26 12:26:39 status triggers-pending install-info:amd64 4.13a.dfsg.1-10
2014-01-26 12:26:39 status half-installed flex:amd64 2.5.35-10.1
2014-01-26 12:26:40 status config-files flex:amd64 2.5.35-10.1
2014-01-26 12:26:40 status config-files flex:amd64 2.5.35-10.1
2014-01-26 12:26:40 status config-files flex:amd64 2.5.35-10.1
2014-01-26 12:26:40 status not-installed flex:amd64 <aucun>
2014-01-26 12:26:40 trigproc man-db:amd64 2.6.2-1 <aucun>
2014-01-26 12:26:40 status half-configured man-db:amd64 2.6.2-1
2014-01-26 12:26:41 status installed man-db:amd64 2.6.2-1
2014-01-26 12:26:41 trigproc install-info:amd64 4.13a.dfsg.1-10 <aucun>
2014-01-26 12:26:41 status half-configured install-info:amd64 4.13a.dfsg.1-10
2014-01-26 12:26:42 status installed install-info:amd64 4.13a.dfsg.1-10
2014-01-26 12:27:02 startup archives unpack
2014-01-26 12:27:02 install lm-sensors:amd64 <aucun> 1:3.3.2-2+deb7u1
2014-01-26 12:27:02 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:27:02 status triggers-pending man-db:amd64 2.6.2-1
2014-01-26 12:27:02 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:27:02 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:27:03 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:27:03 trigproc man-db:amd64 2.6.2-1 2.6.2-1
2014-01-26 12:27:03 status half-configured man-db:amd64 2.6.2-1
2014-01-26 12:27:04 status installed man-db:amd64 2.6.2-1
2014-01-26 12:27:05 startup packages configure
2014-01-26 12:27:05 configure lm-sensors:amd64 1:3.3.2-2+deb7u1 <aucun>
2014-01-26 12:27:05 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:27:05 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:27:05 status half-configured lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-26 12:27:05 status installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-27 14:02:29 startup archives unpack
2014-01-27 14:02:35 install fancontrol:all 1:3.3.2-2+deb7u1 1:3.3.2-2+deb7u1
2014-01-27 14:02:35 status half-installed fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:02:35 status triggers-pending man-db:amd64 2.6.2-1
2014-01-27 14:02:35 status half-installed fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:02:35 status unpacked fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:02:35 status unpacked fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:02:35 trigproc man-db:amd64 2.6.2-1 2.6.2-1
2014-01-27 14:02:35 status half-configured man-db:amd64 2.6.2-1
2014-01-27 14:02:37 status installed man-db:amd64 2.6.2-1
2014-01-27 14:02:38 startup packages configure
2014-01-27 14:02:38 configure fancontrol:all 1:3.3.2-2+deb7u1 <aucun>
2014-01-27 14:02:38 status unpacked fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:02:38 status unpacked fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:02:38 status half-configured fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:02:38 status installed fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:30:11 startup archives unpack
2014-01-27 14:30:16 upgrade fancontrol:all 1:3.3.2-2+deb7u1 1:3.3.2-2+deb7u1
2014-01-27 14:30:16 status half-configured fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:30:16 status unpacked fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:30:16 status half-installed fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:30:16 status triggers-pending man-db:amd64 2.6.2-1
2014-01-27 14:30:16 status half-installed fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:30:16 status half-installed fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:30:16 status unpacked fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:30:16 status unpacked fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:30:17 upgrade lm-sensors:amd64 1:3.3.2-2+deb7u1 1:3.3.2-2+deb7u1
2014-01-27 14:30:17 status half-configured lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-27 14:30:17 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-27 14:30:17 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-27 14:30:17 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-27 14:30:17 status half-installed lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-27 14:30:17 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-27 14:30:17 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-27 14:30:17 trigproc man-db:amd64 2.6.2-1 2.6.2-1
2014-01-27 14:30:17 status half-configured man-db:amd64 2.6.2-1
2014-01-27 14:30:20 status installed man-db:amd64 2.6.2-1
2014-01-27 14:30:21 startup packages configure
2014-01-27 14:30:21 configure fancontrol:all 1:3.3.2-2+deb7u1 <aucun>
2014-01-27 14:30:21 status unpacked fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:30:21 status unpacked fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:30:21 status half-configured fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:30:21 status installed fancontrol:all 1:3.3.2-2+deb7u1
2014-01-27 14:30:21 configure lm-sensors:amd64 1:3.3.2-2+deb7u1 <aucun>
2014-01-27 14:30:21 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-27 14:30:21 status unpacked lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-27 14:30:21 status half-configured lm-sensors:amd64 1:3.3.2-2+deb7u1
2014-01-27 14:30:22 status installed lm-sensors:amd64 1:3.3.2-2+deb7u1

--=-TZlkjdqa53SicXJiDPuR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-TZlkjdqa53SicXJiDPuR--

