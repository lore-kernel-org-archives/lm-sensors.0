From: Robert Smith <rs.porsche@gmail.com>
Date: Tue, 29 Jan 2013 18:25:01 +0000
Subject: Re: [lm-sensors] tap SMBus vis PCI slot?
Message-Id: <CAEGEQC+QiyWkUagOGD3b1vjXxNAxHssKbCFdijv6W6e_MQsisQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7461366358464448386=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAEGEQC+-T34gofYjZyGZ-NQtJK+smUghtbLXx-h5GgMbqO2FVQ@mail.gmail.com>
In-Reply-To: <CAEGEQC+-T34gofYjZyGZ-NQtJK+smUghtbLXx-h5GgMbqO2FVQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7461366358464448386==
Content-Type: multipart/alternative; boundary=047d7b86dcf83c86ff04d47184cf

--047d7b86dcf83c86ff04d47184cf
Content-Type: text/plain; charset=ISO-8859-1

Quick update..

I successfully connected my Arduino UNO via the SMBus pins in the PCI slot
today and used the Arduino Wire library to read temperatures from the
motherboard's aSC7621. I checked the readings against speedfan and they
matched.

It was only left running for a few minutes but I'm optimistic that it will
work ok long term, the manual for the ICH10R states that the SMBus master
is capable of multi mastering as is the Arduino.

If anyone needs to access their motherboard's SMBus then this might be a
good solution. It seems that PCIe slots also have pins for SMBus (not sure
if they are regularly connected?) and if you have a spare slot then then
the riser card makes for an extremely simple non invasive connection.

Regards,

Robert.


On Thu, Jan 24, 2013 at 3:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Jan 24, 2013 at 11:10:16AM +0100, Jean Delvare wrote:
> > On Thu, 24 Jan 2013 11:01:37 +0100, Robert Smith wrote:
> > > Thanks,
> > >
> > > My motherboard is an Intel DX58SO. I have read the documentation and it
> > > doesn't mention a header but it does mention that the SMBus is routed
> to
> > > the (single) PCI slot.
> >
> > OK.
> >
> > > I understood that SMBus is a multi master bus? certainly my plans rely
> on
> > > this.
> > >
> > > "SMBus is a two-wire multi-master bus, meaning that more than one
> device
> > > capable of controlling the bus
> > > can be connected to it."
> > >
> > > from section 2 'Characteristics' of:
> > >
> > > http://smbus.org/specs/smbus110.pdf
> >
> > Ah, my bad, I thought SMBus had stripped off the multimaster capability
> > of I2C but clearly I'm wrong, sorry.
> >
> Still needs a multi-master capable controller, though. Many multi-master
> systems
> use bus master selectors such as PCA9541 to avoid the pitfalls of
> multi-master
> access (such as one master blocking the bus). Actually, thinking about it,
> I
> never encountered a multi-master system without similar protection.
>
> Guenter
>

--047d7b86dcf83c86ff04d47184cf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Quick update..<div><br></div><div style>I successfully con=
nected my Arduino UNO via the SMBus pins in the PCI slot today and used the=
 Arduino Wire library to read temperatures from the motherboard&#39;s aSC76=
21. I checked the readings against speedfan and they matched.</div>

<div style><br></div><div style>It was only left running for a few minutes =
but I&#39;m optimistic that it will work ok long term, the manual for the I=
CH10R states that the SMBus master is capable of multi mastering as is the =
Arduino.</div>

<div style><br></div><div style>If anyone needs to access their motherboard=
&#39;s SMBus then this might be a good solution. It seems that PCIe slots a=
lso have pins for SMBus (not sure if they are regularly connected?) and if =
you have a spare slot then then the riser card makes for an extremely simpl=
e non invasive connection.</div>

<div style><br></div><div style>Regards,</div><div style><br></div><div sty=
le>Robert.</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmai=
l_quote">On Thu, Jan 24, 2013 at 3:45 PM, Guenter Roeck <span dir=3D"ltr">&=
lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.n=
et</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, Jan 24, 2013 at 11:10:16AM +0100, Jean Delvare wrote:<br>
&gt; On Thu, 24 Jan 2013 11:01:37 +0100, Robert Smith wrote:<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; My motherboard is an Intel DX58SO. I have read the documentation =
and it<br>
&gt; &gt; doesn&#39;t mention a header but it does mention that the SMBus i=
s routed to<br>
&gt; &gt; the (single) PCI slot.<br>
&gt;<br>
&gt; OK.<br>
&gt;<br>
&gt; &gt; I understood that SMBus is a multi master bus? certainly my plans=
 rely on<br>
&gt; &gt; this.<br>
&gt; &gt;<br>
&gt; &gt; &quot;SMBus is a two-wire multi-master bus, meaning that more tha=
n one device<br>
&gt; &gt; capable of controlling the bus<br>
&gt; &gt; can be connected to it.&quot;<br>
&gt; &gt;<br>
&gt; &gt; from section 2 &#39;Characteristics&#39; of:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"http://smbus.org/specs/smbus110.pdf" target=3D"_blank"=
>http://smbus.org/specs/smbus110.pdf</a><br>
&gt;<br>
&gt; Ah, my bad, I thought SMBus had stripped off the multimaster capabilit=
y<br>
&gt; of I2C but clearly I&#39;m wrong, sorry.<br>
&gt;<br>
</div></div>Still needs a multi-master capable controller, though. Many mul=
ti-master systems<br>
use bus master selectors such as PCA9541 to avoid the pitfalls of multi-mas=
ter<br>
access (such as one master blocking the bus). Actually, thinking about it, =
I<br>
never encountered a multi-master system without similar protection.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br>
</font></span></blockquote></div><br></div>

--047d7b86dcf83c86ff04d47184cf--


--===============7461366358464448386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7461366358464448386==--
