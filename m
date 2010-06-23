From: borat Gunter <borat.gunter@googlemail.com>
Date: Wed, 23 Jun 2010 12:17:38 +0000
Subject: [lm-sensors] Starting up sensors failed
Message-Id: <AANLkTin5YgS58dgFucaJc1byomXnF0m0p5_n-YgezrL-@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3611660209981807076=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3611660209981807076==
Content-Type: multipart/alternative; boundary=0015174c152c0ea7b50489b186ac

--0015174c152c0ea7b50489b186ac
Content-Type: text/plain; charset=ISO-8859-1

Hello Everyone,

i have done the *sensors-detect*, and the summary output looks like:

 *Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 0440'
    Busdriver `i2c-piix4', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 1)

I will now generate the commands needed to load the I2C modules.

To make the sensors modules behave correctly, add these lines to
/etc/modprobe.conf:
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
To load everything that is needed, add this to some /etc/rc* file:
#----cut here----
# I2C adapter drivers
modprobe i2c-piix4
# I2C chip drivers
modprobe eeprom
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
insserv: can not symlink(../arkeia, rc2.d/S06arkeia): File exists
insserv: can not symlink(../arkeia, rc3.d/S06arkeia): File exists
insserv: can not symlink(../arkeia, rc4.d/S06arkeia): File exists
insserv: can not symlink(../arkeia, rc5.d/S06arkeia): File exists

*and then i tried to ignore these error message to start the sensors,
unfortunately failed.
*:~ # /etc/init.d/lm_sensors start
Starting up sensors:                                                 failed*

Can somebody help me? What does insserv mean? And how to correct it?

Thank you so much in advance.

best regards.
borat

--0015174c152c0ea7b50489b186ac
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Everyone,<br><br>i have done the <b>sensors-detect</b>, and the summa=
ry output looks like:<br><br>=A0<i>Now follows a summary of the probes I ha=
ve just done.<br>=A0Just press ENTER to continue:<br><br><b>Driver `eeprom&=
#39; (should be inserted):<br>
=A0 Detects correctly:<br>=A0 * Bus `SMBus PIIX4 adapter at 0440&#39;<br>=
=A0=A0=A0 Busdriver `i2c-piix4&#39;, I2C address 0x50<br>=A0=A0=A0 Chip `SP=
D EEPROM&#39; (confidence: 1)</b><br><br>I will now generate the commands n=
eeded to load the I2C modules.<br>
<br>To make the sensors modules behave correctly, add these lines to<br>/et=
c/modprobe.conf:<br>#----cut here----<br># I2C module options<br>alias char=
-major-89 i2c-dev<br>#----cut here----<br>To load everything that is needed=
, add this to some /etc/rc* file:<br>
#----cut here----<br># I2C adapter drivers<br>modprobe i2c-piix4<br># I2C c=
hip drivers<br>modprobe eeprom<br># sleep 2 # optional<br>/usr/bin/sensors =
-s # recommended<br>#----cut here----<br><br>WARNING! If you have some thin=
gs built into your kernel, the list above<br>
will contain too many modules. Skip the appropriate ones! You really should=
<br>try these commands right now to make sure everything is working properl=
y.<br>Monitoring programs won&#39;t work until it&#39;s done.<br><br>Do you=
 want to generate /etc/sysconfig/lm_sensors? (YES/no):<br>
<b>insserv: can not symlink(../arkeia, rc2.d/S06arkeia): File exists<br>ins=
serv: can not symlink(../arkeia, rc3.d/S06arkeia): File exists<br>insserv: =
can not symlink(../arkeia, rc4.d/S06arkeia): File exists<br>insserv: can no=
t symlink(../arkeia, rc5.d/S06arkeia): File exists<br>
<br></b></i>and then i tried to ignore these error message to start the sen=
sors, unfortunately failed.<br><i>:~ # /etc/init.d/lm_sensors start<br>Star=
ting up sensors:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 failed</i><br>
<br>Can somebody help me? What does insserv mean? And how to correct it?<br=
><br>Thank you so much in advance. <br><br>best regards.<br>borat<br>

--0015174c152c0ea7b50489b186ac--


--===============3611660209981807076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3611660209981807076==--
