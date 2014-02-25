From: Josu Lazkano <josu.lazkano@gmail.com>
Date: Tue, 25 Feb 2014 21:18:14 +0000
Subject: [lm-sensors] HP ProLiant MicroServer
Message-Id: <CAL9G6WVNxpchDgqTkUS7ad-j0f-h20YCo0FtCrVL0ra8F-ttYw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello, I have a HP ProLiant MicroServer with Debian Wheezy (3.2 kernel).

I want to get some hardware information such processor temperature, fan spe=
ed...

I execute "sensors-detect" and it load the "jc42" module, but I just
have this information:

# sensors
k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +32.5=B0C  (high =3D +70.0=B0C)
                       (crit =3D +100.0=B0C, hyst =3D +95.0=B0C)


Is it possible to get more information? disk temperature? fan speed?

Thanks for your help.

Kind regards.

--=20
Josu Lazkano

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
