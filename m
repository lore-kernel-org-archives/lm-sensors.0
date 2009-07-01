From: Maneki Neko <manekineko@gmail.com>
Date: Wed, 01 Jul 2009 17:25:44 +0000
Subject: Re: [lm-sensors] VID on Intel Core Duo
Message-Id: <a0bfe2b50907011025p14c68852l8469f09105566378@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1068030471464046595=="
List-Id: <lm-sensors.vger.kernel.org>
References: <a0bfe2b50906132136s31d71fa5le2bd739245d51c8f@mail.gmail.com>
In-Reply-To: <a0bfe2b50906132136s31d71fa5le2bd739245d51c8f@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============1068030471464046595==
Content-Type: multipart/alternative; boundary=0016e6469b6a9cfbaa046da836b8

--0016e6469b6a9cfbaa046da836b8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The Windows program I use to pull the VID is CPUID's CPU-Z program.  It only
shows one voltage, the "Core VID".  Unfortunately, I don't see anything that
states what chip it is using.

On Mon, Jun 15, 2009 at 3:36 PM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Maneki,
>
> On Sun, 14 Jun 2009 00:36:11 -0400, Maneki Neko wrote:
> > I'm trying to obtain the VID on an HP notebook with a Core Duo CPU.
>  Under
> > Windows, I could see the voltage, speed, temperature, etc. but with
> > lm-sensors all I'm able to see is the temperature.
> >
> > I have run sensors-detect to no avail.  Can anyone provide any advice to
> me
> > on how to get this working?  Thanks for your time and help!
>
> What tool do you use on Windows? Does it tell you which chip is used
> for monitoring?
>
> How many voltages are displayed? If there's only one voltage, is is a
> measured one, or the VID value?
>
> CPU speed you can get from /proc/cpuinfo, it's not lm-sensors' job. Of
> did you mean fan speed?
>
> --
> Jean Delvare
>

--0016e6469b6a9cfbaa046da836b8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The Windows program I use to pull the VID is CPUID&#39;s CPU-Z program.=A0 =
It only shows one voltage, the &quot;Core VID&quot;.=A0 Unfortunately, I do=
n&#39;t see anything that states what chip it is using.<br><br><div class=
=3D"gmail_quote">
On Mon, Jun 15, 2009 at 3:36 PM, Jean Delvare <span dir=3D"ltr">&lt;<a href=
=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Maneki,<br>
<div class=3D"im"><br>
On Sun, 14 Jun 2009 00:36:11 -0400, Maneki Neko wrote:<br>
&gt; I&#39;m trying to obtain the VID on an HP notebook with a Core Duo CPU=
. =A0Under<br>
&gt; Windows, I could see the voltage, speed, temperature, etc. but with<br=
>
&gt; lm-sensors all I&#39;m able to see is the temperature.<br>
&gt;<br>
&gt; I have run sensors-detect to no avail. =A0Can anyone provide any advic=
e to me<br>
&gt; on how to get this working? =A0Thanks for your time and help!<br>
<br>
</div>What tool do you use on Windows? Does it tell you which chip is used<=
br>
for monitoring?<br>
<br>
How many voltages are displayed? If there&#39;s only one voltage, is is a<b=
r>
measured one, or the VID value?<br>
<br>
CPU speed you can get from /proc/cpuinfo, it&#39;s not lm-sensors&#39; job.=
 Of<br>
did you mean fan speed?<br>
<br>
--<br>
<font color=3D"#888888">Jean Delvare<br>
</font></blockquote></div><br>

--0016e6469b6a9cfbaa046da836b8--


--===============1068030471464046595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1068030471464046595==--

