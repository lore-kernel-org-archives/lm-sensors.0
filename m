From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Mon, 02 Jan 2012 11:00:35 +0000
Subject: Re: [lm-sensors] i2c errors while updating sensors
Message-Id: <CACW_hTZvG6Mj6n+J0uwuhH+0pu7ssOx7nyWboO=83+J9zg3hRw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2976303837650948413=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CACW_hTZsv2LQmjDYWoU715cmodvdyx2Nkem18GuN+WPvFRRbUw@mail.gmail.com>
In-Reply-To: <CACW_hTZsv2LQmjDYWoU715cmodvdyx2Nkem18GuN+WPvFRRbUw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2976303837650948413==
Content-Type: multipart/alternative; boundary=20cf30780d1af465b804b5897d5f

--20cf30780d1af465b804b5897d5f
Content-Type: text/plain; charset=ISO-8859-1

Guenter,

Thanks for your reply!
I didn't get to implementing this before the Xmas holiday, but have picked
it up today.
(btw. All the best for 2012 for all readers).

See below for some remarks.

2011/12/23 Guenter Roeck <guenter.roeck@ericsson.com>

> Hi Frans,
>
> On Fri, Dec 23, 2011 at 09:44:35AM -0500, Frans Meulenbroeks wrote:
> > I was peeking at lm75/lm80 i2c error message handing.
> >
> > The problem I am facing is that I am using lm75 for temperature
> monitoring and
> > lm80 for temperature and fan tacho monitoring.
> > This is an embedded (powerpc) system using a 2.6.38 kernel, and
> accessing the
> > sensors through the sysfs interface.
> >
> > The customer wants to be able to detect if someone accidently
> disconnects the
> > fan (or the monitoring chip dies).
> > I know i2c is not hot pluggable, but would have expected to be able to
> detect
> > this error condition
> >
> > However, from peeking at the sources, it seems I am not.
> >
> >
> > lm75.c says (function lm75_update_device)
> >         for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
> >             int status;
> >
> >             status = lm75_read_value(client, LM75_REG_TEMP[i]);
> >             if (status < 0)
> >                 dev_dbg(&client->dev, "reg %d, err %d\n",
> >                         LM75_REG_TEMP[i], status);
> >             else
> >                 data->temp[i] = status;
> >         }
> >         data->last_updated = jiffies;
> >         data->valid = 1;
> > So there is an error message if dbg is on, but a user will still get the
> old
> > data as temp[i] is not updated.
> >
> > Wouldn't it be nice to e.g. add a (bool) attribute data-valid or or so
> and drop
> > that to 0 on a read fail (or maybe 3 subsequent read fails)?
>
> data->valid typically already exists.
>
> > Or is there a better way do detect such a problem in user space (e.g. by
> > putting an "error" value in the var)
> >
> > I've also peeked at lm80.c
> > Here the situation seems to be a little bit worse.
> > E.g. I see:
> >
> > static int lm80_read_value(struct i2c_client *client, u8 reg)
> > {
> >     return i2c_smbus_read_byte_data(client, reg);
> > }
> >
> > ...
> >
> >         data->temp =
> >             (lm80_read_value(client, LM80_REG_TEMP) << 8) |
> >             (lm80_read_value(client, LM80_REG_RES) & 0xf0);
> >
> > but i2c_smbus_read_byte_data may return a negative value upon error.
> > To me it seems this is not going to return a sensible value in case the
> read
> > fails (and also not e.g. something like -1)
> >
> > Is this desired? Should this be fixed? Or is there a better way to do so?
>
> No, yes, and yes.
>

Ok, I'll bite and give it a stab.

>
> Note that returning -1 is not a good idea; one should pass on the error
> code.
>
> > If needed, I can have a stab at the code to fix it, but in that case I
> would
> > appreciate some guidance in the direction of the preferred solution (so
> my work
> > is not rejected because it was felt a faulty solution).
> >
> There are multiple options. The easiest would be to set data->valid to 0
> and return
> the error from the _update_device() function. So you would have
>
>        if (status < 0) {
>                data->valid = 0;
>                return status;
>        }
>
> in the update_device() function, and
>
>        struct lm75_data *data = lm75_update_device(dev);
>
>        if (IS_ERR(data))
>                return PTR_ERR(data);
>
>        ...
>
> in the _get() function.
>
> Downside is that each read will return an error, even if the read failed
> on an attribute
> which is not currently read. ltc4261.c is an example for this kind of
> handling.
>

Thanks. I've implemented this in the same way as ltc4261.c did.
I will supply a patch in a short while.
Not too sure what kernel git I should use to base this patch on.
I will be using git://
git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git as that is
listed as the hwmon staging tree. Hope that is ok.

I also noticed that ltc4261 is not setting data->valid to 0 in case of an
error. This seems a good addition so I'll add a patch for that.

>
> Another approach would be to store the actual error in the temp[] array,
> and make it an int
> instead of u16/u8.
>
>        int temp[3];
>
>        ...
>
>        data->temp[i] = lm75_read_value(client, LM75_REG_TEMP[i]);
>
>        ...
>
>        int temp = LM75_TEMP_FROM_REG(data->temp[attr->index]);
>
>        if (temp < 0)
>                return temp;
>        return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(temp));
>
> More effort and more code, but more accurately reports errors. With this
> approach,
> you would have to make sure that u8/u16 <-> int conversions don't
> introduce errors;
> the arithmetic in some drivers depends on the type of the storage variable.
> Example for this kind of solution is max16065.c.
>
> Which approach to use really depends on the chip and on the amount of
> effort one wants
> to make. I typically select the first approach for simple chips, and use
> the second
> approach if there is a possibility that the chip returns an error on one
> read but not
> on others. The latter is mostly a concern for microcontroller based i2c
> devices.
>
> For lm75, the first method should be ok. For lm80, you could use both,
> depending how much
> time you want to spend on it. If there is a chance that one read returns
> an error while
> other reads don't, the second approach would be much better.
>

As lm80 is not a micro based i2c dev, I would suspect that a fail apply to
all register reads.
And if a register read fails, even if it is not the register you are
interested in at that moment, it is probably interesting to know as there
is definitely a problem with the device/device communication


>
> If you want to start playing with the lm80 driver, it would be nice if you
> could also
> fix the checkpatch errors and warnings. That should be a separate patch,
> though.
>

Will peek into that too. Will be after the lm80 error patch (as I already
made that one it is more efficient to do the checkfile later)


>
> Thanks,
> Guenter
>
> Best regards, Frans

--20cf30780d1af465b804b5897d5f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Guenter,<br><br>Thanks for your reply!<br>I didn&#39;t get to implementing =
this before the Xmas holiday, but have picked it up today.<br>(btw. All the=
 best for 2012 for all readers).<br><br>See below for some remarks.<br><br>
<div class=3D"gmail_quote">2011/12/23 Guenter Roeck <span dir=3D"ltr">&lt;<=
a href=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@ericsson.com</a>=
&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
Hi Frans,<br>
<div><div class=3D"h5"><br>
On Fri, Dec 23, 2011 at 09:44:35AM -0500, Frans Meulenbroeks wrote:<br>
&gt; I was peeking at lm75/lm80 i2c error message handing.<br>
&gt;<br>
&gt; The problem I am facing is that I am using lm75 for temperature monito=
ring and<br>
&gt; lm80 for temperature and fan tacho monitoring.<br>
&gt; This is an embedded (powerpc) system using a 2.6.38 kernel, and access=
ing the<br>
&gt; sensors through the sysfs interface.<br>
&gt;<br>
&gt; The customer wants to be able to detect if someone accidently disconne=
cts the<br>
&gt; fan (or the monitoring chip dies).<br>
&gt; I know i2c is not hot pluggable, but would have expected to be able to=
 detect<br>
&gt; this error condition<br>
&gt;<br>
&gt; However, from peeking at the sources, it seems I am not.<br>
&gt;<br>
&gt;<br>
&gt; lm75.c says (function lm75_update_device)<br>
&gt; =A0 =A0 =A0 =A0 for (i =3D 0; i &lt; ARRAY_SIZE(data-&gt;temp); i++) {=
<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 int status;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 status =3D lm75_read_value(client, LM75_REG_TE=
MP[i]);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 if (status &lt; 0)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&amp;client-&gt;dev, &quot;reg=
 %d, err %d\n&quot;,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LM75_REG_TEMP[i], stat=
us);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 else<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;temp[i] =3D status;<br>
&gt; =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 =A0 data-&gt;last_updated =3D jiffies;<br>
&gt; =A0 =A0 =A0 =A0 data-&gt;valid =3D 1;<br>
&gt; So there is an error message if dbg is on, but a user will still get t=
he old<br>
&gt; data as temp[i] is not updated.<br>
&gt;<br>
&gt; Wouldn&#39;t it be nice to e.g. add a (bool) attribute data-valid or o=
r so and drop<br>
&gt; that to 0 on a read fail (or maybe 3 subsequent read fails)?<br>
<br>
</div></div>data-&gt;valid typically already exists.<br>
<div class=3D"im"><br>
&gt; Or is there a better way do detect such a problem in user space (e.g. =
by<br>
&gt; putting an &quot;error&quot; value in the var)<br>
&gt;<br>
&gt; I&#39;ve also peeked at lm80.c<br>
&gt; Here the situation seems to be a little bit worse.<br>
&gt; E.g. I see:<br>
&gt;<br>
&gt; static int lm80_read_value(struct i2c_client *client, u8 reg)<br>
&gt; {<br>
&gt; =A0 =A0 return i2c_smbus_read_byte_data(client, reg);<br>
&gt; }<br>
&gt;<br>
&gt; ...<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 data-&gt;temp =3D<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 (lm80_read_value(client, LM80_REG_TEMP) &lt;&l=
t; 8) |<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 (lm80_read_value(client, LM80_REG_RES) &amp; 0=
xf0);<br>
&gt;<br>
&gt; but i2c_smbus_read_byte_data may return a negative value upon error.<b=
r>
&gt; To me it seems this is not going to return a sensible value in case th=
e read<br>
&gt; fails (and also not e.g. something like -1)<br>
&gt;<br>
&gt; Is this desired? Should this be fixed? Or is there a better way to do =
so?<br>
<br>
</div>No, yes, and yes.<br></blockquote><div><br>Ok, I&#39;ll bite and give=
 it a stab. <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt=
 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Note that returning -1 is not a good idea; one should pass on the error cod=
e.<br>
<div class=3D"im"><br>
&gt; If needed, I can have a stab at the code to fix it, but in that case I=
 would<br>
&gt; appreciate some guidance in the direction of the preferred solution (s=
o my work<br>
&gt; is not rejected because it was felt a faulty solution).<br>
&gt;<br>
</div>There are multiple options. The easiest would be to set data-&gt;vali=
d to 0 and return<br>
the error from the _update_device() function. So you would have<br>
<br>
 =A0 =A0 =A0 =A0if (status &lt; 0) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data-&gt;valid =3D 0;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return status;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
in the update_device() function, and<br>
<br>
 =A0 =A0 =A0 =A0struct lm75_data *data =3D lm75_update_device(dev);<br>
<br>
 =A0 =A0 =A0 =A0if (IS_ERR(data))<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTR_ERR(data);<br>
<br>
 =A0 =A0 =A0 =A0...<br>
<br>
in the _get() function.<br>
<br>
Downside is that each read will return an error, even if the read failed on=
 an attribute<br>
which is not currently read. ltc4261.c is an example for this kind of handl=
ing.<br></blockquote><div><br>Thanks. I&#39;ve implemented this in the same=
 way as ltc4261.c did.<br>I will supply a patch in a short while.<br>Not to=
o sure what kernel git I should use to base this patch on.<br>
I will be using git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel=
/git/groeck/linux-staging.git">git.kernel.org/pub/scm/linux/kernel/git/groe=
ck/linux-staging.git</a> as that is listed as the hwmon staging tree. Hope =
that is ok.<br>
<br>I also noticed that ltc4261 is not setting data-&gt;valid to 0 in case =
of an error. This seems a good addition so I&#39;ll add a patch for that.<b=
r> </div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">

<br>
Another approach would be to store the actual error in the temp[] array, an=
d make it an int<br>
instead of u16/u8.<br>
<br>
 =A0 =A0 =A0 =A0int temp[3];<br>
<br>
 =A0 =A0 =A0 =A0...<br>
<br>
 =A0 =A0 =A0 =A0data-&gt;temp[i] =3D lm75_read_value(client, LM75_REG_TEMP[=
i]);<br>
<br>
 =A0 =A0 =A0 =A0...<br>
<br>
 =A0 =A0 =A0 =A0int temp =3D LM75_TEMP_FROM_REG(data-&gt;temp[attr-&gt;inde=
x]);<br>
<br>
 =A0 =A0 =A0 =A0if (temp &lt; 0)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return temp;<br>
 =A0 =A0 =A0 =A0return sprintf(buf, &quot;%d\n&quot;, LM75_TEMP_FROM_REG(te=
mp));<br>
<br>
More effort and more code, but more accurately reports errors. With this ap=
proach,<br>
you would have to make sure that u8/u16 &lt;-&gt; int conversions don&#39;t=
 introduce errors;<br>
the arithmetic in some drivers depends on the type of the storage variable.=
<br>
Example for this kind of solution is max16065.c.<br>
<br>
Which approach to use really depends on the chip and on the amount of effor=
t one wants<br>
to make. I typically select the first approach for simple chips, and use th=
e second<br>
approach if there is a possibility that the chip returns an error on one re=
ad but not<br>
on others. The latter is mostly a concern for microcontroller based i2c dev=
ices.<br>
<br>
For lm75, the first method should be ok. For lm80, you could use both, depe=
nding how much<br>
time you want to spend on it. If there is a chance that one read returns an=
 error while<br>
other reads don&#39;t, the second approach would be much better.<br></block=
quote><div><br>As lm80 is not a micro based i2c dev, I would suspect that a=
 fail apply to all register reads.<br>And if a register read fails, even if=
 it is not the register you are interested in at that moment, it is probabl=
y interesting to know as there is definitely a problem with the device/devi=
ce communication<br>
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
If you want to start playing with the lm80 driver, it would be nice if you =
could also<br>
fix the checkpatch errors and warnings. That should be a separate patch, th=
ough.<br></blockquote><div><br>Will peek into that too. Will be after the l=
m80 error patch (as I already made that one it is more efficient to do the =
checkfile later)<br>
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Guenter<br>
<br>
</blockquote></div>Best regards, Frans<br>

--20cf30780d1af465b804b5897d5f--


--===============2976303837650948413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2976303837650948413==--
