From: "D. Can Celasun" <dcelasun@gmail.com>
Date: Wed, 10 Feb 2010 18:07:44 +0000
Subject: Re: [lm-sensors] Core i3 support?
Message-Id: <d35bed621002101007y639fd3c7k736ef53ff400f79@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7447572674112603885=="
List-Id: <lm-sensors.vger.kernel.org>
References: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
In-Reply-To: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7447572674112603885==
Content-Type: multipart/alternative; boundary=001636c5bc026a1353047f42ea39

--001636c5bc026a1353047f42ea39
Content-Type: text/plain; charset=ISO-8859-1

I can load the i2c-scmi driver, here is the relevant kernel log:

Feb 10 20:04:52 dcclinux kernel: i2c /dev entries driver


On 10 February 2010 20:01, Darrick J. Wong <djwong@us.ibm.com> wrote:

> On Wed, Feb 10, 2010 at 05:03:00PM +0200, D. Can Celasun wrote:
> > Here's the relevant output:
> >
> > Feb 10 17:00:49 dcclinux kernel: ACPI: I/O resource 0000:00:1f.3
> > [0x1840-0x185f] conflicts with ACPI region SMBI [0x1840-0x184f]
> > Feb 10 17:00:49 dcclinux kernel: ACPI: If an ACPI driver is available for
> > this device, you should use it instead of the native driver
> >
> > So I guess that's it for the SMBus. I'll be waiting for a coretemp patch
> for
> > the cpu.
>
> You might also try the i2c-scmi driver.... if the BIOS is set up correctly.
> I don't remember when it went in the kernel other than it was in the
> 2.6.32/33
> timeframe.
>
> --D
>

--001636c5bc026a1353047f42ea39
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I can load the i2c-scmi driver, here is the relevant kernel log:<br><br>Feb=
 10 20:04:52 dcclinux kernel: i2c /dev entries driver<br>
<br><br><div class=3D"gmail_quote">On 10 February 2010 20:01, Darrick J. Wo=
ng <span dir=3D"ltr">&lt;<a href=3D"mailto:djwong@us.ibm.com">djwong@us.ibm=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding=
-left: 1ex;">

<div class=3D"im">On Wed, Feb 10, 2010 at 05:03:00PM +0200, D. Can Celasun =
wrote:<br>
&gt; Here&#39;s the relevant output:<br>
&gt;<br>
&gt; Feb 10 17:00:49 dcclinux kernel: ACPI: I/O resource 0000:00:1f.3<br>
&gt; [0x1840-0x185f] conflicts with ACPI region SMBI [0x1840-0x184f]<br>
&gt; Feb 10 17:00:49 dcclinux kernel: ACPI: If an ACPI driver is available =
for<br>
&gt; this device, you should use it instead of the native driver<br>
&gt;<br>
&gt; So I guess that&#39;s it for the SMBus. I&#39;ll be waiting for a core=
temp patch for<br>
&gt; the cpu.<br>
<br>
</div>You might also try the i2c-scmi driver.... if the BIOS is set up corr=
ectly.<br>
I don&#39;t remember when it went in the kernel other than it was in the 2.=
6.32/33<br>
timeframe.<br>
<font color=3D"#888888"><br>
--D<br>
</font></blockquote></div><br>

--001636c5bc026a1353047f42ea39--


--===============7447572674112603885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7447572674112603885==--
