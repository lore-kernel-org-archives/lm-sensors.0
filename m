From: Wayne Tams <wayne.tams@gmail.com>
Date: Fri, 12 Aug 2011 14:53:50 +0000
Subject: Re: [lm-sensors] How can I use two command bytes for a block read?
Message-Id: <CAN=k24=VfcbWZqWLo_yaaSs-GKrMAAdU=SH1G060ABG-4RE_gw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4117647274644727637=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAN=k24me3-OrpzHBww2J2_x62+iDtSRBTHwGH7pZ4RMqxSgpFA@mail.gmail.com>
	<20110812142951.GA23938@ericsson.com>
In-Reply-To: <20110812142951.GA23938@ericsson.com>
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: linux-i2c@vger.kernel.org, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

--===============4117647274644727637==
Content-Type: multipart/alternative; boundary=0016e6471b281196e004aa5016c3

--0016e6471b281196e004aa5016c3
Content-Type: text/plain; charset=ISO-8859-1

Oops apologies, though your advice helped, problem solved.

Thanks

Wayne

On Fri, Aug 12, 2011 at 3:29 PM, Guenter Roeck
<guenter.roeck@ericsson.com>wrote:

> On Fri, Aug 12, 2011 at 05:21:15AM -0400, Wayne Tams wrote:
> > Hi,
> >
> > I am having a little bother interfacing with a device that requires two
> command
> > bytes for both reads and writes. I can perform a successful write using
> I2C
> > writes but I would rather use the user-space i2c_smbus_ functions from
> > i2c-dev.h. In the i2c-dev documentation (
> http://lxr.free-electrons.com/source/
> > Documentation/i2c/smbus-protocol?v=2.6.35;a=arm#L225) there is a mention
> of a
> > two byte command block read but there does not appear to be any
> supporting
> > function in i2c-dev.h. Is there a patch available to add this
> functionality or
> > could there be another approach?
> >
> > Just to clarify I need my smbus read transaction to look like this:
> >
> >
> >
> >  S Addr Wr [A] Comm1 [A] Comm2 [A] S Addr Rd [A] [Data] A [Data] A ... A
> [Data] NA P
> >
> > Thanks
> >
> > Wayne
>
> Wrong mailing list. Try linux-i2c@vger.kernel.org (copied).
>
> As a general hint, eeprom drivers such as drivers/misc/eeprom/at24.c do
> this;
> you might want to have a look.
>
> Guenter
>
>

--0016e6471b281196e004aa5016c3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Oops apologies, though your advice helped, problem solved.<div><br></div><d=
iv>Thanks</div><div><br></div><div>Wayne<br><br><div class=3D"gmail_quote">=
On Fri, Aug 12, 2011 at 3:29 PM, Guenter Roeck <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@ericsson.com</a>&gt;<=
/span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div><div></div><div class=3D"h5">On Fri, A=
ug 12, 2011 at 05:21:15AM -0400, Wayne Tams wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I am having a little bother interfacing with a device that requires tw=
o command<br>
&gt; bytes for both reads and writes. I can perform a successful write usin=
g I2C<br>
&gt; writes but I would rather use the user-space i2c_smbus_ functions from=
<br>
&gt; i2c-dev.h. In the i2c-dev documentation (<a href=3D"http://lxr.free-el=
ectrons.com/source/" target=3D"_blank">http://lxr.free-electrons.com/source=
/</a><br>
&gt; Documentation/i2c/smbus-protocol?v=3D2.6.35;a=3Darm#L225) there is a m=
ention of a<br>
&gt; two byte command block read but there does not appear to be any suppor=
ting<br>
&gt; function in i2c-dev.h. Is there a patch available to add this function=
ality or<br>
&gt; could there be another approach?<br>
&gt;<br>
&gt; Just to clarify I need my smbus read transaction to look like this:<br=
>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0S Addr Wr [A] Comm1 [A] Comm2 [A] S Addr Rd [A] [Data] A [Data] A .=
.. A [Data] NA P<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; Wayne<br>
<br>
</div></div>Wrong mailing list. Try <a href=3D"mailto:linux-i2c@vger.kernel=
.org">linux-i2c@vger.kernel.org</a> (copied).<br>
<br>
As a general hint, eeprom drivers such as drivers/misc/eeprom/at24.c do thi=
s;<br>
you might want to have a look.<br>
<font color=3D"#888888"><br>
Guenter<br>
<br>
</font></blockquote></div><br></div>

--0016e6471b281196e004aa5016c3--


--===============4117647274644727637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4117647274644727637==--
