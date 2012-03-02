From: Stefan Monnier <monnier@iro.umontreal.ca>
Date: Fri, 02 Mar 2012 15:15:22 +0000
Subject: [lm-sensors] Interpreting lm-sensors's output
Message-Id: <jwv1upbxcso.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I just got a new fanless mini-ITX board and am concerned about
its temperature.
lm-sensors only finds two temperature sensors on this board:

   % sensors
   radeon-pci-0008
   Adapter: PCI adapter
   temp1:        +51.0=B0C =20
  =20
   k10temp-pci-00c3
   Adapter: PCI adapter
   temp1:        +51.5=B0C  (high =3D +70.0=B0C)
                          (crit =3D +100.0=B0C, hyst =3D +97.0=B0C)
  =20
   %

IIUC both of those are sensors within my E350 processor (the first on
the GPU, the second on the CPU).
Now here's my question: how can I figure out what temperature is "safe"
or what is "too high"?

OT1H the "high=3D70" and "crit=3D100" would seem to give me the answer, but
OTOH I don't know whether I can trust them (actually, I hope some of
the output is "wrong" since the sensor readings go up routinely to 80=B0
during long compilations).


        Stefan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
