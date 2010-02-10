From: "D. Can Celasun" <dcelasun@gmail.com>
Date: Wed, 10 Feb 2010 15:03:00 +0000
Subject: Re: [lm-sensors] Core i3 support?
Message-Id: <d35bed621002100703s52296ad0v53fe375f777e55ee@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1718405473573830683=="
List-Id: <lm-sensors.vger.kernel.org>
References: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
In-Reply-To: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============1718405473573830683==
Content-Type: multipart/alternative; boundary=001636c5a7c7c171b4047f4055bc

--001636c5a7c7c171b4047f4055bc
Content-Type: text/plain; charset=ISO-8859-1

Here's the relevant output:

Feb 10 17:00:49 dcclinux kernel: ACPI: I/O resource 0000:00:1f.3
[0x1840-0x185f] conflicts with ACPI region SMBI [0x1840-0x184f]
Feb 10 17:00:49 dcclinux kernel: ACPI: If an ACPI driver is available for
this device, you should use it instead of the native driver

So I guess that's it for the SMBus. I'll be waiting for a coretemp patch for
the cpu.

Thanks for the help.


On 10 February 2010 16:44, Jean Delvare <khali@linux-fr.org> wrote:

> On Wed, 10 Feb 2010 15:42:44 +0200, D. Can Celasun wrote:
> > Seems like I'll be waiting for an updated coretemp.
> >
> > As for the kernel logs, couldn't see anything relevant but in case I'm
> > missing something, kernel log is attached.
>
> The kernel log doesn't seem to contain all the messages since last
> boot. You should be able to regenerate the relevant messages by
> unloading the i2c-i801 driver and loading it again.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

--001636c5a7c7c171b4047f4055bc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Here&#39;s the relevant output:<br><br>Feb 10 17:00:49 dcclinux kernel: ACP=
I: I/O resource 0000:00:1f.3 [0x1840-0x185f] conflicts with ACPI region SMB=
I [0x1840-0x184f]<br>Feb 10 17:00:49 dcclinux kernel: ACPI: If an ACPI driv=
er is available for this device, you should use it instead of the native dr=
iver<br>

<br>So I guess that&#39;s it for the SMBus. I&#39;ll be waiting for a coret=
emp patch for the cpu.<br><br>Thanks for the help.<br>
<br><br><div class=3D"gmail_quote">On 10 February 2010 16:44, Jean Delvare =
<span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.=
org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-=
left: 1ex;">

<div class=3D"im">On Wed, 10 Feb 2010 15:42:44 +0200, D. Can Celasun wrote:=
<br>
&gt; Seems like I&#39;ll be waiting for an updated coretemp.<br>
&gt;<br>
&gt; As for the kernel logs, couldn&#39;t see anything relevant but in case=
 I&#39;m<br>
&gt; missing something, kernel log is attached.<br>
<br>
</div>The kernel log doesn&#39;t seem to contain all the messages since las=
t<br>
boot. You should be able to regenerate the relevant messages by<br>
unloading the i2c-i801 driver and loading it again.<br>
<font color=3D"#888888"><br>
--<br>
</font><div><div></div><div class=3D"h5">Jean Delvare<br>
<a href=3D"http://khali.linux-fr.org/wishlist.html" target=3D"_blank">http:=
//khali.linux-fr.org/wishlist.html</a><br>
</div></div></blockquote></div><br>

--001636c5a7c7c171b4047f4055bc--


--===============1718405473573830683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1718405473573830683==--
