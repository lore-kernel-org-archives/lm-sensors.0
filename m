From: nima chavooshi <nima0102@gmail.com>
Date: Wed, 16 Dec 2009 23:21:51 +0000
Subject: Re: [lm-sensors] Temperature for AMD Phenum ll X4 955 with
Message-Id: <e37498430912161509j53dadf7bh7c510c46ecc0f80c@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6036282060187559310=="
List-Id: <lm-sensors.vger.kernel.org>
References: <e37498430912050507t7324549du284eaf9c046a58d@mail.gmail.com>
In-Reply-To: <e37498430912050507t7324549du284eaf9c046a58d@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6036282060187559310==
Content-Type: multipart/alternative; boundary=0016e6d99f38926e0f047ae09a10

--0016e6d99f38926e0f047ae09a10
Content-Type: text/plain; charset=UTF-8

Thanks for announcement and developing
Can I apply that patch on 2.6.30-2??
May you give some information about F71889FG? what thing does this chip
monitor ??
The link for F71889FG is corrupted!!

Best Regards

On Mon, Dec 14, 2009 at 1:20 PM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Nima,
>
> On Sat, 5 Dec 2009 16:37:35 +0330, nima chavooshi wrote:
> > First of all thanks for your efforts on lm-sensor
> > I recently bought and AMD Phenum ll X4 955 with motherboard MSI
> 790FX-GD70.
> > I have some widget on KDE that show temperature for GPU and CPU, but
> these
> > widgets can not display for CPU.
> > What module should I install for get information about temperature of my
> CPU
> > ? Of course I have run sensor-detects script and have got this result :
> > *Driver `to-be-written':
> >   * Chip `AMD K10 thermal sensors' (confidence: 9)
> >   * ISA bus, address 0x600
> >     Chip `Fintek F71889FG Super IO Sensors' (confidence: 9)
> >
> > Note: there is no driver for AMD K10 thermal sensors yet.*
> >
> > May any one guide me for address this problem ?
>
> There will be a new driver in kernel 2.6.33 for this CPU family. Until
> it gets merged, the patch is there:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-k10temp-new-driver.patch
>
> Support for the F71889FG was merged last week:
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7669896f499e1bce5cfb38f2685ff583ecdb24dd
>
> So you'll need kernel 2.6.33 for this system, once it is released (in
> ~3 months.) If you have the possibility to test the drivers before that
> and to report, that would be great.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>
>


-- 
N.Chavoshi

--0016e6d99f38926e0f047ae09a10
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<span>Thanks for announcement </span>and developing <br>

Can I apply that patch on 2.6.30-2??<br>

May you give some information about F71889FG? what thing does this chip mon=
itor ??<br>

The link for F71889FG is corrupted!!<br>


<br>

Best Regards<br><br><div class=3D"gmail_quote">On Mon, Dec 14, 2009 at 1:20=
 PM, Jean Delvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.or=
g">khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">
Hi Nima,<br>
<div><div></div><div class=3D"h5"><br>
On Sat, 5 Dec 2009 16:37:35 +0330, nima chavooshi wrote:<br>
&gt; First of all thanks for your efforts on lm-sensor<br>
&gt; I recently bought and AMD Phenum ll X4 955 with motherboard MSI 790FX-=
GD70.<br>
&gt; I have some widget on KDE that show temperature for GPU and CPU, but t=
hese<br>
&gt; widgets can not display for CPU.<br>
&gt; What module should I install for get information about temperature of =
my CPU<br>
&gt; ? Of course I have run sensor-detects script and have got this result =
:<br>
&gt; *Driver `to-be-written&#39;:<br>
&gt; =C2=A0 * Chip `AMD K10 thermal sensors&#39; (confidence: 9)<br>
&gt; =C2=A0 * ISA bus, address 0x600<br>
&gt; =C2=A0 =C2=A0 Chip `Fintek F71889FG Super IO Sensors&#39; (confidence:=
 9)<br>
&gt;<br>
&gt; Note: there is no driver for AMD K10 thermal sensors yet.*<br>
&gt;<br>
&gt; May any one guide me for address this problem ?<br>
<br>
</div></div>There will be a new driver in kernel 2.6.33 for this CPU family=
. Until<br>
it gets merged, the patch is there:<br>
<a href=3D"ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/=
jdelvare-hwmon/hwmon-k10temp-new-driver.patch" target=3D"_blank">ftp://ftp.=
kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-=
k10temp-new-driver.patch</a><br>

<br>
Support for the F71889FG was merged last week:<br>
<a href=3D"http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.g=
it;a=3Dcommit;h=3D7669896f499e1bce5cfb38f2685ff583ecdb24dd" target=3D"_blan=
k">http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dc=
ommit;h=3D7669896f499e1bce5cfb38f2685ff583ecdb24dd</a><br>

<br>
So you&#39;ll need kernel 2.6.33 for this system, once it is released (in<b=
r>
~3 months.) If you have the possibility to test the drivers before that<br>
and to report, that would be great.<br>
<font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
<a href=3D"http://khali.linux-fr.org/wishlist.html" target=3D"_blank">http:=
//khali.linux-fr.org/wishlist.html</a><br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>N.Chavoshi<br>

--0016e6d99f38926e0f047ae09a10--


--===============6036282060187559310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6036282060187559310==--
