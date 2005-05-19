From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: lm-sensors 2.8 serious bug
Message-Id: <20030928115539.16cb1191.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064705078.1960.10.camel@workstation.webdstom.org>
In-Reply-To: <1064705078.1960.10.camel@workstation.webdstom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


> I am a user of gentoo linux and I have just installed masked
> lm-sensors-2.8.0 and i2c-2.8.0. After running sensors detect
> which detected my chipset and sensors I ran it and it seriously
> crashed linux after trying to load adm1021 module (the machine stopped
> responding to anything so I had to turn it off completely, even the
> reset button was not enough)
> My system is running on ABIT NF7-S motherboard. (I dont know if this
> is important information but I have AthlonXP 2100+ and Radeon 9600
> Pro) The modules that sensors-detect put in /etc/conf.d/lm_sensors
> are: MODULE_0=3Di2c-nforce2
> MODULE_1=3Di2c-isa
> MODULE_2=ADm1021
> MODULE_3=EEprom
> MODULE_4=3Dw83781d
>=20
> I hope that I helped somehow with this information.

Yes, you did. We already had reports that adm1021 was causing systems to
crash, so you seem to confirm that.

Most likely, you don't have an adm1021 or compatible device on your
system. The driver is probably trying to handle a device it wasn't
written for.

We'd need the full output of sensors-detect 2.8.0 to investigate the
problem. I'd also want the output of sensors-detect CVS (which you can
get here:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect).
Don't forget to unload all chip drivers (adm1021, eeprom, w83781) before
running the scripts.

Thanks.

--=20
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
