From: singumal <qdmd-pu1o@dea.spamcon.org>
Date: Fri, 17 Jun 2011 03:56:39 +0000
Subject: [lm-sensors] Possible to set low temperature limit?
Message-Id: <e1klv65nq0br7o0p7eic89047t49qjtedr@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

My sensors output is like this:

f81865f-isa-0a00
...
System Temperature:  +35.0=B0C  (high =3D +85.0=B0C, hyst =3D +81.0=B0C)
                              (crit =3D +100.0=B0C, hyst =3D +96.0=B0C)  se=
nsor =3D transistor

Is there any way to be able to get an ALARM if a sensor
transistor isn't installed?  With no transistor it tends to show
low or negative temperatures.  (Actually on a different
motherboard/sensor).  I suspect the answer is "no, there's no
hardware limit for low temperature to cause an ALARM", just want
to confirm that I'd have to do this check myself.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
