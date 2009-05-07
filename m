From: Julian Gagnon <nongag@googlemail.com>
Date: Thu, 07 May 2009 17:38:18 +0000
Subject: [lm-sensors] Reboot Problem fancontrol no longer works
Message-Id: <2e1931630905071038y63dc19e0ubc289992b93d6514@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7207825582699159941=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============7207825582699159941==
Content-Type: multipart/alternative; boundary=001636c92477424247046955fa5e

--001636c92477424247046955fa5e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I recently put a computer together.  My Mainboard is a Asus P5Q-Pro.  I'm
loading the module  w83627ehf force_id=0x8860 to be able to read the sensors
output. I have the stable version from your webpage.  Sudo sensors works,
and sudo pwmconfig works as well to control my fan speeds.  Unfortunately,
after a reboot fancontrol no longer works.  Sensors still gives out the
proper output, only when I start fancontrol, it looks like it's working,
just the fans don't spin down.  I don't know why.  I know my cpu core temp
is below the minimum value, and it should just throttle the fan down.  Just
thought you might be interested.

Greetings Julian

--001636c92477424247046955fa5e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I recently put a computer together.=A0 My Mainboard is a Asus P5=
Q-Pro.=A0 I&#39;m loading the module=A0 w83627ehf force_id=3D0x8860 to be a=
ble to read the sensors output. I have the stable version from your webpage=
.=A0 Sudo sensors works, and sudo pwmconfig works as well to control my fan=
 speeds.=A0 Unfortunately, after a reboot fancontrol no longer works.=A0 Se=
nsors still gives out the proper output, only when I start fancontrol, it l=
ooks like it&#39;s working, just the fans don&#39;t spin down.=A0 I don&#39=
;t know why.=A0 I know my cpu core temp is below the minimum value, and it =
should just throttle the fan down.=A0 Just thought you might be interested.=
<br>
<br>Greetings Julian<br>

--001636c92477424247046955fa5e--


--===============7207825582699159941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7207825582699159941==--
