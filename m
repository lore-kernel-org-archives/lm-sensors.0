From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 31 Jan 2012 07:37:41 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of LM96080
Message-Id: <CACW_hTYXYEa6DpvE1sROhv4kNGYiPN1RfH3o05_JVkqLS4EK3w@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2471202620162393009=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
To: lm-sensors@vger.kernel.org

--===============2471202620162393009==
Content-Type: multipart/alternative; boundary=f46d0434bf42ba9f8504b7ce09b1

--f46d0434bf42ba9f8504b7ce09b1
Content-Type: text/plain; charset=ISO-8859-1

2012/1/28 Jean Delvare <khali@linux-fr.org>

> Add detection of the National Semiconductor (now Texas Instruments)
> LM96080. It is functionally compatible with the LM80 but detection is
> completely different.
> ---
> Frans, if you want to test this, a pre-patched version of
> sensors-detect is available at:
> http://khali.linux-fr.org/devel/misc/sensors-detect
>

Jean, all,

I wanted to give this a stab but then noticed this was a perl script, and
the board on which the LM96080 lives is a small embedded system that does
not have perl, so unfortunately I cannot test it.

Sorry! Frans

--f46d0434bf42ba9f8504b7ce09b1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/1/28 Jean Delvare <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span=
><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
Add detection of the National Semiconductor (now Texas Instruments)<br>
LM96080. It is functionally compatible with the LM80 but detection is<br>
completely different.<br>
---<br>
Frans, if you want to test this, a pre-patched version of<br>
sensors-detect is available at:<br>
<a href=3D"http://khali.linux-fr.org/devel/misc/sensors-detect" target=3D"_=
blank">http://khali.linux-fr.org/devel/misc/sensors-detect</a><br></blockqu=
ote></div><br>Jean, all,<br><br>I wanted to give this a stab but then notic=
ed this was a perl script, and the board on which the LM96080 lives is a sm=
all embedded system that does not have perl, so unfortunately I cannot test=
 it.<br>
<br>Sorry! Frans<br>

--f46d0434bf42ba9f8504b7ce09b1--


--===============2471202620162393009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2471202620162393009==--
