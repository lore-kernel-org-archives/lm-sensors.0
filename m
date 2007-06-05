From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 05 Jun 2007 11:44:32 +0000
Subject: Re: [lm-sensors] Negative Values on many Systems
Message-Id: <20070605114432.GC3273@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <466445BA.5030002@transact-gmbh.de>
In-Reply-To: <466445BA.5030002@transact-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello:

* Anian Wurzenberger <a.wurzenberger@transact-gmbh.de> [2007-06-05 10:38:37=
 +0200]:
> Hi,
> this is what I get on one system (Fedora5, kernel 2.6.15-1.2054 in this
> case, but we use different versions of Fedora on other systems with the
> same/similar problem) with sensors version 2.9.2 with libsensors version
> 2.9.2. (unfortunately I can=B4t find out what kind of board it is right
> now (can=B4t reboot or take it out of the rack), but it=B4s some server
> board with an Intel chipset):
> =20
> w83627hf-isa-0290
> Adapter: ISA adapter
> [...]
> temp1:       +32 =B0C  (high =3D   +50=C2=B0C, hyst =3D   +45=C2=B0C)   s=
ensor > thermistor  =20
> temp2:     -48.0 =B0C  (high =3D   +85=C2=B0C, hyst =3D   +80=C2=B0C)   s=
ensor > thermistor  =20
> temp3:     +29.0 =B0C  (high =3D   +85=C2=B0C, hyst =3D   +80=C2=B0C)   s=
ensor > thermistor
> [...]
> =20
> Changing the sensor-types brings different values, but no useful ones.
> Also, the value doesn=B4t change over time, I always get -48.0 =B0C with =
the
> thermistor setting.
> If sensors logs into /var/log/messages, then there=B4s no entry.
> I would have posted more info in the first post, but I thought (and
> still think) this is a case of "no sensor attached", just wanted to make
> sure.

Yes, that's it.  Some other notes:

1) Use the 'ignore' statement in sensors.conf to hide temp2.

2) In theory, the BIOS should set the correct sensor type.  You shouldn't n=
eed
to change it.

3) You can run a CPU intensive process and watch for the other two temps to
rise.  The one that rises faster is probably the CPU.

Regards,

--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
