From: Mark Fern <markfern@austin.rr.com>
Date: Sat, 18 Aug 2012 21:20:25 +0000
Subject: Re: [lm-sensors] [Module] hwmon: GM/GME965 GM45 and more chips IGP thermal report
Message-Id: <CAK74vu+aqpvbnf2RTykp_sgw_3924qLfKJR91_=obnqv5=69tQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3837133514386024110=="
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0907180440p43b81f33x85c4dc70007165b3@mail.gmail.com>
In-Reply-To: <73511e6c0907180440p43b81f33x85c4dc70007165b3@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============3837133514386024110==
Content-Type: multipart/alternative; boundary=90e6ba53aba458914c04c790d850

--90e6ba53aba458914c04c790d850
Content-Type: text/plain; charset=ISO-8859-1

Thank you.   I'll use the instructions.
On Aug 18, 2012 1:08 PM, "Guenter Roeck" <linux@roeck-us.net> wrote:

> On Sat, Aug 18, 2012 at 10:51:45AM -0700, Guenter Roeck wrote:
> > On Sat, Aug 18, 2012 at 11:44:43AM -0500, Mark Fern wrote:
> > > Hello.  I have an HP Dv4 laptop with the 'coretemp' sensors.  It runs
> hot
> > > because Ubuntu 1204 doesn't have the acpi driver.  I'm relatively new
> to
> > > linux, so I need some instruction on how to install the driver you
> created.
> > >  Do I need to un-TAR it, and then what do I do with it?  I'm happy to
> read
> > > and learn if you want to send some links, and I do appreciate your
> help.
> > >  Thank you.
> > >
> > What driver specifically do you refer to that is not in Ubuntu 12.4 ?
> >
> Never mind, searching for the headline helped.
>
> This should work:
>         wget
> http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20090718/58aad378/attachment-0001.gz
>         gunzip attachment-0001.gz
>         tar xf attachment-0001
>         cd gm965temp-module
>         make
>         sudo make install
>         sudo modprobe gm965temp
>
> No idea what that has to do with ACPI, though.
>
> Guenter
>

--90e6ba53aba458914c04c790d850
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Thank you.=A0=A0 I&#39;ll use the instructions. </p>
<div class=3D"gmail_quote">On Aug 18, 2012 1:08 PM, &quot;Guenter Roeck&quo=
t; &lt;<a href=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a>&gt; wro=
te:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On Sat, Aug 18, 2012 at 10:51:45AM -0700, Guenter Roeck wrote:<br>
&gt; On Sat, Aug 18, 2012 at 11:44:43AM -0500, Mark Fern wrote:<br>
&gt; &gt; Hello. =A0I have an HP Dv4 laptop with the &#39;coretemp&#39; sen=
sors. =A0It runs hot<br>
&gt; &gt; because Ubuntu 1204 doesn&#39;t have the acpi driver. =A0I&#39;m =
relatively new to<br>
&gt; &gt; linux, so I need some instruction on how to install the driver yo=
u created.<br>
&gt; &gt; =A0Do I need to un-TAR it, and then what do I do with it? =A0I&#3=
9;m happy to read<br>
&gt; &gt; and learn if you want to send some links, and I do appreciate you=
r help.<br>
&gt; &gt; =A0Thank you.<br>
&gt; &gt;<br>
&gt; What driver specifically do you refer to that is not in Ubuntu 12.4 ?<=
br>
&gt;<br>
Never mind, searching for the headline helped.<br>
<br>
This should work:<br>
=A0 =A0 =A0 =A0 wget <a href=3D"http://lists.lm-sensors.org/pipermail/lm-se=
nsors/attachments/20090718/58aad378/attachment-0001.gz" target=3D"_blank">h=
ttp://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20090718/58aad3=
78/attachment-0001.gz</a><br>

=A0 =A0 =A0 =A0 gunzip attachment-0001.gz<br>
=A0 =A0 =A0 =A0 tar xf attachment-0001<br>
=A0 =A0 =A0 =A0 cd gm965temp-module<br>
=A0 =A0 =A0 =A0 make<br>
=A0 =A0 =A0 =A0 sudo make install<br>
=A0 =A0 =A0 =A0 sudo modprobe gm965temp<br>
<br>
No idea what that has to do with ACPI, though.<br>
<br>
Guenter<br>
</blockquote></div>

--90e6ba53aba458914c04c790d850--


--===============3837133514386024110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3837133514386024110==--
