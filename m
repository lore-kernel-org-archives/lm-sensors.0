From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Thu, 26 Jan 2012 21:04:14 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error handling
Message-Id: <CACW_hTbB--WhnY-zbrS+VX0M4GSyF5B_pPNcGBL=3TUUP8orRg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8426987652458959640=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============8426987652458959640==
Content-Type: multipart/alternative; boundary=20cf3079b688f7cddd04b774b81a

--20cf3079b688f7cddd04b774b81a
Content-Type: text/plain; charset=ISO-8859-1

2012/1/26 Jean Delvare <khali@linux-fr.org>

> On Thu, 5 Jan 2012 15:52:41 +0100, Frans Meulenbroeks wrote:
> > 2012/1/5 Jean Delvare <khali@linux-fr.org>
> > > Are you really still using  LM80 chips? These are pretty old and I did
> > > not expect anyone to be still using them. And certainly not for new
> > > designs... The device (at least the incarnations that existed in
> > > 1998-2000) was not reputed for its reliability...
> >
> > Yes, we still have them and I need to support them (just like LM75).
> > (acutally we're using LM96080). They are not on my board, but we have
> > external fan units that contain these chips, and my board needs to
> support
> > these fan units.
>
> Frans, could you please provide a register dump of your LM96080 chip?
> I'd like to add that to my collection. You can get such a dump using
> the i2c-dev driver + i2cdump (from package i2c-tools.)
>
> I will try to do so tomorrow.
Please remind me if I haven't done so in a few days as I probably have
forgotten it (I'm currently in a "product-is-about-to-be-released" stress
:-)

Frans

--20cf3079b688f7cddd04b774b81a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/1/26 Jean Delvare <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span=
><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
On Thu, 5 Jan 2012 15:52:41 +0100, Frans Meulenbroeks wrote:<br>
&gt; 2012/1/5 Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khali@=
linux-fr.org</a>&gt;<br>
&gt; &gt; Are you really still using =A0LM80 chips? These are pretty old an=
d I did<br>
&gt; &gt; not expect anyone to be still using them. And certainly not for n=
ew<br>
&gt; &gt; designs... The device (at least the incarnations that existed in<=
br>
&gt; &gt; 1998-2000) was not reputed for its reliability...<br>
&gt;<br>
&gt; Yes, we still have them and I need to support them (just like LM75).<b=
r>
&gt; (acutally we&#39;re using LM96080). They are not on my board, but we h=
ave<br>
&gt; external fan units that contain these chips, and my board needs to sup=
port<br>
&gt; these fan units.<br>
<br>
Frans, could you please provide a register dump of your LM96080 chip?<br>
I&#39;d like to add that to my collection. You can get such a dump using<br=
>
the i2c-dev driver + i2cdump (from package i2c-tools.)<br>
<br></blockquote><div>I will try to do so tomorrow. <br>Please remind me if=
 I haven&#39;t done so in a few days as I probably have forgotten it (I&#39=
;m currently in a &quot;product-is-about-to-be-released&quot; stress :-)<br=
>
<br>Frans <br></div></div>

--20cf3079b688f7cddd04b774b81a--


--===============8426987652458959640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8426987652458959640==--
