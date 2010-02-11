From: "D. Can Celasun" <dcelasun@gmail.com>
Date: Thu, 11 Feb 2010 16:42:28 +0000
Subject: Re: [lm-sensors] Core i3 support?
Message-Id: <d35bed621002110842h54c8185fqf3bf481ad63df7bf@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0075665562989574714=="
List-Id: <lm-sensors.vger.kernel.org>
References: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
In-Reply-To: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0075665562989574714==
Content-Type: multipart/alternative; boundary=000e0cdf93e6529d10047f55d734

--000e0cdf93e6529d10047f55d734
Content-Type: text/plain; charset=ISO-8859-1

On 11 February 2010 10:17, Jean Delvare <khali@linux-fr.org> wrote:

> > On 11 February 2010 03:21, Darrick J. Wong <djwong@us.ibm.com> wrote:
> > > Does sensors-detect/i2cdetect find anything on either i2c controller?
>
> On Thu, 11 Feb 2010 09:33:06 +0200, D. Can Celasun wrote:
> > Relevant sensors-detect output:
> >
> > Do you want to probe the I2C/SMBus adapters now? (YES/no):
> > Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.
> > Sorry, no supported PCI bus adapters found.
> > Module i2c-dev loaded successfully.
>
> At that time, the i2c-i801 driver was loaded but not the i2c-scmi
> driver. The i2c-i801 driver is hopeless (can't bind to the device). You
> could try loading the i2c-scmi driver manually and running
> sensors-detect again.
>
> Tried that, doesn't make any difference.


> Darrick, any chance we could get the i2c-scmi driver to load
> automatically on systems which need it?
>
> --
> Jean Delvare
>

--000e0cdf93e6529d10047f55d734
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On 11 February 2010 10:17, Jean Delvare =
<span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.=
org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-=
left: 1ex;">

<div class=3D"im">&gt; On 11 February 2010 03:21, Darrick J. Wong &lt;<a hr=
ef=3D"mailto:djwong@us.ibm.com">djwong@us.ibm.com</a>&gt; wrote:<br>
</div><div class=3D"im">&gt; &gt; Does sensors-detect/i2cdetect find anythi=
ng on either i2c controller?<br>
<br>
</div><div class=3D"im">On Thu, 11 Feb 2010 09:33:06 +0200, D. Can Celasun =
wrote:<br>
&gt; Relevant sensors-detect output:<br>
&gt;<br>
&gt; Do you want to probe the I2C/SMBus adapters now? (YES/no):<br>
&gt; Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.<br>
&gt; Sorry, no supported PCI bus adapters found.<br>
&gt; Module i2c-dev loaded successfully.<br>
<br>
</div>At that time, the i2c-i801 driver was loaded but not the i2c-scmi<br>
driver. The i2c-i801 driver is hopeless (can&#39;t bind to the device). You=
<br>
could try loading the i2c-scmi driver manually and running<br>
sensors-detect again.<br>
<br></blockquote><div>Tried that, doesn&#39;t make any difference.<br>=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; b=
order-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Darrick, any chance we could get the i2c-scmi driver to load<br>
automatically on systems which need it?<br>
<br>
--<br>
<font color=3D"#888888">Jean Delvare<br>
</font></blockquote></div><br>

--000e0cdf93e6529d10047f55d734--


--===============0075665562989574714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0075665562989574714==--
