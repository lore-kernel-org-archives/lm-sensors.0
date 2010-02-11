From: "D. Can Celasun" <dcelasun@gmail.com>
Date: Thu, 11 Feb 2010 07:33:06 +0000
Subject: Re: [lm-sensors] Core i3 support?
Message-Id: <d35bed621002102333i701a212re957efb600cbda5f@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6013602416614271128=="
List-Id: <lm-sensors.vger.kernel.org>
References: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
In-Reply-To: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6013602416614271128==
Content-Type: multipart/alternative; boundary=00148530ac639fef06047f4e2a0e

--00148530ac639fef06047f4e2a0e
Content-Type: text/plain; charset=ISO-8859-1

Relevant sensors-detect output:

Do you want to probe the I2C/SMBus adapters now? (YES/no):
Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.
Sorry, no supported PCI bus adapters found.
Module i2c-dev loaded successfully.



On 11 February 2010 03:21, Darrick J. Wong <djwong@us.ibm.com> wrote:

> On Wed, Feb 10, 2010 at 10:23:00PM +0200, D. Can Celasun wrote:
> > On 10 February 2010 21:40, Jean Delvare <khali@linux-fr.org> wrote:
> >
> > > > On 10 February 2010 20:01, Darrick J. Wong <djwong@us.ibm.com>
> wrote:
> > > > > You might also try the i2c-scmi driver.... if the BIOS is set up
> > > correctly.
> > > > > I don't remember when it went in the kernel other than it was in
> the
> > > > > 2.6.32/33
> > > > > timeframe.
> > >
> > > The i2c-scmi driver was added in the 2.6.32 kernel.
> > >
> > > On Wed, 10 Feb 2010 20:07:44 +0200, D. Can Celasun wrote:
> > > > I can load the i2c-scmi driver, here is the relevant kernel log:
> > > >
> > > > Feb 10 20:04:52 dcclinux kernel: i2c /dev entries driver
> > >
> > > This message is from i2c-dev, not i2c-scmi.
> > >
> > > Then i2c-scmi doesn't raise any messages in kernel log.
>
> Does sensors-detect/i2cdetect find anything on either i2c controller?
>
> --D
>

--00148530ac639fef06047f4e2a0e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Relevant sensors-detect output:<br><br>Do you want to probe the I2C/SMBus a=
dapters now? (YES/no): <br>Found unknown SMBus adapter 8086:3b30 at 0000:00=
:1f.3.<br>Sorry, no supported PCI bus adapters found.<br>Module i2c-dev loa=
ded successfully.<br>

<br><br><br><div class=3D"gmail_quote">On 11 February 2010 03:21, Darrick J=
. Wong <span dir=3D"ltr">&lt;<a href=3D"mailto:djwong@us.ibm.com">djwong@us=
.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); p=
adding-left: 1ex;">

<div><div></div><div class=3D"h5">On Wed, Feb 10, 2010 at 10:23:00PM +0200,=
 D. Can Celasun wrote:<br>
&gt; On 10 February 2010 21:40, Jean Delvare &lt;<a href=3D"mailto:khali@li=
nux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; &gt; On 10 February 2010 20:01, Darrick J. Wong &lt;<a href=3D"ma=
ilto:djwong@us.ibm.com">djwong@us.ibm.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; You might also try the i2c-scmi driver.... if the BIOS =
is set up<br>
&gt; &gt; correctly.<br>
&gt; &gt; &gt; &gt; I don&#39;t remember when it went in the kernel other t=
han it was in the<br>
&gt; &gt; &gt; &gt; 2.6.32/33<br>
&gt; &gt; &gt; &gt; timeframe.<br>
&gt; &gt;<br>
&gt; &gt; The i2c-scmi driver was added in the 2.6.32 kernel.<br>
&gt; &gt;<br>
&gt; &gt; On Wed, 10 Feb 2010 20:07:44 +0200, D. Can Celasun wrote:<br>
&gt; &gt; &gt; I can load the i2c-scmi driver, here is the relevant kernel =
log:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Feb 10 20:04:52 dcclinux kernel: i2c /dev entries driver<br>
&gt; &gt;<br>
&gt; &gt; This message is from i2c-dev, not i2c-scmi.<br>
&gt; &gt;<br>
&gt; &gt; Then i2c-scmi doesn&#39;t raise any messages in kernel log.<br>
<br>
</div></div>Does sensors-detect/i2cdetect find anything on either i2c contr=
oller?<br>
<font color=3D"#888888"><br>
--D<br>
</font></blockquote></div><br>

--00148530ac639fef06047f4e2a0e--


--===============6013602416614271128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6013602416614271128==--
