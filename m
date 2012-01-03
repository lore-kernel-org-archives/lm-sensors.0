From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 03 Jan 2012 22:17:01 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error
Message-Id: <CACW_hTbTPHPkTDkMLA7nZsfQ__Pd=kfPo1YPrDZMY6pLGb2f4g@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4112344418536019500=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============4112344418536019500==
Content-Type: multipart/alternative; boundary=20cf30780d1af6911404b5a70eb9

--20cf30780d1af6911404b5a70eb9
Content-Type: text/plain; charset=ISO-8859-1

2012/1/3 Guenter Roeck <guenter.roeck@ericsson.com>

> Hi Frans,
>
> On Tue, 2012-01-03 at 05:32 -0500, Frans Meulenbroeks wrote:
> > Hi Guenter,
> >
> > Thanks for your replies.
> >
> > Let me answer all of your replies in one go:
> >
> > lm75.c: will fix
> >
> > checkpatch issue: I used checkfile, not checkpatch (actually I was
> > unaware of checkpatch -f and without -f it does say it is not a
> > unified diff and no other messages)
> > checkpatch -f indeed reports errors, I'll give this another stab.
> >
> Where do you get checkfile from ? Doesn't seem to exist, at least not in
> the latest kernel.
>

Misremembered the name (and didn't look it up when typing the message).
The script I used was cleanfile not checkfile

(and apologies for the mistakes, I'm still fairly new at the process of
submitting patches; thanks for your patience).

>
> .
> >
> > If something like
> > rv = helperfunc(client, reg1, valptr1);
> > if (!rv)
> >    rv = helperfunc(client, reg2, valptr2);
> > if (!rv)
> >    rv = helperfunc(client, reg3, valptr3);
> >
> > is ok, I think I could come up with a small helper func and avoid that
> > things become too wieldy and unreadable.
> > Is this acceptable wrt coding style.
> > (and maybe it has to be if (rv < 0) or so but I hope you get the idea)
> >
> How about something like
>
>        rv = helperfunc(client, reg, &val);
>        if (rv)
>                goto abort;
>        ...
>        goto done;
>
> abort:
>        ret = ERR_PTR(rv);
>        data->valid = 0;
> done:
>        mutex_unlock(&data->update_lock);
>        return ret;
>
> or
>
>        rv = read(client, reg);
>        if (rv < 0)
>                goto abort;
>        storage = rv;
>
> followed by the rest of the code above, to avoid the helper function.
>

Yeah, this is probably the simplest.
It would requre some temporary vars as there is code form the form temp =
(read(client, reg1) << 8) | read(client, reg2)
but that is no problem.

Having been educated by Edsger "goto considered harmful" Dijkstra, I have
some internal barriers against the use of goto, but  I think in this case I
can warrant it for myself.

>
> [ ... ]
>
> >
> >
> >         On a side note, this means the chip will only get
> >         (re-)initialized if polled again.
> >         Is that ok for your application ? Not that any alternatives
> >         would be easy to implement - a cleaner
> >         solution would be for your system to detect that the device
> >         was pulled, unload the driver if that
> >         happens, and reload it once the device is re-inserted. At
> >         least this is how we handle it in our
> >         systems.
> >
> > Hm, yes.
> > For our app this is ok. I poll the device every second.
> > And as it stands there is not really a mechanism to detect that the
> > device was pulled (apart from read operations to the device failing)
> > (at least not in our system).
> >
> > In our system the LM80 is with the fan unit and if the fan unit is
> > removed also the LM80 is disconnected. I2C is of course not hot
> > pluggable, and actually we state in the documentation that fans are
> > not hot swappable, but we want to be able to properly deal with the
> > situation of a user does (as irrespective of what the manual says,
> > someone is going to do this anyway).
> >
> > If you feel there is a better solution without changing the hardware
> > interface, I'd like to hear from you as I am always eager to improve
> > things.
> >
>
> Depends on how your polling works. You might do something like
>
>    while (true) {
>        error = poll_lm80();
>        if (error) {
>                scream and log event;
>                unload lm80 driver;
>                do {
>                        sleep(1);
>                        error = read_i2c_register(bus, addr, reg);
>                        // use i2cget if this is a script
>                }  while (error);
>                load lm80 driver;
>        }
>        sleep(1);
>    }
>
> Of course that only works if you only have a single lm80 in your system,
> and if you build the lm80 driver as module.
>

I've been pondering about using a module (currnently we don't). Also there
might (and probably will) be two lm80's in the system.

solution could be to unload and reload the driver when I detect the chip is
back again. Then again I'm not 100% sure if read_i2c_register works for me,
as I am on powerpc having this chip mapped in the device tree.
Haven't tried it with an lm sensor, but noticed that mapped gpio chips are
locked by the system and cannot be called using i2c-get


As we poll the device anyway, I guess I'm best off leaving things as they
are. (with reinitialisation if data->valid == 0), taking also into account
that this is not supposed to happen anyway.

Thanks for your suggestions!
Frans

--20cf30780d1af6911404b5a70eb9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/1/3 Guenter Roeck <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@ericsson.c=
om</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi Frans,<br>
<div class=3D"im"><br>
On Tue, 2012-01-03 at 05:32 -0500, Frans Meulenbroeks wrote:<br>
&gt; Hi Guenter,<br>
&gt;<br>
&gt; Thanks for your replies.<br>
&gt;<br>
&gt; Let me answer all of your replies in one go:<br>
&gt;<br>
&gt; lm75.c: will fix<br>
&gt;<br>
&gt; checkpatch issue: I used checkfile, not checkpatch (actually I was<br>
&gt; unaware of checkpatch -f and without -f it does say it is not a<br>
&gt; unified diff and no other messages)<br>
&gt; checkpatch -f indeed reports errors, I&#39;ll give this another stab.<=
br>
&gt;<br>
</div>Where do you get checkfile from ? Doesn&#39;t seem to exist, at least=
 not in<br>
the latest kernel.<br></blockquote><div><br>Misremembered the name (and did=
n&#39;t look it up when typing the message).<br>The script I used was clean=
file not checkfile<br><br>(and apologies for the mistakes, I&#39;m still fa=
irly new at the process of submitting patches; thanks for your patience). <=
br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<div><div class=3D"h5"><br>
.<br>
&gt;<br>
&gt; If something like<br>
&gt; rv =3D helperfunc(client, reg1, valptr1);<br>
&gt; if (!rv)<br>
&gt; =A0 =A0rv =3D helperfunc(client, reg2, valptr2);<br>
&gt; if (!rv)<br>
&gt; =A0 =A0rv =3D helperfunc(client, reg3, valptr3);<br>
&gt;<br>
&gt; is ok, I think I could come up with a small helper func and avoid that=
<br>
&gt; things become too wieldy and unreadable.<br>
&gt; Is this acceptable wrt coding style.<br>
&gt; (and maybe it has to be if (rv &lt; 0) or so but I hope you get the id=
ea)<br>
&gt;<br>
</div></div>How about something like<br>
<br>
 =A0 =A0 =A0 =A0rv =3D helperfunc(client, reg, &amp;val);<br>
 =A0 =A0 =A0 =A0if (rv)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto abort;<br>
 =A0 =A0 =A0 =A0...<br>
 =A0 =A0 =A0 =A0goto done;<br>
<br>
abort:<br>
 =A0 =A0 =A0 =A0ret =3D ERR_PTR(rv);<br>
 =A0 =A0 =A0 =A0data-&gt;valid =3D 0;<br>
done:<br>
 =A0 =A0 =A0 =A0mutex_unlock(&amp;data-&gt;update_lock);<br>
 =A0 =A0 =A0 =A0return ret;<br>
<br>
or<br>
<br>
 =A0 =A0 =A0 =A0rv =3D read(client, reg);<br>
 =A0 =A0 =A0 =A0if (rv &lt; 0)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto abort;<br>
 =A0 =A0 =A0 =A0storage =3D rv;<br>
<br>
followed by the rest of the code above, to avoid the helper function.<br></=
blockquote><div><br>Yeah, this is probably the simplest. <br>It would requr=
e some temporary vars as there is code form the form temp =3D (read(client,=
 reg1) &lt;&lt; 8) | read(client, reg2)<br>
but that is no problem.<br><br>Having been educated by Edsger &quot;goto co=
nsidered harmful&quot; Dijkstra, I have some internal barriers against the =
use of goto, but=A0 I think in this case I can warrant it for myself.<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
[ ... ]<br>
<div class=3D"im"><br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 On a side note, this means the chip will only get<br>
&gt; =A0 =A0 =A0 =A0 (re-)initialized if polled again.<br>
&gt; =A0 =A0 =A0 =A0 Is that ok for your application ? Not that any alterna=
tives<br>
&gt; =A0 =A0 =A0 =A0 would be easy to implement - a cleaner<br>
&gt; =A0 =A0 =A0 =A0 solution would be for your system to detect that the d=
evice<br>
&gt; =A0 =A0 =A0 =A0 was pulled, unload the driver if that<br>
&gt; =A0 =A0 =A0 =A0 happens, and reload it once the device is re-inserted.=
 At<br>
&gt; =A0 =A0 =A0 =A0 least this is how we handle it in our<br>
&gt; =A0 =A0 =A0 =A0 systems.<br>
&gt;<br>
&gt; Hm, yes.<br>
&gt; For our app this is ok. I poll the device every second.<br>
&gt; And as it stands there is not really a mechanism to detect that the<br=
>
&gt; device was pulled (apart from read operations to the device failing)<b=
r>
&gt; (at least not in our system).<br>
&gt;<br>
&gt; In our system the LM80 is with the fan unit and if the fan unit is<br>
&gt; removed also the LM80 is disconnected. I2C is of course not hot<br>
&gt; pluggable, and actually we state in the documentation that fans are<br=
>
&gt; not hot swappable, but we want to be able to properly deal with the<br=
>
&gt; situation of a user does (as irrespective of what the manual says,<br>
&gt; someone is going to do this anyway).<br>
&gt;<br>
&gt; If you feel there is a better solution without changing the hardware<b=
r>
&gt; interface, I&#39;d like to hear from you as I am always eager to impro=
ve<br>
&gt; things.<br>
&gt;<br>
<br>
</div>Depends on how your polling works. You might do something like<br>
<br>
 =A0 =A0while (true) {<br>
 =A0 =A0 =A0 =A0error =3D poll_lm80();<br>
 =A0 =A0 =A0 =A0if (error) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0scream and log event;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unload lm80 driver;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sleep(1);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D read_i2c_register=
(bus, addr, reg);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0// use i2cget if this is a =
script<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} =A0while (error);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0load lm80 driver;<br>
 =A0 =A0 =A0 =A0}<br>
 =A0 =A0 =A0 =A0sleep(1);<br>
 =A0 =A0}<br>
<br>
Of course that only works if you only have a single lm80 in your system,<br=
>
and if you build the lm80 driver as module.<br></blockquote><div><br>I&#39;=
ve been pondering about using a module (currnently we don&#39;t). Also ther=
e might (and probably will) be two lm80&#39;s in the system.<br><br>solutio=
n could be to unload and reload the driver when I detect the chip is back a=
gain. Then again I&#39;m not 100% sure if read_i2c_register works for me, a=
s I am on powerpc having this chip mapped in the device tree.<br>
Haven&#39;t tried it with an lm sensor, but noticed that mapped gpio chips =
are locked by the system and cannot be called using i2c-get<br></div></div>=
<br><br>
As we poll the device anyway, I guess I&#39;m best off leaving things as th=
ey are. (with reinitialisation if data-&gt;valid =3D=3D 0), taking also int=
o account that this is not supposed to happen anyway.<br><br>Thanks for you=
r suggestions!<br>
Frans<br>

--20cf30780d1af6911404b5a70eb9--


--===============4112344418536019500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4112344418536019500==--
