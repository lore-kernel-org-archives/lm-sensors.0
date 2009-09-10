From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Sep 2009 07:56:38 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <20090910095638.16bbc3e7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Karl,

On Sun, 06 Sep 2009 13:28:04 -0500, Karl Schmidt wrote:
> OK - this is what I did in the mean time - just to test:
> ---------------------------------
> # modprobe i2c-dev
> root@kiwi:~# rmmod dme1737
> root@kiwi:~# i2cset -y 0 0x2e 0x7e 0xec
> No size specified (using byte-data access)
> Value 0xec written, readback matched
> root@kiwi:~# i2cset -y 0 0x2e 0x80 0x7e
> No size specified (using byte-data access)
> Value 0x7e written, readback matched
> root@kiwi:~# i2cset -y 0 0x2e 0x82 0x0e
> No size specified (using byte-data access)
> Value 0x0e written, readback matched
> root@kiwi:~# modprobe dme1737 ignore=3D1,0x2e
>=20
> # sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +20.0=B0C
>=20
> dme1737-i2c-0-2e
> Adapter: SMBus nForce2 adapter at 1c00
> in0:         +2.61 V  (min =3D  +0.00 V, max =3D  +2.00 V)   ALARM
> in1:         +1.43 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> in2:         +3.35 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> in3:         +5.10 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> in4:        +12.09 V  (min =3D  +0.00 V, max =3D +15.94 V)
> in5:         +3.30 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> in6:         +3.00 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> fan1:       7826 RPM  (min =3D 8000 RPM)
> fan2:       8157 RPM  (min =3D 9000 RPM)
> fan3:       7929 RPM  (min =3D    0 RPM)
> fan4:       7894 RPM  (min =3D    0 RPM)
> temp1:       +36.2=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
> temp2:       +26.3=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
> temp3:       +22.9=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
> cpu0_vid:   +1.550 V
> ----------------------------------------
>=20
> I did get the voltage alarm that is set! But sadly still no fan alarms, b=
ut you are obviously on the=20
> correct track.

Strange... Can you please test all the voltage inputs, all the fan
inputs and all the temperature inputs, to summarize what works and what
doesn't? And then provide a new i2cdump when all alarms should be set.
Please note that you must re-issue the i2cset sequence above after
every reboot, or the changes are lost.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
