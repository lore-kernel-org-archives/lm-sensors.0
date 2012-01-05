From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Thu, 05 Jan 2012 14:52:41 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error
Message-Id: <CACW_hTb+nnq4LOr2TDmW1DoSpDYiWPh3yiQiGRdvBV6C+Frcvw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3223989210658851951=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============3223989210658851951==
Content-Type: multipart/alternative; boundary=bcaec501633390eecd04b5c91538

--bcaec501633390eecd04b5c91538
Content-Type: text/plain; charset=ISO-8859-1

2012/1/5 Jean Delvare <khali@linux-fr.org>

> Hi Frans,
>
> On Mon,  2 Jan 2012 12:03:22 +0100, Frans Meulenbroeks wrote:
> > added error handling so if lm80_update_device fails
> > an error is returned when reading the value through sysfs
> > This is closely modeled after the way this is handled in ltc4261
> > (...)
>
> Are you really still using  LM80 chips? These are pretty old and I did
> not expect anyone to be still using them. And certainly not for new
> designs... The device (at least the incarnations that existed in
> 1998-2000) was not reputed for its reliability...
>
> Yes, we still have them and I need to support them (just like LM75).
(acutally we're using LM96080). They are not on my board, but we have
external fan units that contain these chips, and my board needs to support
these fan units.

Frans.

--bcaec501633390eecd04b5c91538
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/1/5 Jean Delvare <span dir=3D"ltr">=
&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span>=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
Hi Frans,<br>
<div class=3D"im"><br>
On Mon, =A02 Jan 2012 12:03:22 +0100, Frans Meulenbroeks wrote:<br>
&gt; added error handling so if lm80_update_device fails<br>
&gt; an error is returned when reading the value through sysfs<br>
&gt; This is closely modeled after the way this is handled in ltc4261<br>
</div>&gt; (...)<br>
<br>
Are you really still using =A0LM80 chips? These are pretty old and I did<br=
>
not expect anyone to be still using them. And certainly not for new<br>
designs... The device (at least the incarnations that existed in<br>
1998-2000) was not reputed for its reliability...<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div>Yes, we still have them and I need to support them (just like LM75)=
.<br>(acutally we&#39;re using LM96080). They are not on my board, but we h=
ave external fan units that contain these chips, and my board needs to supp=
ort these fan units.<br>
<br>Frans.<br></div></div><br>

--bcaec501633390eecd04b5c91538--


--===============3223989210658851951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3223989210658851951==--
