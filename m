From: Sasikanth babu <sasikanth.v19@gmail.com>
Date: Thu, 14 Jun 2012 09:47:58 +0000
Subject: Re: [lm-sensors] lm75_remove: LM75 Device remove using sysfs delete_device
Message-Id: <CAOJFanUP212SE4kM_Q77J84sVm00P0nByywTj1Ywo07qbS6gxQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0873346211257664848=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
In-Reply-To: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0873346211257664848==
Content-Type: multipart/alternative; boundary=047d7b15a97358d7ff04c26b6d6f

--047d7b15a97358d7ff04c26b6d6f
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Jun 14, 2012 at 12:37 AM, Guenter Roeck
<guenter.roeck@ericsson.com>wrote:

> On Wed, Jun 13, 2012 at 01:59:50PM -0400, Jean Delvare wrote:
> > On Wed, 13 Jun 2012 21:52:02 +0530, Sasikanth babu wrote:
> > > Yes, as you had mentioned we just backported I2c mux support.
> > > I planning to use
> > > linux-2.6.39.4.tar.bz2<
> http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.39.4.tar.bz2>kernel
> > > (Since I cant go to 3.x kernels for now).
> > > Is that version is fine with I2c mux devices or do I have to go with
> 3.x
> > > kernels.?
> >
> > 2.6.39.4 should work fine with regards to i2c muxing, however this
> > branch is already out of maintenance while the 3.0 branch is a longterm
> > branch so it will be maintained for some more time (not sure exactly
> > how long though.) So if 3.0 is an option, you should consider it
> seriously.
> >
> I definitely agree, but that smells like large company process to me.
> Sasikanth may not have much of a choice.
>
> Guenter
>

Sorry guys for bothering you again

 I was running 2.6.39.4 kernel now.  Software reboot always creating
problems with LM75 device and saying address
 is busy but with hardware reboot It works fine (since all the power to
board gets resets)

 Added a error message on failure of * i2c_check_addr_busy.*

*        /* Check for address business */
        status = i2c_check_addr_busy(adap, client->addr);
        if (status) {
             dev_err(&adap->dev, "Address Busy to register i2c client %s at
0x%02x "
                "(%d)\n", client->name, client->addr, status);

                goto out_err;
        }*


* i2c i2c-3: Address Busy to register i2c client lm75 at 0x4c (-16)*
 i2c i2c-3: Failed to register i2c client lm75 at 0x4c (-16)
*i2c i2c-3: Address Busy to register i2c client lm75 at 0x4b (-16)*
i2c i2c-3: Failed to register i2c client lm75 at 0x4b (-16)

Thanks
Sasi

--047d7b15a97358d7ff04c26b6d6f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">On Thu, Jun 14, 2012 at=
 12:37 AM, Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:guenter.ro=
eck@ericsson.com" target=3D"_blank">guenter.roeck@ericsson.com</a>&gt;</spa=
n> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On W=
ed, Jun 13, 2012 at 01:59:50PM -0400, Jean Delvare wrote:<br>
&gt; On Wed, 13 Jun 2012 21:52:02 +0530, Sasikanth babu wrote:<br>
&gt; &gt; Yes, as you had mentioned we just backported I2c mux support.<br>
&gt; &gt; I planning to use<br>
&gt; &gt; linux-2.6.39.4.tar.bz2&lt;<a href=3D"http://www.kernel.org/pub/li=
nux/kernel/v2.6/linux-2.6.39.4.tar.bz2" target=3D"_blank">http://www.kernel=
.org/pub/linux/kernel/v2.6/linux-2.6.39.4.tar.bz2</a>&gt;kernel<br>
&gt; &gt; (Since I cant go to 3.x kernels for now).<br>
&gt; &gt; Is that version is fine with I2c mux devices or do I have to go w=
ith 3.x<br>
&gt; &gt; kernels.?<br>
&gt;<br>
&gt; 2.6.39.4 should work fine with regards to i2c muxing, however this<br>
&gt; branch is already out of maintenance while the 3.0 branch is a longter=
m<br>
&gt; branch so it will be maintained for some more time (not sure exactly<b=
r>
&gt; how long though.) So if 3.0 is an option, you should consider it serio=
usly.<br>
&gt;<br>
</div></div>I definitely agree, but that smells like large company process =
to me.<br>
Sasikanth may not have much of a choice.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br></font></span></blockquote><div><br>Sorry guys for bothering you=
 again<br><br>=A0I was running 2.6.39.4 kernel now.=A0 Software reboot alwa=
ys creating problems with LM75 device and saying address<br>=A0is busy but =
with hardware reboot It works fine (since all the power to board gets reset=
s)<br>
<br>=A0Added a error message on failure of <b> i2c_check_addr_busy.</b><br>=
=A0<br><b>=A0=A0=A0=A0=A0=A0=A0 /* Check for address business */<br>=A0=A0=
=A0=A0=A0=A0=A0 status =3D i2c_check_addr_busy(adap, client-&gt;addr);<br>=
=A0=A0=A0=A0=A0=A0=A0 if (status) {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 dev_err(&amp;adap-&gt;dev, &quot;Address Busy to register i2c client %s at=
 0x%02x &quot;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &quot;(%d)\n&quot;, client-&g=
t;name, client-&gt;addr, status);<br><br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 goto out_err;<br>=A0=A0=A0=A0=A0=A0=A0 }</b><br><br><br><b>=A0=
i2c i2c-3: Address Busy to register i2c client lm75 at 0x4c (-16)</b>=A0 <b=
r>
=A0i2c i2c-3: Failed to register i2c client lm75 at 0x4c (-16)<br><b>i2c i2=
c-3: Address Busy to register i2c client lm75 at 0x4b (-16)</b><br>i2c i2c-=
3: Failed to register i2c client lm75 at 0x4b (-16)<br>=A0<br></div></div>T=
hanks<br>
Sasi<br></div>

--047d7b15a97358d7ff04c26b6d6f--


--===============0873346211257664848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0873346211257664848==--
