From: Virgil Gheorghiu <virgilg@cs.uchicago.edu>
Date: Fri, 28 May 2010 23:40:32 +0000
Subject: Re: [lm-sensors] How to get the OID of lm_sensors'value for SNMP
Message-Id: <724BCAB9-9513-4D14-97B7-866ABF136519@cs.uchicago.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2515919318394113249=="
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinFupaElK-tO7ReqZdi_Xr-i78S5skKU1mcWJn7@mail.gmail.com>
In-Reply-To: <AANLkTinFupaElK-tO7ReqZdi_Xr-i78S5skKU1mcWJn7@mail.gmail.com>
To: lm-sensors@vger.kernel.org


--===============2515919318394113249==
Content-Type: multipart/alternative; boundary=Apple-Mail-9-430088968


--Apple-Mail-9-430088968
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi, Borat

> sorry to bother you again, i've find your post. =
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-May/028535.html
> But with snmpwalk -v2c -c public printsrv =
LM-SENSORS-MIB::lmFanSensorsTable I got the error: =
LM-SENSORS-MIB::lmFanSensorsTable =3D No Such Object available on this =
agent at this OID
Yes, I got the same error when I upgraded our Debian unstable systems to =
snmp 5.4.2.1 (libsnmp-base 5.4.2.1).
I filed a (similar) bug with the package maintainer (581007), please =
see:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D581007

So I rolled my packages back to 5.4.1~dfsg-12 (snmp, snmpd, =
libsnmp-base) and will keep them there until they sort this out.
I suggest you ask the net-snmp list to fix this problem. The MIB that =
the lm-sensors people provide is clean and minimal; although
there's room for improvement, I believe it is not their problem that =
net-snmp broke this functionality aspect. Or maybe they're in the
process of fixing it already? (Someone correct me if I'm wrong)

Here are relevant SNMP configuration parameters that work with package =
versions I mentioned above:
root@client:~# cat /etc/snmp/snmpd.conf
# lines with v2c / v3 security stuff
...
# give access to sensors tree
view systemview included        .1.3.6.1.4.1.2021.13.16

root@client:~# cat /etc/sensors.conf
# proper per your motherboard

Daemons running: snmpd, sensord (optional)


root@nms-server:~# # snmpbulkwalk -v2c -cpublic client  =
LM-SENSORS-MIB::lmTempSensorsTable
LM-SENSORS-MIB::lmTempSensorsIndex.1 =3D INTEGER: 0
LM-SENSORS-MIB::lmTempSensorsIndex.2 =3D INTEGER: 1
LM-SENSORS-MIB::lmTempSensorsIndex.3 =3D INTEGER: 2
LM-SENSORS-MIB::lmTempSensorsIndex.4 =3D INTEGER: 3
LM-SENSORS-MIB::lmTempSensorsIndex.5 =3D INTEGER: 4
LM-SENSORS-MIB::lmTempSensorsDevice.1 =3D STRING: CPU0 Temp
LM-SENSORS-MIB::lmTempSensorsDevice.2 =3D STRING: CPU1 Temp
LM-SENSORS-MIB::lmTempSensorsDevice.3 =3D STRING: temp3
LM-SENSORS-MIB::lmTempSensorsDevice.4 =3D STRING: temp4
LM-SENSORS-MIB::lmTempSensorsDevice.5 =3D STRING: MB Temp
LM-SENSORS-MIB::lmTempSensorsValue.1 =3D Gauge32: 55000
LM-SENSORS-MIB::lmTempSensorsValue.2 =3D Gauge32: 58000
LM-SENSORS-MIB::lmTempSensorsValue.3 =3D Gauge32: 4294839296
LM-SENSORS-MIB::lmTempSensorsValue.4 =3D Gauge32: 4294839296
LM-SENSORS-MIB::lmTempSensorsValue.5 =3D Gauge32: 32000

One thing I noticed is that the walk returns parameters (and bogus =
values) I explicitly set to 'ignore' in my sensors.conf.
I'd love it if it wouldn't:
root@client:~# grep ignore /etc/sensors.conf=20
        ignore in3
        ignore temp3
        ignore temp4
        ignore fan7
        ignore fan8
        ignore fan9
        ignore fan10

You can then build a grep script that gives you [param]:[value] pairs =
and dump them in an rrd file.

Best,
Virgil=

--Apple-Mail-9-430088968
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; ">Hi, =
Borat<div><br></div><div><div><blockquote type=3D"cite">sorry to bother =
you again, i've find your post. <a =
href=3D"http://lists.lm-sensors.org/pipermail/lm-sensors/2010-May/028535.h=
tml">http://lists.lm-sensors.org/pipermail/lm-sensors/2010-May/028535.html=
</a><br>
But with <b>snmpwalk -v2c -c public printsrv =
LM-SENSORS-MIB::lmFanSensorsTable</b> I got the error: =
<i>LM-SENSORS-MIB::lmFanSensorsTable =3D No Such Object available on =
this agent at this OID</i><br></blockquote>Yes, I got the same error =
when I upgraded our Debian unstable systems to snmp 5.4.2.1 =
(libsnmp-base 5.4.2.1).</div><div>I filed a (similar) bug with the =
package maintainer (581007), please see:</div><div><a =
href=3D"http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D581007">http://=
bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D581007</a></div><div><br></div=
><div>So I rolled my packages back to 5.4.1~dfsg-12 (snmp, snmpd, =
libsnmp-base) and will keep them there until they sort this =
out.</div><div>I suggest you ask the net-snmp list to fix this problem. =
The MIB that the lm-sensors people provide is clean and minimal; =
although</div><div>there's room for improvement, I believe it is not =
their problem that net-snmp broke this functionality aspect. Or maybe =
they're in the</div><div>process of fixing it already?&nbsp;(Someone =
correct me if I'm wrong)</div><div><br></div><div>Here are relevant SNMP =
configuration parameters that work with package versions I mentioned =
above:</div><div>root@client:~# cat /etc/snmp/snmpd.conf</div><div># =
lines with v2c / v3 security stuff</div><div>...</div><div># give access =
to sensors tree</div><div>view systemview included &nbsp; &nbsp; &nbsp; =
&nbsp;.1.3.6.1.4.1.2021.13.16</div><div><br></div><div>root@client:~# =
cat /etc/sensors.conf</div><div># proper per your =
motherboard</div><div><br></div><div>Daemons running: snmpd, sensord =
(optional)</div><div><br></div><div><br></div><div>root@nms-server:~#&nbsp=
;# snmpbulkwalk -v2c -cpublic client =
&nbsp;LM-SENSORS-MIB::lmTempSensorsTable</div><div>LM-SENSORS-MIB::lmTempS=
ensorsIndex.1 =3D INTEGER: =
0</div><div>LM-SENSORS-MIB::lmTempSensorsIndex.2 =3D INTEGER: =
1</div><div>LM-SENSORS-MIB::lmTempSensorsIndex.3 =3D INTEGER: =
2</div><div>LM-SENSORS-MIB::lmTempSensorsIndex.4 =3D INTEGER: =
3</div><div>LM-SENSORS-MIB::lmTempSensorsIndex.5 =3D INTEGER: =
4</div><div>LM-SENSORS-MIB::lmTempSensorsDevice.1 =3D STRING: CPU0 =
Temp</div><div>LM-SENSORS-MIB::lmTempSensorsDevice.2 =3D STRING: CPU1 =
Temp</div><div>LM-SENSORS-MIB::lmTempSensorsDevice.3 =3D STRING: =
temp3</div><div>LM-SENSORS-MIB::lmTempSensorsDevice.4 =3D STRING: =
temp4</div><div>LM-SENSORS-MIB::lmTempSensorsDevice.5 =3D STRING: MB =
Temp</div><div>LM-SENSORS-MIB::lmTempSensorsValue.1 =3D Gauge32: =
55000</div><div>LM-SENSORS-MIB::lmTempSensorsValue.2 =3D Gauge32: =
58000</div><div>LM-SENSORS-MIB::lmTempSensorsValue.3 =3D Gauge32: =
4294839296</div><div>LM-SENSORS-MIB::lmTempSensorsValue.4 =3D Gauge32: =
4294839296</div><div>LM-SENSORS-MIB::lmTempSensorsValue.5 =3D Gauge32: =
32000</div><div><br></div><div>One thing I noticed is that the walk =
returns parameters (and bogus values) I explicitly set to 'ignore' in my =
sensors.conf.</div><div>I'd love it if it =
wouldn't:</div><div><div>root@client:~# grep ignore =
/etc/sensors.conf&nbsp;</div><div>&nbsp;&nbsp; &nbsp; &nbsp; =
&nbsp;ignore in3</div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;ignore =
temp3</div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;ignore =
temp4</div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;ignore =
fan7</div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;ignore =
fan8</div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;ignore =
fan9</div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;ignore =
fan10</div><div><br></div></div><div>You can then build a grep script =
that gives you [param]:[value] pairs and dump them in an rrd =
file.</div><div><br></div><div>Best,</div><div>Virgil</div></div></body></=
html>=

--Apple-Mail-9-430088968--


--===============2515919318394113249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2515919318394113249==--
