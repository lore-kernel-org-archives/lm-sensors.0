From: Reimundo Heluani <rheluani@gmail.com>
Date: Fri, 19 Feb 2010 23:38:41 +0000
Subject: [lm-sensors] adt746x hard shut question
Message-Id: <e871e9151002191538x4afa9f66y722ab33abd2aa5d6@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8992535580667975283=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8992535580667975283==
Content-Type: multipart/alternative; boundary=0016e64dbc0e5db17e047ffc956c

--0016e64dbc0e5db17e047ffc956c
Content-Type: text/plain; charset=ISO-8859-1

Hello list, I am running the module therm_adt746x on a powerbook g4 and the
module seems to be doing its thing right. I can set different limits writing
to /sys/devices/temperatures/limit_adjust and the fans seem to be responding
correctly to both temperature and load. The problem I have is that if I run
any compilation for more than a few minutes on performance governor, the
system hard shuts itself down. I was wandering if this is done at the
Hardware level, or if it's the module who's putting this limit. Also I'd
like to know what is this limit and if it's possible to change it. As of now
I can only compile things in powersave mode.

Thanks,

R.

--0016e64dbc0e5db17e047ffc956c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello list, I am running the module therm_adt746x on a powerbook g4 and the=
 module seems to be doing its thing right. I can set different limits writi=
ng to /sys/devices/temperatures/limit_adjust and the fans seem to be respon=
ding correctly to both temperature and load. The problem I have is that if =
I run any compilation for more than a few minutes on performance governor, =
the system hard shuts itself down. I was wandering if this is done at the H=
ardware level, or if it&#39;s the module who&#39;s putting this limit. Also=
 I&#39;d like to know what is this limit and if it&#39;s possible to change=
 it. As of now I can only compile things in powersave mode.<br>
<br>Thanks, <br><br>R.<br><br>

--0016e64dbc0e5db17e047ffc956c--


--===============8992535580667975283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8992535580667975283==--
