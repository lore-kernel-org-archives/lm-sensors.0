From: =?ISO-8859-2?Q?Hajdu_Tam=E1s_M=E1rk?= <fathom@sirc.hu>
Date: Tue, 26 Mar 2013 23:14:36 +0000
Subject: [lm-sensors] Gigabyte E240N, it87 module, fan speed control not working, readings may bad
Message-Id: <51522BDC.6070103@sirc.hu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6041344564649979576=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--===============6041344564649979576==
Content-Type: multipart/alternative;
 boundary="------------000903030900010106070806"

This is a multi-part message in MIME format.
--------------000903030900010106070806
Content-Type: text/plain; charset="iso-8859-2"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi,

I have a Gigabyte E240N mainboard (integrated amd cpu and gpu), which by=20
pwmconfig reported to use it87 module. This is for first sight works,=20
but one out of 3 temperature reading is always -70 degrees (though it is=20
the temp3, which I don't know what), other two seems to good. Also the=20
fan speed readings seems to be ok (I am not 100% sure). What it really=20
does, that hwmon1 is created and there are changing values so at least=20
it is partially working.
I have tried to use pwmconfig to configure and also tried to echo values=20
I could think of, but I could not set (nor pwmconfig could) it's speed.
I don't want to flood the list with unrelated data, so please tell me=20
what do you need to address the issue.

--=20
=DCdv: *Tam=E1s*.

--------------000903030900010106070806
Content-Type: text/html; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DISO-8=
859-2">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hi,<br>
    <br>
    I have a Gigabyte E240N mainboard (integrated amd cpu and gpu),
    which by pwmconfig reported to use it87 module. This is for first
    sight works, but one out of 3 temperature reading is always -70
    degrees (though it is the temp3, which I don't know what), other two
    seems to good. Also the fan speed readings seems to be ok (I am not
    100% sure). What it really does, that hwmon1 is created and there
    are changing values so at least it is partially working.<br>
    I have tried to use pwmconfig to configure and also tried to echo
    values I could think of, but I could not set (nor pwmconfig could)
    it's speed. <br>
    I don't want to flood the list with unrelated data, so please tell
    me what do you need to address the issue.<br>
    <br>
    <div class=3D"moz-signature">-- <br>
      =DCdv: <b>Tam=E1s</b>.
    </div>
  </body>
</html>

--------------000903030900010106070806--


--===============6041344564649979576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6041344564649979576==--
