From: Randall <lists_rlr@roadrunner.com>
Date: Sat, 28 Jun 2008 23:50:00 +0000
Subject: [lm-sensors] quick note on it87 kernal module and ECS AMD64 mobos
Message-Id: <200806281650.00095.lists_rlr@roadrunner.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

A quick note for the "sensors" to work on the Elite Computer Systems (ECS) =

group Athlon64 3200+ motherboard, which hosts the nVIDIA=AE GeForce 6100 & =

nForce 405 chipset, model #C51G-M754 (V1.0),  a "modprobe it87" command has=
=20
to be issued for both the k8temp and it8716F sensors to work properly. =20
sensors saw the k8temp okay, but couldn't find the it87 chip until the kern=
el=20
module was loaded.  I am NOT sure why Suse 11.0 doesn't autoload this durin=
g=20
init, but I'll force it anyways ;-)

The it8716 shows the information we really need, so it is necessary to get =

this working if you really want to see what is going on.

- Randall



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
