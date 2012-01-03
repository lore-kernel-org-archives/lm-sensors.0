From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 03 Jan 2012 10:32:19 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error
Message-Id: <CACW_hTZ+fAuCCMf5KLW-JhyPLKekxROmhfPiVV9ZHNtkrQC4qA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9109427711145338402=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============9109427711145338402==
Content-Type: multipart/alternative; boundary=bcaec54ee65eb38ccb04b59d36fe

--bcaec54ee65eb38ccb04b59d36fe
Content-Type: text/plain; charset=ISO-8859-1

Hi Guenter,

Thanks for your replies.

Let me answer all of your replies in one go:

lm75.c: will fix

checkpatch issue: I used checkfile, not checkpatch (actually I was unaware
of checkpatch -f and without -f it does say it is not a unified diff and no
other messages)
checkpatch -f indeed reports errors, I'll give this another stab.

lm80 comments:

2012/1/2 Guenter Roeck <guenter.roeck@ericsson.com>
[...]


> >
> > +/*
> > +   Note: safe_lm80_read_value is a helper macro for lm80_update_device
> > +      It reads a value using lm80_read_value and jumps to abort
> > +      in case of an error.
> > +      Due to this jump and because it modifies the first arguement
>
>        return sprintf(buf, "%d\n", IN_FROM_REG(data->value[nr])); \
> s/arguement/argument/
>
> > +      it has to be a macro
>
> This is exactly the reason why it should not be a macro: It uses two
> variables
> defined outside the macro, it depends on a label defined outside the macro,
> and it modifies a variable passed to it. Way too many side effects for a
> macro,
> and just asking for trouble later on.
>

I am aware of that. That is why I added the comment and kept the macro
close to the function.

>
> Sure, I understand you want to limit the changes to lm80_update_device,
> but you'll have
> to bite the bullet here. Just make it
>
>        reg = lm80_read_value(client, <reg>);
>        if (reg < 0) {
>                ret = ERR_PTR(reg);
>                data->valid = 0;
>                goto abort;
>        }
>        data-><regstore> = reg;
>
> I don't think the dev_dbg is really needed, since the error will now be
> returned
> to the user anyway.
>

I've thought about that before writing the macro. Issue is that this code
snippet will be about 16 times in this file. That does not really make
things better readable and maintainable.

If something like
rv = helperfunc(client, reg1, valptr1);
if (!rv)
   rv = helperfunc(client, reg2, valptr2);
if (!rv)
   rv = helperfunc(client, reg3, valptr3);

is ok, I think I could come up with a small helper func and avoid that
things become too wieldy and unreadable.
Is this acceptable wrt coding style.
(and maybe it has to be if (rv < 0) or so but I hope you get the idea)

>
> > +*/
> > +#define safe_lm80_read_value(var, client, reg) \
> > +     { \
> > +             status = lm80_read_value(client, reg); \
> > +             if (unlikely(status < 0)) { \
> > +                     dev_dbg(dev, \
> > +                             "LM80: Failed to read value: reg %d, error
> %d\n", \
> > +                             reg, status); \
> > +                     ret = ERR_PTR(status); \
> > +                     data->valid = 0; \
> > +                     goto abort; \
> > +             } \
> > +             else \
> > +                     var = status; \
>
> else statement is not needed.
>
OK

>
> > +     }
> > +
> >  static struct lm80_data *lm80_update_device(struct device *dev)
> >  {
> >       struct i2c_client *client = to_i2c_client(dev);
> >       struct lm80_data *data = i2c_get_clientdata(client);
> > +     struct lm80_data *ret = data;
> >       int i;
> > +     int status;
> > +     int tmp1, tmp2;
> >
> >       mutex_lock(&data->update_lock);
> >
> > +     if (!data->valid)
> > +     {
> > +             /* last time failed: re-initialize the LM80 chip */
> > +             lm80_init_client(client);
> > +     }
>
> { } not needed, and at wrong location anyway (CodingStyle, chapter 3).
> This also duplicates
> 2st-time initialization. One way to avoid that would be to add a second
> state variable
> (such as "error") to cover this case. Might be worth thinking about. Also,
> please add
> an explanation (from your followup e-mail) describing why you do this.
>

Will do

>
> On a side note, this means the chip will only get (re-)initialized if
> polled again.
> Is that ok for your application ? Not that any alternatives would be easy
> to implement - a cleaner
> solution would be for your system to detect that the device was pulled,
> unload the driver if that
> happens, and reload it once the device is re-inserted. At least this is
> how we handle it in our
> systems.
>

Hm, yes.
For our app this is ok. I poll the device every second.
And as it stands there is not really a mechanism to detect that the device
was pulled (apart from read operations to the device failing) (at least not
in our system).

In our system the LM80 is with the fan unit and if the fan unit is removed
also the LM80 is disconnected. I2C is of course not hot pluggable, and
actually we state in the documentation that fans are not hot swappable, but
we want to be able to properly deal with the situation of a user does (as
irrespective of what the manual says, someone is going to do this anyway).

If you feel there is a better solution without changing the hardware
interface, I'd like to hear from you as I am always eager to improve things.

Best regards, Frans

[...]

--bcaec54ee65eb38ccb04b59d36fe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Guenter,<br><br>Thanks for your replies.<br><br>Let me answer all of you=
r replies in one go:<br><br>lm75.c: will fix<br><br>checkpatch issue: I use=
d checkfile, not checkpatch (actually I was unaware of checkpatch -f and wi=
thout -f it does say it is not a unified diff and no other messages)<br>
checkpatch -f indeed reports errors, I&#39;ll give this another stab. <br><=
br>lm80 comments:<br><br><div class=3D"gmail_quote">2012/1/2 Guenter Roeck =
<span dir=3D"ltr">&lt;<a href=3D"mailto:guenter.roeck@ericsson.com">guenter=
.roeck@ericsson.com</a>&gt;</span><br>
<div>[...]<br>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div><div class=3D"h5">
&gt;<br>
&gt; +/*<br>
&gt; + =A0 Note: safe_lm80_read_value is a helper macro for lm80_update_dev=
ice<br>
&gt; + =A0 =A0 =A0It reads a value using lm80_read_value and jumps to abort=
<br>
&gt; + =A0 =A0 =A0in case of an error.<br>
&gt; + =A0 =A0 =A0Due to this jump and because it modifies the first arguem=
ent<br>
<br>
</div></div>=A0=A0 =A0 =A0 return sprintf(buf, &quot;%d\n&quot;, IN_FROM_RE=
G(data-&gt;value[nr])); \<br>s/arguement/argument/<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0it has to be a macro<br>
<br>
</div>This is exactly the reason why it should not be a macro: It uses two =
variables<br>
defined outside the macro, it depends on a label defined outside the macro,=
<br>
and it modifies a variable passed to it. Way too many side effects for a ma=
cro,<br>
and just asking for trouble later on.<br></blockquote><div><br>I am aware o=
f that. That is why I added the comment and kept the macro close to the fun=
ction. <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt =
0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">

<br>
Sure, I understand you want to limit the changes to lm80_update_device, but=
 you&#39;ll have<br>
to bite the bullet here. Just make it<br>
<br>
 =A0 =A0 =A0 =A0reg =3D lm80_read_value(client, &lt;reg&gt;);<br>
 =A0 =A0 =A0 =A0if (reg &lt; 0) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D ERR_PTR(reg);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data-&gt;valid =3D 0;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto abort;<br>
 =A0 =A0 =A0 =A0}<br>
 =A0 =A0 =A0 =A0data-&gt;&lt;regstore&gt; =3D reg;<br>
<br>
I don&#39;t think the dev_dbg is really needed, since the error will now be=
 returned<br>
to the user anyway.<br></blockquote><div><br>I&#39;ve thought about that be=
fore writing the macro. Issue is that this code snippet will be about 16 ti=
mes in this file. That does not really make things better readable and main=
tainable.<br>
<br>If something like<br>rv =3D helperfunc(client, reg1, valptr1);<br>if (!=
rv) <br>=A0=A0 rv =3D helperfunc(client, reg2, valptr2);<br>if (!rv) <br>
=A0=A0 rv =3D helperfunc(client, reg3, valptr3);<br><br>is ok, I think I co=
uld come up with a small helper func and avoid that things become too wield=
y and unreadable.<br>Is this acceptable wrt coding style.<br>(and maybe it =
has to be if (rv &lt; 0) or so but I hope you get the idea)<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D"im"><br>
&gt; +*/<br>
&gt; +#define safe_lm80_read_value(var, client, reg) \<br>
&gt; + =A0 =A0 { \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 status =3D lm80_read_value(client, reg); \<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(status &lt; 0)) { \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;LM80: =
Failed to read value: reg %d, error %d\n&quot;, \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg, status)=
; \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ERR_PTR(status); \<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;valid =3D 0; \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto abort; \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 } \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 else \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var =3D status; \<br>
<br>
</div>else statement is not needed.<br></blockquote><div>OK <br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D"im"><br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; =A0static struct lm80_data *lm80_update_device(struct device *dev)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);<br>
&gt; =A0 =A0 =A0 struct lm80_data *data =3D i2c_get_clientdata(client);<br>
&gt; + =A0 =A0 struct lm80_data *ret =3D data;<br>
&gt; =A0 =A0 =A0 int i;<br>
&gt; + =A0 =A0 int status;<br>
&gt; + =A0 =A0 int tmp1, tmp2;<br>
&gt;<br>
&gt; =A0 =A0 =A0 mutex_lock(&amp;data-&gt;update_lock);<br>
&gt;<br>
&gt; + =A0 =A0 if (!data-&gt;valid)<br>
&gt; + =A0 =A0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 /* last time failed: re-initialize the LM80 =
chip */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 lm80_init_client(client);<br>
&gt; + =A0 =A0 }<br>
<br>
</div>{ } not needed, and at wrong location anyway (CodingStyle, chapter 3)=
. This also duplicates<br>
2st-time initialization. One way to avoid that would be to add a second sta=
te variable<br>
(such as &quot;error&quot;) to cover this case. Might be worth thinking abo=
ut. Also, please add<br>
an explanation (from your followup e-mail) describing why you do this.<br><=
/blockquote><div><br>Will do <br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">

<br>
On a side note, this means the chip will only get (re-)initialized if polle=
d again.<br>
Is that ok for your application ? Not that any alternatives would be easy t=
o implement - a cleaner<br>
solution would be for your system to detect that the device was pulled, unl=
oad the driver if that<br>
happens, and reload it once the device is re-inserted. At least this is how=
 we handle it in our<br>
systems.<br></blockquote><div><br>Hm, yes.<br>For our app this is ok. I pol=
l the device every second.<br>And as it stands there is not really a mechan=
ism to detect that the device was pulled (apart from read operations to the=
 device failing) (at least not in our system).<br>
<br>In our system the LM80 is with the fan unit and if the fan unit is remo=
ved also the LM80 is disconnected. I2C is of course not hot pluggable, and =
actually we state in the documentation that fans are not hot swappable, but=
 we want to be able to properly deal with the situation of a user does (as =
irrespective of what the manual says, someone is going to do this anyway).<=
br>
<br>If you feel there is a better solution without changing the hardware in=
terface, I&#39;d like to hear from you as I am always eager to improve thin=
gs.<br><br>Best regards, Frans<br></div><br></div>[...]<br>

--bcaec54ee65eb38ccb04b59d36fe--


--===============9109427711145338402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9109427711145338402==--
