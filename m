From: Simon Tims <si@cog24.com>
Date: Thu, 06 Sep 2012 19:23:51 +0000
Subject: Re: [lm-sensors] Patching help
Message-Id: <CAPevXitRa1ObrCP1tJUVMPwUBkneONf0LTZJFW2nb1w0BxA8Cg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2633323759037492890=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
In-Reply-To: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2633323759037492890==
Content-Type: multipart/alternative; boundary=047d7b5d428472ae7c04c90d6ee8

--047d7b5d428472ae7c04c90d6ee8
Content-Type: text/plain; charset=ISO-8859-1

Thank you so much for your detailed replies and assistance.

Jean,

zgrep I2C_PIIX4 /proc/config.gz

reports no such file or directory; on my server, /proc exists but
/config.gz isn't within it.

I think it looks like the combination of the HP N40L with Ubuntu isn't
presently supported by LM Sensors yet, due to Debian not being
supported by the SMBus multiplexing driver.


Simon


On 29 August 2012 18:29, Jean Delvare <khali@linux-fr.org> wrote:

> On Wed, 29 Aug 2012 10:03:14 -0700, Guenter Roeck wrote:
> > Hi Jean,
> >
> > On Wed, Aug 29, 2012 at 06:47:38PM +0200, Jean Delvare wrote:
> > > Hi Simon,
> > >
> > [ ... ]
> > >
> > > Presumably you refer to:
> > > http://marc.info/?l=linux-i2c&m=133033220527043&w=2
> > > (At least I think this is the latest version of the patch... Not sure.)
> > >
> > [ ... ]
> >
> > > I hope to find some time to finally review the patch in question so
> > > that it can get upstream and things just work for users out of the box.
> > > But I am just back from vacation with a lot of stuff in my mailbox so
> > > it will take some time before I get there.
> > >
> > Unfortunately, the patch no longer applies. The driver was since
> modified to add
> > support for a second "aux" SMBus port, and that conflicts with the four
> ports
> > supported on the sb800.
>
> OK, I'll ask the author to rebase and resubmit then.
>
> --
> Jean Delvare
>

--047d7b5d428472ae7c04c90d6ee8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thank you so much for your detailed replies and assistance.<div><br></div><=
div>Jean,=A0<br><div><pre><font face=3D"tahoma, sans-serif">zgrep I2C_PIIX4=
 /proc/config.gz</font></pre><pre><font face=3D"tahoma, sans-serif">reports=
 no such file or directory; on my server, /proc exists but /config.gz isn&#=
39;t within it.</font></pre>
<pre><font face=3D"tahoma, sans-serif">I think it looks like the combinatio=
n of the HP N40L with Ubuntu isn&#39;t presently supported by LM Sensors ye=
t, due to Debian not being supported by the SMBus multiplexing driver.</fon=
t></pre>
<pre><br></pre><pre><font face=3D"tahoma, sans-serif">Simon</font></pre><br=
><div class=3D"gmail_quote">On 29 August 2012 18:29, Jean Delvare <span dir=
=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org" target=3D"_blank">khali@=
linux-fr.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Wed, 29 Aug 2012 10:03:14 -0700, Guenter =
Roeck wrote:<br>
&gt; Hi Jean,<br>
&gt;<br>
&gt; On Wed, Aug 29, 2012 at 06:47:38PM +0200, Jean Delvare wrote:<br>
&gt; &gt; Hi Simon,<br>
&gt; &gt;<br>
&gt; [ ... ]<br>
&gt; &gt;<br>
&gt; &gt; Presumably you refer to:<br>
&gt; &gt; <a href=3D"http://marc.info/?l=3Dlinux-i2c&amp;m=3D13303322052704=
3&amp;w=3D2" target=3D"_blank">http://marc.info/?l=3Dlinux-i2c&amp;m=3D1330=
33220527043&amp;w=3D2</a><br>
&gt; &gt; (At least I think this is the latest version of the patch... Not =
sure.)<br>
&gt; &gt;<br>
&gt; [ ... ]<br>
&gt;<br>
&gt; &gt; I hope to find some time to finally review the patch in question =
so<br>
&gt; &gt; that it can get upstream and things just work for users out of th=
e box.<br>
&gt; &gt; But I am just back from vacation with a lot of stuff in my mailbo=
x so<br>
&gt; &gt; it will take some time before I get there.<br>
&gt; &gt;<br>
&gt; Unfortunately, the patch no longer applies. The driver was since modif=
ied to add<br>
&gt; support for a second &quot;aux&quot; SMBus port, and that conflicts wi=
th the four ports<br>
&gt; supported on the sb800.<br>
<br>
OK, I&#39;ll ask the author to rebase and resubmit then.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br></div></div>

--047d7b5d428472ae7c04c90d6ee8--


--===============2633323759037492890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2633323759037492890==--
