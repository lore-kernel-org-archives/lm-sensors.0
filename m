From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Mar 2009 09:31:51 +0000
Subject: Re: [lm-sensors] no lines in rrd graphs from sensord
Message-Id: <20090308103151.1ff577f7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090305164626.58YK4.419625.imail@fed1rmwml30>
In-Reply-To: <20090305164626.58YK4.419625.imail@fed1rmwml30>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Steve,

On Thu, 5 Mar 2009 13:46:26 -0800, linuxjagnut@cox.net wrote:
> I have configured lm_sensors on my system and normal output shows up when=
 I run the sensors command line client.
>=20
> $ sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +33.0=B0C                                   =20
> Core1 Temp:  +31.0=B0C                                   =20
>=20
> it8716-isa-0290
> Adapter: ISA adapter
> VCore:       +1.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
> VDDR:        +2.48 V  (min =3D  +1.28 V, max =3D  +1.68 V)   ALARM
> +3.3V:       +1.89 V  (min =3D  +2.78 V, max =3D  +3.78 V)   ALARM
> +5V:         +5.73 V  (min =3D  +4.49 V, max =3D  +5.48 V)   ALARM
> +12V:        +4.86 V  (min =3D  +9.98 V, max =3D +13.95 V)   ALARM
> in5:         +1.17 V  (min =3D  +0.58 V, max =3D  +1.34 V)  =20
> in6:         +2.98 V  (min =3D  +1.04 V, max =3D  +1.36 V)   ALARM
> 5VSB:        +5.13 V  (min =3D  +4.49 V, max =3D  +5.48 V)  =20
> VBat:        +3.04 V
> fan1:       1634 RPM  (min =3D   10 RPM)
> fan2:          0 RPM  (min =3D   10 RPM)  ALARM
> temp1:       +21.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D thermal diode
> temp2:       +35.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D transistor
> temp3:       +25.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D transistor
> cpu0_vid:   +1.525 V
>=20
> So next I built sensord that is currently packaged with the 3.1.0 release.
> I was able to get it running with the following command line:
>=20
> /usr/local/sbin/sensord --log-interval 0 --load-average --rrd-file /var/w=
ww/html/sensord/sensord.rrd --pid-file /var/www/html/sensord/sensord.pid
>=20
> and it is running as the apache user on my system and that same user owns=
 the /var/www/html/sensord/ directory. The daemon is running but the size o=
f the rrd file (sensord.rrd from the above command line) does not change si=
ze and the time stamp is not updated on the file either.

Check your logs (/var/log/local4 by default) for errors. The RRD
interface of sensord is very fragile, and pretty much any configuration
change will break it. If you changed a label or if you added an ignore
statement or if the hwmon drivers are loaded in a different order,
sensord will think that the rrd database structure doesn't match the
data it wants to put in it, and fail. In this case, simply delete the
empty rrd data file and let sensord create it again.

There's definitely room for improvement in this area.

> I can see graphs when I display the URL to the cgi script in my web brows=
er but there are no lines drawn for any graphed output. The bottom of each =
graph does have a label for the appropriate sensors on my system but no dat=
a is being displayed inside the graph itself.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
