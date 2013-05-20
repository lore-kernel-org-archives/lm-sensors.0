From: Robert Coulson <rob.coulson@gmail.com>
Date: Mon, 20 May 2013 21:25:51 +0000
Subject: Re: [lm-sensors] sensors-detect:: Drop detection of DS1621-like chips
Message-Id: <CAEZKy8KVNLaYN9Y=rmUR3ixVHX8hHp3rZwpPhTr+dVTGM=AbBg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4562511027495047104=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20130520141525.59931252@endymion.delvare>
In-Reply-To: <20130520141525.59931252@endymion.delvare>
To: lm-sensors@vger.kernel.org

--===============4562511027495047104==
Content-Type: multipart/alternative; boundary=20cf3071cf7e1ea58c04dd2cfaa7

--20cf3071cf7e1ea58c04dd2cfaa7
Content-Type: text/plain; charset=ISO-8859-1

Agreed.

Thank you Jean. Since the ds1621 detection is being dropped, is the
doc/chips/SUMMARY ds1621 reference necessary? If not, then please also
remove it too.

thanks,

Rob.


On Mon, May 20, 2013 at 6:26 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Mon, May 20, 2013 at 02:15:25PM +0200, Jean Delvare wrote:
> > Detection of the Dallas/Maxim DS1621, DS1625 and DS1631 chips is weak
> > and likely to result in false positives. There's no rationale for
> > keeping it in sensors-detect as these chips are not found in desktop
> > computer systems. So drop detection of these chips altogether.
> > ---
>
> Good idea.
>
> Guenter
>
> >  prog/detect/sensors-detect |   46
> ---------------------------------------------
> >  1 file changed, 46 deletions(-)
> >
> > --- lm-sensors.orig/prog/detect/sensors-detect        2013-05-20
> 13:25:33.992641174 +0200
> > +++ lm-sensors/prog/detect/sensors-detect     2013-05-20
> 14:11:21.668063379 +0200
> > @@ -803,11 +803,6 @@ use vars qw(@i2c_adapter_names);
> >               i2c_addrs => [0x2c..0x2f],
> >               i2c_detect => sub { adm9240_detect(@_, 0); },
> >       }, {
> > -             name => "Dallas Semiconductor DS1621/DS1631",
> > -             driver => "ds1621",
> > -             i2c_addrs => [0x48..0x4f],
> > -             i2c_detect => sub { ds1621_detect(@_); },
> > -     }, {
> >               name => "Dallas Semiconductor DS1780",
> >               driver => "adm9240",
> >               i2c_addrs => [0x2c..0x2f],
> > @@ -4357,47 +4352,6 @@ sub lm92_detect
> >       return ($chip == 0) ? 4 : 2;
> >  }
> >
> > -# Registers used:
> > -#   0xAA: Temperature
> > -#   0xA1: High limit
> > -#   0xA2: Low limit
> > -#   0xA8: Counter
> > -#   0xA9: Slope
> > -#   0xAC: Configuration
> > -# Detection is weak. We check if bit 4 (NVB) is clear, because it is
> > -# unlikely to be set (would mean that EEPROM is currently being
> accessed).
> > -# We also check the value of the counter and slope registers, the
> datasheet
> > -# doesn't mention the possible values but the conversion formula
> together
> > -# with experimental evidence suggest possible sanity checks.
> > -# Not all devices enjoy SMBus read word transactions, so we do as much
> as
> > -# possible with read byte transactions first, and only use read word
> > -# transactions second.
> > -sub ds1621_detect
> > -{
> > -     my ($file, $addr) = @_;
> > -
> > -     my $conf = i2c_smbus_read_byte_data($file, 0xAC);
> > -     return if ($conf & 0x10);
> > -
> > -     my $temp = i2c_smbus_read_word_data($file, 0xAA);
> > -     return if $temp < 0 || ($temp & 0x0f00);
> > -     # On the DS1631, the following two checks are too strict in theory,
> > -     # but in practice I very much doubt that anyone will set
> temperature
> > -     # limits not a multiple of 0.5 degrees C.
> > -     my $high = i2c_smbus_read_word_data($file, 0xA1);
> > -     return if $high < 0 || ($high & 0x7f00);
> > -     my $low = i2c_smbus_read_word_data($file, 0xA2);
> > -     return if $low < 0 || ($low & 0x7f00);
> > -
> > -     return if ($temp == 0 && $high == 0 && $low == 0 && $conf == 0);
> > -
> > -     # Old versions of the DS1621 apparently don't have the counter and
> > -     # slope registers (or they return crap)
> > -     my $counter = i2c_smbus_read_byte_data($file, 0xA8);
> > -     my $slope = i2c_smbus_read_byte_data($file, 0xA9);
> > -     return ($slope == 0x10 && $counter <= $slope) ? 3 : 2;
> > -}
> > -
> >  # Chip to detect: 0 = LM80, 1 = LM96080
> >  # Registers used:
> >  #   0x00: Configuration register
> >
> >
> > --
> > Jean Delvare
> >
>

--20cf3071cf7e1ea58c04dd2cfaa7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Agreed.<div><br></div><div>Thank you Jean. Since the ds162=
1 detection is being dropped, is the doc/chips/SUMMARY ds1621 reference nec=
essary? If not, then please also remove it too.</div><div><br></div><div st=
yle>
thanks,</div><div style><br></div><div style>Rob.</div><div><br></div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, May 20, 2013 a=
t 6:26 AM, Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roec=
k-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Mon, May 20, 2013 at 02=
:15:25PM +0200, Jean Delvare wrote:<br>
&gt; Detection of the Dallas/Maxim DS1621, DS1625 and DS1631 chips is weak<=
br>
&gt; and likely to result in false positives. There&#39;s no rationale for<=
br>
&gt; keeping it in sensors-detect as these chips are not found in desktop<b=
r>
&gt; computer systems. So drop detection of these chips altogether.<br>
&gt; ---<br>
<br>
</div>Good idea.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; =A0prog/detect/sensors-detect | =A0 46 -------------------------------=
--------------<br>
&gt; =A01 file changed, 46 deletions(-)<br>
&gt;<br>
&gt; --- lm-sensors.orig/prog/detect/sensors-detect =A0 =A0 =A0 =A02013-05-=
20 13:25:33.992641174 +0200<br>
&gt; +++ lm-sensors/prog/detect/sensors-detect =A0 =A0 2013-05-20 14:11:21.=
668063379 +0200<br>
&gt; @@ -803,11 +803,6 @@ use vars qw(@i2c_adapter_names);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_addrs =3D&gt; [0x2c..0x2f],<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_detect =3D&gt; sub { adm9240_detect(@_=
, 0); },<br>
&gt; =A0 =A0 =A0 }, {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 name =3D&gt; &quot;Dallas Semiconductor DS16=
21/DS1631&quot;,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 driver =3D&gt; &quot;ds1621&quot;,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 i2c_addrs =3D&gt; [0x48..0x4f],<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 i2c_detect =3D&gt; sub { ds1621_detect(@_); =
},<br>
&gt; - =A0 =A0 }, {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D&gt; &quot;Dallas Semiconductor DS=
1780&quot;,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 driver =3D&gt; &quot;adm9240&quot;,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_addrs =3D&gt; [0x2c..0x2f],<br>
&gt; @@ -4357,47 +4352,6 @@ sub lm92_detect<br>
&gt; =A0 =A0 =A0 return ($chip =3D=3D 0) ? 4 : 2;<br>
&gt; =A0}<br>
&gt;<br>
&gt; -# Registers used:<br>
&gt; -# =A0 0xAA: Temperature<br>
&gt; -# =A0 0xA1: High limit<br>
&gt; -# =A0 0xA2: Low limit<br>
&gt; -# =A0 0xA8: Counter<br>
&gt; -# =A0 0xA9: Slope<br>
&gt; -# =A0 0xAC: Configuration<br>
&gt; -# Detection is weak. We check if bit 4 (NVB) is clear, because it is<=
br>
&gt; -# unlikely to be set (would mean that EEPROM is currently being acces=
sed).<br>
&gt; -# We also check the value of the counter and slope registers, the dat=
asheet<br>
&gt; -# doesn&#39;t mention the possible values but the conversion formula =
together<br>
&gt; -# with experimental evidence suggest possible sanity checks.<br>
&gt; -# Not all devices enjoy SMBus read word transactions, so we do as muc=
h as<br>
&gt; -# possible with read byte transactions first, and only use read word<=
br>
&gt; -# transactions second.<br>
&gt; -sub ds1621_detect<br>
&gt; -{<br>
&gt; - =A0 =A0 my ($file, $addr) =3D @_;<br>
&gt; -<br>
&gt; - =A0 =A0 my $conf =3D i2c_smbus_read_byte_data($file, 0xAC);<br>
&gt; - =A0 =A0 return if ($conf &amp; 0x10);<br>
&gt; -<br>
&gt; - =A0 =A0 my $temp =3D i2c_smbus_read_word_data($file, 0xAA);<br>
&gt; - =A0 =A0 return if $temp &lt; 0 || ($temp &amp; 0x0f00);<br>
&gt; - =A0 =A0 # On the DS1631, the following two checks are too strict in =
theory,<br>
&gt; - =A0 =A0 # but in practice I very much doubt that anyone will set tem=
perature<br>
&gt; - =A0 =A0 # limits not a multiple of 0.5 degrees C.<br>
&gt; - =A0 =A0 my $high =3D i2c_smbus_read_word_data($file, 0xA1);<br>
&gt; - =A0 =A0 return if $high &lt; 0 || ($high &amp; 0x7f00);<br>
&gt; - =A0 =A0 my $low =3D i2c_smbus_read_word_data($file, 0xA2);<br>
&gt; - =A0 =A0 return if $low &lt; 0 || ($low &amp; 0x7f00);<br>
&gt; -<br>
&gt; - =A0 =A0 return if ($temp =3D=3D 0 &amp;&amp; $high =3D=3D 0 &amp;&am=
p; $low =3D=3D 0 &amp;&amp; $conf =3D=3D 0);<br>
&gt; -<br>
&gt; - =A0 =A0 # Old versions of the DS1621 apparently don&#39;t have the c=
ounter and<br>
&gt; - =A0 =A0 # slope registers (or they return crap)<br>
&gt; - =A0 =A0 my $counter =3D i2c_smbus_read_byte_data($file, 0xA8);<br>
&gt; - =A0 =A0 my $slope =3D i2c_smbus_read_byte_data($file, 0xA9);<br>
&gt; - =A0 =A0 return ($slope =3D=3D 0x10 &amp;&amp; $counter &lt;=3D $slop=
e) ? 3 : 2;<br>
&gt; -}<br>
&gt; -<br>
&gt; =A0# Chip to detect: 0 =3D LM80, 1 =3D LM96080<br>
&gt; =A0# Registers used:<br>
&gt; =A0# =A0 0x00: Configuration register<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Jean Delvare<br>
&gt;<br>
</div></div></blockquote></div><br></div></div>

--20cf3071cf7e1ea58c04dd2cfaa7--


--===============4562511027495047104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4562511027495047104==--
