From: Sasikanth babu <sasikanth.v19@gmail.com>
Date: Thu, 14 Jun 2012 13:52:27 +0000
Subject: Re: [lm-sensors] lm75_remove: LM75 Device remove using sysfs delete_device
Message-Id: <CAOJFanV_qA5AKHydztwTDhjdCoNMATUwxexBYmtNhV2yUBmPkg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7196970738234526103=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
In-Reply-To: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7196970738234526103==
Content-Type: multipart/alternative; boundary=047d7b33d8a6ae8fc504c26ed70f

--047d7b33d8a6ae8fc504c26ed70f
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Jun 14, 2012 at 3:05 PM, Sasikanth babu <sasikanth.v19@gmail.com>wrote:

>
>
> On Thu, Jun 14, 2012 at 12:37 AM, Guenter Roeck <
> guenter.roeck@ericsson.com> wrote:
>
>> On Wed, Jun 13, 2012 at 01:59:50PM -0400, Jean Delvare wrote:
>> > On Wed, 13 Jun 2012 21:52:02 +0530, Sasikanth babu wrote:
>> > > Yes, as you had mentioned we just backported I2c mux support.
>> > > I planning to use
>> > > linux-2.6.39.4.tar.bz2<
>> http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.39.4.tar.bz2>kernel
>> > > (Since I cant go to 3.x kernels for now).
>> > > Is that version is fine with I2c mux devices or do I have to go with
>> 3.x
>> > > kernels.?
>> >
>> > 2.6.39.4 should work fine with regards to i2c muxing, however this
>> > branch is already out of maintenance while the 3.0 branch is a longterm
>> > branch so it will be maintained for some more time (not sure exactly
>> > how long though.) So if 3.0 is an option, you should consider it
>> seriously.
>> >
>> I definitely agree, but that smells like large company process to me.
>> Sasikanth may not have much of a choice.
>>
>> Guenter
>>
>
> Sorry guys for bothering you again
>
>  I was running 2.6.39.4 kernel now.  Software reboot always creating
> problems with LM75 device and saying address
>  is busy but with hardware reboot It works fine (since all the power to
> board gets resets)
>
>  Added a error message on failure of * i2c_check_addr_busy.*
>
> *        /* Check for address business */
>         status = i2c_check_addr_busy(adap, client->addr);
>         if (status) {
>              dev_err(&adap->dev, "Address Busy to register i2c client %s
> at 0x%02x "
>                 "(%d)\n", client->name, client->addr, status);
>
>                 goto out_err;
>         }*
>
>
> * i2c i2c-3: Address Busy to register i2c client lm75 at 0x4c (-16)*
>  i2c i2c-3: Failed to register i2c client lm75 at 0x4c (-16)
> *i2c i2c-3: Address Busy to register i2c client lm75 at 0x4b (-16)*
> i2c i2c-3: Failed to register i2c client lm75 at 0x4b (-16)
>
> Thanks
> Sasi
>

After making the following changes, It is working fine on soft reboot too.

diff -urpN orig/linux-2.6.39.4/drivers/i2c/muxes/pca954x.c
linux-2.6.39.4/drivers/i2c/muxes/pca954x.c
--- orig/linux-2.6.39.4/drivers/i2c/muxes/pca954x.c     2011-08-03
15:43:28.000000000 -0400
+++ linux-2.6.39.4/drivers/i2c/muxes/pca954x.c  2012-06-14
08:37:52.572107218 -0400
@@ -174,6 +174,7 @@ static int pca954x_deselect_mux(struct i
        struct pca954x *data = i2c_get_clientdata(client);

        /* Deselect active channel */
+       printk (KERN_INFO"pca954x_deselect_mux: called ...\n");
        data->last_chan = 0;
        return pca954x_reg_write(adap, client, data->last_chan);
 }
@@ -228,8 +229,7 @@ static int pca954x_probe(struct i2c_clie
                data->virt_adaps[num] =
                        i2c_add_mux_adapter(adap, client,
                                force, num, pca954x_select_chan,
*-                               (pdata &&
pdata->modes[num].deselect_on_exit)
-                                       ? pca954x_deselect_mux : NULL);
+                               pca954x_deselect_mux);*

                if (data->virt_adaps[num] == NULL) {
                        ret = -ENODEV;

No one  is setting the "deselect_on_exit" for pca954x devices (verified in
3.5.0-rc2 too). Does the* pca954x_deselect_mux *not required for PCA mux
devices* *for every bus transfer?*.


*Thanks
Sasi*
*

--047d7b33d8a6ae8fc504c26ed70f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">On Thu, Jun 14, 2012 at=
 3:05 PM, Sasikanth babu <span dir=3D"ltr">&lt;<a href=3D"mailto:sasikanth.=
v19@gmail.com" target=3D"_blank">sasikanth.v19@gmail.com</a>&gt;</span> wro=
te:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><br><br><div class=3D"gmail=
_quote"><div><div class=3D"h5">On Thu, Jun 14, 2012 at 12:37 AM, Guenter Ro=
eck <span dir=3D"ltr">&lt;<a href=3D"mailto:guenter.roeck@ericsson.com" tar=
get=3D"_blank">guenter.roeck@ericsson.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div>On Wed, Jun 13, 2012 at 01:59:50PM=
 -0400, Jean Delvare wrote:<br>
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
<span><font color=3D"#888888"><br>
Guenter<br></font></span></blockquote></div></div><div><br>Sorry guys for b=
othering you again<br><br>=A0I was running 2.6.39.4 kernel now.=A0 Software=
 reboot always creating problems with LM75 device and saying address<br>=A0=
is busy but with hardware reboot It works fine (since all the power to boar=
d gets resets)<br>

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
3: Failed to register i2c client lm75 at 0x4b (-16)<br>=A0<br></div></div>
Thanks<br>
Sasi<br></div>
</blockquote></div><br>After making the following changes, It is working fi=
ne on soft reboot too.=A0 <br><br>diff -urpN orig/linux-2.6.39.4/drivers/i2=
c/muxes/pca954x.c linux-2.6.39.4/drivers/i2c/muxes/pca954x.c<br>--- orig/li=
nux-2.6.39.4/drivers/i2c/muxes/pca954x.c=A0=A0=A0=A0 2011-08-03 15:43:28.00=
0000000 -0400<br>
+++ linux-2.6.39.4/drivers/i2c/muxes/pca954x.c=A0 2012-06-14 08:37:52.57210=
7218 -0400<br>@@ -174,6 +174,7 @@ static int pca954x_deselect_mux(struct i<=
br>=A0=A0=A0=A0=A0=A0=A0 struct pca954x *data =3D i2c_get_clientdata(client=
);<br><br>=A0=A0=A0=A0=A0=A0=A0 /* Deselect active channel */<br>
+=A0=A0=A0=A0=A0=A0 printk (KERN_INFO&quot;pca954x_deselect_mux: called ...=
\n&quot;);<br>=A0=A0=A0=A0=A0=A0=A0 data-&gt;last_chan =3D 0;<br>=A0=A0=A0=
=A0=A0=A0=A0 return pca954x_reg_write(adap, client, data-&gt;last_chan);<br=
>=A0}<br>@@ -228,8 +229,7 @@ static int pca954x_probe(struct i2c_clie<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data-&gt;virt_adaps[num] =3D<=
br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2=
c_add_mux_adapter(adap, client,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 force, num, pca954x_=
select_chan,<br><b>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (pdata &amp;&amp; pdata-&gt;modes[num]=
.deselect_on_exit)<br>
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ? pca954x_deselect_mux : NULL);<=
br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 pca954x_deselect_mux);</b><br><br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (data-&gt;virt_adaps[num] =3D=3D NULL) {<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =
=3D -ENODEV;<br>
<br>No one=A0 is setting the &quot;deselect_on_exit&quot; for pca954x devic=
es (verified in 3.5.0-rc2 too). Does the<b> pca954x_deselect_mux </b>not re=
quired for PCA mux devices<b> </b>for every bus transfer?<b>.<br><br><br>
</b>Thanks<br>Sasi<b><br></b></div>

--047d7b33d8a6ae8fc504c26ed70f--


--===============7196970738234526103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7196970738234526103==--
