From: Stefan Monnier <monnier@iro.umontreal.ca>
Date: Tue, 20 Mar 2012 03:01:48 +0000
Subject: Re: [lm-sensors] Interpreting lm-sensors's output
Message-Id: <jwvlimwq8ra.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <jwv1upbxcso.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
In-Reply-To: <jwv1upbxcso.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

>> k10temp-pci-00c3
>> Adapter: PCI adapter
>> temp1:        +51.5=B0C  (high =3D +70.0=B0C)
>>                        (crit =3D +100.0=B0C, hyst =3D +97.0=B0C)
[...]
>> OT1H the "high=3D70" and "crit=3D100" would seem to give me the answer, =
but
>> OTOH I don't know whether I can trust them (actually, I hope some of
>> the output is "wrong" since the sensor readings go up routinely to 80=B0
>> during long compilations).
> They are correct and you should trust them.  If you reach 80=B0C then you

Just one more question about these numbers: would the same numbers
appear under Windows (everything else being "equal")?


        Stefan


PS: I'm trying to argue with the company (Zotac) that my board has thermal
problems, but they suck (i.e. they dismiss GNU/Linux users), so I need
to be sure that the numbers they give me (which they get under Windows
from I don't know which tool) are comparable to the ones I see.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
