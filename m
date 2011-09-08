From: Daniel Schenkenberger <schenkenberger@gmail.com>
Date: Thu, 08 Sep 2011 21:09:48 +0000
Subject: Re: [lm-sensors] Fintek F71862FG Super IO Sensors only shows
Message-Id: <CAPtvKsMx3SeCAL2hg+mtkvygXcyBnE_Lu3o8tSvUtzFeTReS0g@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6092259178366049898=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPtvKsNGD2fY1Fo7BSLRqVVU+92Rh0YyfMbdD2FBFpu=bHhCng@mail.gmail.com>
In-Reply-To: <CAPtvKsNGD2fY1Fo7BSLRqVVU+92Rh0YyfMbdD2FBFpu=bHhCng@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6092259178366049898==
Content-Type: multipart/alternative; boundary=90e6ba6e828616473404ac747bf5

--90e6ba6e828616473404ac747bf5
Content-Type: text/plain; charset=ISO-8859-1

the bios is already up to date. sorry, this is the first time i use a
mailinglist.

2011/9/8 Guenter Roeck <guenter.roeck@ericsson.com>

> On Thu, 2011-09-08 at 16:32 -0400, Hans de Goede wrote:
> > Hi,
> >
> > First of all please those drop the list from the To / CC
> > list, if you start a discussion on the list it is sort
> > of list reader friendly to also finish it there.
> >
> > On 09/08/2011 09:07 PM, Daniel Schenkenberger wrote:
> > > dmesg says:
> > >
> > > [ 216.007958] f71882fg: Found f71862fg chip at 0x290, revision 18
> > > [ 216.008806] ACPI: resource f71882fg [io  0x0290-0x0297] conflicts
> with ACPI r    egion IP__ [io 0x295-0x296]
> > > [ 216.012580] f71882fg f71882fg.656: Invalid (reserved) pwm settings:
> 0x01
> > >
> > > i added "acpi_enforce_resources=lax" to my grub. if i boot without this
> the module won't load.
> >
> > That is not necessarily a good idea, see:
> >
> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
> >
> > To quote myself from that page: "a really bad idea and can cause all sort
> of issues
> > (including things like changing CPU / RAM voltage or clock speed)."
> >
> > So be warned!
> >
> > Now back to the problem, which is:
> > [ 216.012580] f71882fg f71882fg.656: Invalid (reserved) pwm settings:
> 0x01
> >
> > Reading the data sheet, this means that the pwm settings for
> > fan 2 and 3 are: 00 and 00, where as fan 1 has 01. The data sheet gives
> > the following table for these:
> >
> > 00: Reserved
> > 01: Auto fan speed control, fan speed will follow different temperature
> by
> > different duty cycle (voltage) that define in 0xB6-0xBE.
> > 10: Reserved
> > 11: Manual mode fan control, user can write expect duty cycle (PWM fan
> > type) or voltage(linear fan type) to 0xC3, and F71883FG will output this
> > value duty or voltage to control fan speed.
> >
> > Never mind the F71883FG in there, this really if from the F71862FG
> datasheet
> > (copy paste error in the data sheet), see:
> > http://www.fintek.com.tw/eng/products.asp?BID=1&SID=17
> >
> > So the driver bails because something, likely the BIOS on your board has
> > written an illegal value to the Fan mode Select Register.
> >
> > I guess the BIOS only setups fan 1 and the *cough* brilliant *cough* BIOS
> > developers decided to just write 00 as value for the other fans, sigh.
> >
> > There are really 2 things we can do here:
> > 1) Overwrite the BIOS settings, tricky, could do this with a module
> option
> > 2) Instead of not binding the driver at all, allow the driver
> initialization
> > to continue normally, but don't register the pwm interface. This requires
> > some thinking wrt modifying the code a bit though.
> >
> > 1 is a really bad idea IMHO, so I'll think a bit about doing 2.
> >
> Or 2a): Don't create sysfs entries for a fan if its mode value is
> invalid (reserved).
>
> Guenter
>
>
>

--90e6ba6e828616473404ac747bf5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

the bios is already up to date. sorry, this is the first time i use a maili=
nglist.<br><br><div class=3D"gmail_quote">2011/9/8 Guenter Roeck <span dir=
=3D"ltr">&lt;<a href=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@er=
icsson.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div><div></div><div class=3D"h5">On Thu, <=
a href=3D"tel:2011-09-08" value=3D"+4920110908">2011-09-08</a> at 16:32 -04=
00, Hans de Goede wrote:<br>

&gt; Hi,<br>
&gt;<br>
&gt; First of all please those drop the list from the To / CC<br>
&gt; list, if you start a discussion on the list it is sort<br>
&gt; of list reader friendly to also finish it there.<br>
&gt;<br>
&gt; On 09/08/2011 09:07 PM, Daniel Schenkenberger wrote:<br>
&gt; &gt; dmesg says:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"tel:%5B%20%20216.007958" value=3D"+49216007958">[  216=
.007958</a>] f71882fg: Found f71862fg chip at 0x290, revision 18<br>
&gt; &gt; <a href=3D"tel:%5B%20%20216.008806" value=3D"+49216008806">[  216=
.008806</a>] ACPI: resource f71882fg [io =A00x0290-0x0297] conflicts with A=
CPI r =A0 =A0egion IP__ [io 0x295-0x296]<br>
&gt; &gt; <a href=3D"tel:%5B%20%20216.012580" value=3D"+49216012580">[  216=
.012580</a>] f71882fg f71882fg.656: Invalid (reserved) pwm settings: 0x01<b=
r>
&gt; &gt;<br>
&gt; &gt; i added &quot;acpi_enforce_resources=3Dlax&quot; to my grub. if i=
 boot without this the module won&#39;t load.<br>
&gt;<br>
&gt; That is not necessarily a good idea, see:<br>
&gt; <a href=3D"http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavest=
oppedworkinginkernel2.6.31" target=3D"_blank">http://www.lm-sensors.org/wik=
i/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31</a><br>
&gt;<br>
&gt; To quote myself from that page: &quot;a really bad idea and can cause =
all sort of issues<br>
&gt; (including things like changing CPU / RAM voltage or clock speed).&quo=
t;<br>
&gt;<br>
&gt; So be warned!<br>
&gt;<br>
&gt; Now back to the problem, which is:<br>
&gt; <a href=3D"tel:%5B%20%20216.012580" value=3D"+49216012580">[  216.0125=
80</a>] f71882fg f71882fg.656: Invalid (reserved) pwm settings: 0x01<br>
&gt;<br>
&gt; Reading the data sheet, this means that the pwm settings for<br>
&gt; fan 2 and 3 are: 00 and 00, where as fan 1 has 01. The data sheet give=
s<br>
&gt; the following table for these:<br>
&gt;<br>
&gt; 00: Reserved<br>
&gt; 01: Auto fan speed control, fan speed will follow different temperatur=
e by<br>
&gt; different duty cycle (voltage) that define in 0xB6-0xBE.<br>
&gt; 10: Reserved<br>
&gt; 11: Manual mode fan control, user can write expect duty cycle (PWM fan=
<br>
&gt; type) or voltage(linear fan type) to 0xC3, and F71883FG will output th=
is<br>
&gt; value duty or voltage to control fan speed.<br>
&gt;<br>
&gt; Never mind the F71883FG in there, this really if from the F71862FG dat=
asheet<br>
&gt; (copy paste error in the data sheet), see:<br>
&gt; <a href=3D"http://www.fintek.com.tw/eng/products.asp?BID=3D1&amp;SID=
=3D17" target=3D"_blank">http://www.fintek.com.tw/eng/products.asp?BID=3D1&=
amp;SID=3D17</a><br>
&gt;<br>
&gt; So the driver bails because something, likely the BIOS on your board h=
as<br>
&gt; written an illegal value to the Fan mode Select Register.<br>
&gt;<br>
&gt; I guess the BIOS only setups fan 1 and the *cough* brilliant *cough* B=
IOS<br>
&gt; developers decided to just write 00 as value for the other fans, sigh.=
<br>
&gt;<br>
&gt; There are really 2 things we can do here:<br>
&gt; 1) Overwrite the BIOS settings, tricky, could do this with a module op=
tion<br>
&gt; 2) Instead of not binding the driver at all, allow the driver initiali=
zation<br>
&gt; to continue normally, but don&#39;t register the pwm interface. This r=
equires<br>
&gt; some thinking wrt modifying the code a bit though.<br>
&gt;<br>
&gt; 1 is a really bad idea IMHO, so I&#39;ll think a bit about doing 2.<br=
>
&gt;<br>
</div></div>Or 2a): Don&#39;t create sysfs entries for a fan if its mode va=
lue is<br>
invalid (reserved).<br>
<font color=3D"#888888"><br>
Guenter<br>
<br>
<br>
</font></blockquote></div><br>

--90e6ba6e828616473404ac747bf5--


--===============6092259178366049898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6092259178366049898==--
