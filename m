From: "D. Can Celasun" <dcelasun@gmail.com>
Date: Wed, 10 Feb 2010 20:23:00 +0000
Subject: Re: [lm-sensors] Core i3 support?
Message-Id: <d35bed621002101223ida7758fp5ccbedfe25bd3148@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8697361342902491217=="
List-Id: <lm-sensors.vger.kernel.org>
References: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
In-Reply-To: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============8697361342902491217==
Content-Type: multipart/alternative; boundary=00c09f8c230b338998047f44ceb3

--00c09f8c230b338998047f44ceb3
Content-Type: text/plain; charset=ISO-8859-1

On 10 February 2010 21:40, Jean Delvare <khali@linux-fr.org> wrote:

> > On 10 February 2010 20:01, Darrick J. Wong <djwong@us.ibm.com> wrote:
> > > You might also try the i2c-scmi driver.... if the BIOS is set up
> correctly.
> > > I don't remember when it went in the kernel other than it was in the
> > > 2.6.32/33
> > > timeframe.
>
> The i2c-scmi driver was added in the 2.6.32 kernel.
>
> On Wed, 10 Feb 2010 20:07:44 +0200, D. Can Celasun wrote:
> > I can load the i2c-scmi driver, here is the relevant kernel log:
> >
> > Feb 10 20:04:52 dcclinux kernel: i2c /dev entries driver
>
> This message is from i2c-dev, not i2c-scmi.
>
> Then i2c-scmi doesn't raise any messages in kernel log.

> --
> Jean Delvare
>

--00c09f8c230b338998047f44ceb3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><br><div class=3D"gmail_quote">On 10 February 2010 21:40, Jean Delv=
are <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux=
-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padd=
ing-left: 1ex;">

<div class=3D"im">&gt; On 10 February 2010 20:01, Darrick J. Wong &lt;<a hr=
ef=3D"mailto:djwong@us.ibm.com">djwong@us.ibm.com</a>&gt; wrote:<br>
</div><div class=3D"im">&gt; &gt; You might also try the i2c-scmi driver...=
. if the BIOS is set up correctly.<br>
&gt; &gt; I don&#39;t remember when it went in the kernel other than it was=
 in the<br>
&gt; &gt; 2.6.32/33<br>
&gt; &gt; timeframe.<br>
<br>
</div>The i2c-scmi driver was added in the 2.6.32 kernel.<br>
<div class=3D"im"><br>
On Wed, 10 Feb 2010 20:07:44 +0200, D. Can Celasun wrote:<br>
&gt; I can load the i2c-scmi driver, here is the relevant kernel log:<br>
&gt;<br>
&gt; Feb 10 20:04:52 dcclinux kernel: i2c /dev entries driver<br>
<br>
</div>This message is from i2c-dev, not i2c-scmi.<br>
<br></blockquote><div>Then i2c-scmi doesn&#39;t raise any messages in kerne=
l log. <br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt=
 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


--<br>
<font color=3D"#888888">Jean Delvare<br>
</font></blockquote></div><br>

--00c09f8c230b338998047f44ceb3--


--===============8697361342902491217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8697361342902491217==--
