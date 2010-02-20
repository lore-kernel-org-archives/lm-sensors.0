From: Reimundo Heluani <rheluani@gmail.com>
Date: Sat, 20 Feb 2010 01:51:00 +0000
Subject: Re: [lm-sensors] adt746x hard shut question
Message-Id: <e871e9151002191751s4a4b3ad3u3abd661a831c750b@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0599555729894102344=="
List-Id: <lm-sensors.vger.kernel.org>
References: <e871e9151002191538x4afa9f66y722ab33abd2aa5d6@mail.gmail.com>
In-Reply-To: <e871e9151002191538x4afa9f66y722ab33abd2aa5d6@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0599555729894102344==
Content-Type: multipart/alternative; boundary=0016e64616be9815a1047ffe6ed7

--0016e64616be9815a1047ffe6ed7
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Feb 19, 2010 at 3:38 PM, Reimundo Heluani <rheluani@gmail.com>wrote:

> Hello list, I am running the module therm_adt746x on a powerbook g4 and the
> module seems to be doing its thing right. I can set different limits writing
> to /sys/devices/temperatures/limit_adjust and the fans seem to be responding
> correctly to both temperature and load. The problem I have is that if I run
> any compilation for more than a few minutes on performance governor, the
> system hard shuts itself down. I was wandering if this is done at the
> Hardware level, or if it's the module who's putting this limit. Also I'd
> like to know what is this limit and if it's possible to change it. As of now
> I can only compile things in powersave mode.
>
> Thanks,
>
> R.
>
>
Well, looking at the code for the module I see that there is a hardcoded
limit of 65 degrees Celsius for the CPU. Then later there is a line of the
form:
/*Set sensor1 limit higher to avoid powerdowns*/
and then set the limit to 65 + limit_adjust.

But my system (with a limit adjust of 0) powers down automatically at 70 C.
Are these hardcoded limits too low or should I be looking to change the
thermal paste + heatsink?

Thanks,

R.

--0016e64616be9815a1047ffe6ed7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Feb 19, 2010 at 3:38 PM, Reimund=
o Heluani <span dir=3D"ltr">&lt;<a href=3D"mailto:rheluani@gmail.com">rhelu=
ani@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex=
; padding-left: 1ex;">
Hello list, I am running the module therm_adt746x on a powerbook g4 and the=
 module seems to be doing its thing right. I can set different limits writi=
ng to /sys/devices/temperatures/limit_adjust and the fans seem to be respon=
ding correctly to both temperature and load. The problem I have is that if =
I run any compilation for more than a few minutes on performance governor, =
the system hard shuts itself down. I was wandering if this is done at the H=
ardware level, or if it&#39;s the module who&#39;s putting this limit. Also=
 I&#39;d like to know what is this limit and if it&#39;s possible to change=
 it. As of now I can only compile things in powersave mode.<br>

<br>Thanks, <br><font color=3D"#888888"><br>R.<br><br>
</font></blockquote></div><br>Well, looking at the code for the module I se=
e that there is a hardcoded limit of 65 degrees Celsius for the CPU. Then l=
ater there is a line of the form: <br>/*Set sensor1 limit higher to avoid p=
owerdowns*/<br>
and then set the limit to 65 + limit_adjust. <br><br>But my system (with a =
limit adjust of 0) powers down automatically at 70 C.=A0 Are these hardcode=
d limits too low or should I be looking to change the thermal paste + heats=
ink?<br>
<br>Thanks,<br><br>R.<br>

--0016e64616be9815a1047ffe6ed7--


--===============0599555729894102344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0599555729894102344==--
