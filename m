From: Karl Newman <siliconfiend@gmail.com>
Date: Fri, 15 Jan 2010 18:10:16 +0000
Subject: Re: [lm-sensors] ATK0110 on older Asus board
Message-Id: <52ae42fa1001151010o14173c5ev6cf2676d22821493@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1531118104710169117=="
List-Id: <lm-sensors.vger.kernel.org>
References: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
In-Reply-To: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============1531118104710169117==
Content-Type: multipart/alternative; boundary=00504502e18c6e1b59047d37ea4b

--00504502e18c6e1b59047d37ea4b
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Jan 15, 2010 at 9:30 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Luca,
>
> On Fri, 15 Jan 2010 18:11:53 +0100, Luca Tettamanti wrote:
> > On Fri, Jan 15, 2010 at 5:52 PM, Karl Newman <siliconfiend@gmail.com>
> wrote:
> > > The reason I thought there would be some
> > > dmesg or syslog entries is that I saw something like that in the
> mailing
> > > list about the ATK0110 (it looked like it was enumerating devices it
> found).
> > > The email didn't say where that text came from, though...
> >
> > They comes from the driver, but only when HWMON_DEBUG_CHIP is enabled.
> >
> > > Thanks for looking into this. I've attached my DSDT (dumped via cp
> > > /proc/acpi/dsdt A8N-VM_CSM.DSDT).
> >
> > Ugh. The AKT0110 node is totally empty, nonetheless the hwmon methods
> > are available.
> > The driver is failing because the method used to identify the mobo
> > (MBIF) is missing (and the printk isn't verbose enough).
> > I suppose I could relax the check and probe the interface even if it's
> > not possible to id the board.
> > I'll prepare a patch.
>
> Isn't this similar to the problem (and patch!) reported by Juan RP 3
> days ago?
>
> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027606.html
>
> --
> Jean Delvare
>

That patch worked great, even on 2.6.31-gentoo-r6 (offset -222 lines). Now
the module loads and 'sensors' shows all the connected devices. Thanks for
all your help!

Sincerely,

Karl Newman

--00504502e18c6e1b59047d37ea4b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Fri, Jan 15, 2010 at 9:30 AM, Jean Delvare <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org" target=3D"_blank"=
>khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">

Hi Luca,<br>
<div><div></div><div><br>
On Fri, 15 Jan 2010 18:11:53 +0100, Luca Tettamanti wrote:<br>
&gt; On Fri, Jan 15, 2010 at 5:52 PM, Karl Newman &lt;<a href=3D"mailto:sil=
iconfiend@gmail.com" target=3D"_blank">siliconfiend@gmail.com</a>&gt; wrote=
:<br>
&gt; &gt; The reason I thought there would be some<br>
&gt; &gt; dmesg or syslog entries is that I saw something like that in the =
mailing<br>
&gt; &gt; list about the ATK0110 (it looked like it was enumerating devices=
 it found).<br>
&gt; &gt; The email didn&#39;t say where that text came from, though...<br>
&gt;<br>
&gt; They comes from the driver, but only when HWMON_DEBUG_CHIP is enabled.=
<br>
&gt;<br>
&gt; &gt; Thanks for looking into this. I&#39;ve attached my DSDT (dumped v=
ia cp<br>
&gt; &gt; /proc/acpi/dsdt A8N-VM_CSM.DSDT).<br>
&gt;<br>
&gt; Ugh. The AKT0110 node is totally empty, nonetheless the hwmon methods<=
br>
&gt; are available.<br>
&gt; The driver is failing because the method used to identify the mobo<br>
&gt; (MBIF) is missing (and the printk isn&#39;t verbose enough).<br>
&gt; I suppose I could relax the check and probe the interface even if it&#=
39;s<br>
&gt; not possible to id the board.<br>
&gt; I&#39;ll prepare a patch.<br>
<br>
</div></div>Isn&#39;t this similar to the problem (and patch!) reported by =
Juan RP 3<br>
days ago?<br>
<br>
<a href=3D"http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/02=
7606.html" target=3D"_blank">http://lists.lm-sensors.org/pipermail/lm-senso=
rs/2010-January/027606.html</a><br>
<br>
--<br>
<font color=3D"#888888">Jean Delvare<br>
</font></blockquote></div><br>That patch worked great, even on 2.6.31-gento=
o-r6 (offset -222 lines). Now the module loads and &#39;sensors&#39; shows =
all the connected devices. Thanks for all your help!<br><br>Sincerely,<br>
<br>Karl Newman<br>

--00504502e18c6e1b59047d37ea4b--


--===============1531118104710169117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1531118104710169117==--
