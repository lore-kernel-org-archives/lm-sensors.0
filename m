From: Tony Bones <aaroboneml@gmail.com>
Date: Fri, 27 Mar 2009 18:14:16 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <7bccedf10903271114x17a10b80y229c3a0401344987@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3186618379148772166=="
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============3186618379148772166==
Content-Type: multipart/alternative; boundary=000e0cd2900e65351404661db3e9

--000e0cd2900e65351404661db3e9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Fri, Feb 20, 2009 at 2:11 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Anthony,
>
> On Tue, 11 Nov 2008 10:45:10 +0100, Jean Delvare wrote:
> > On Fri, 7 Nov 2008 17:38:00 -0800, Anthony Arobone wrote:
> > > # isadump 0x2e 0x2f 8
> > > WARNING! Running this program can cause system crashes, data loss and
> worse!
> > > I will probe address register 0x2e and data register 0x2f.
> > > Probing bank 8 using bank register 0x07.
> > > Continue? [Y/n] y
> > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > > 00: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00
> > > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 41
> > > 20: f1 01 00 00 01 01 00 91 00 11 2e 00 00 10 00 00
> > > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 70: 00 03 00 00 04 04 00 00 00 00 00 00 00 00 00 00
> > > 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > f0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >
> > OK, so as expected, the logical device with the hardware monitoring
> > features is disabled. If you look at ticket #2182 starting at:
> > http://www.lm-sensors.org/ticket/2182#comment:13
> >
> > You'll see what we tried with the other user to enable the logical
> > device and see if it "woke up" the "emulated" LM96000. It did not work
> > for him, but feel free to try too and see if it helps on your board:
> >
> > isaset -y 0x2e 0x2f 0x07 8
> > isaset -y 0x2e 0x2f 0x60 0x02
> > isaset -y 0x2e 0x2f 0x61 0x90
> > isaset -y 0x2e 0x2f 0x30 1
> >
> > (After checking in /proc/ioports that there's nothing at 0x290 on your
> > system.) Then:
> >
> > rmmod lm85
> > modprobe lm85
>
> Did you ever try this?
>
> > That being said, I'm not holding my breath. Maybe your system has the
> > same chip variant (WPCD377i) without the hardware monitoring feature
> > and that's the reason why all the readings are 0 and the actual
> > monitoring is done by the Intel ICH chip.
>
> Can you please look at your board (physically) and search for the
> Super-I/O chip? This should be one of:
>
> PC8374L
> WPCD374L
> WPCD376I
> WPCD377I
>
> I would like to know which one you have.


Sorry for the long delay, its the WPCD376I  (which apparently is based on
the WPCD374L but without the legacy components).  So maybe they are similar
in how you interface with them.

See here:
http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/ComputerIC/SuperIO/AdvancedSuperIOforDesktop/WPCD376I.htm

--000e0cd2900e65351404661db3e9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Feb 20, 2009 at 2:11 AM, Jean De=
lvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@lin=
ux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Hi Anthony,<br>
<div><div></div><div class=3D"h5"><br>
On Tue, 11 Nov 2008 10:45:10 +0100, Jean Delvare wrote:<br>
&gt; On Fri, 7 Nov 2008 17:38:00 -0800, Anthony Arobone wrote:<br>
&gt; &gt; # isadump 0x2e 0x2f 8<br>
&gt; &gt; WARNING! Running this program can cause system crashes, data loss=
 and worse!<br>
&gt; &gt; I will probe address register 0x2e and data register 0x2f.<br>
&gt; &gt; Probing bank 8 using bank register 0x07.<br>
&gt; &gt; Continue? [Y/n] y<br>
&gt; &gt; =A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =
=A0b =A0c =A0d =A0e =A0f<br>
&gt; &gt; 00: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00<br>
&gt; &gt; 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 41<br>
&gt; &gt; 20: f1 01 00 00 01 01 00 91 00 11 2e 00 00 10 00 00<br>
&gt; &gt; 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&gt; &gt; 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&gt; &gt; 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&gt; &gt; 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&gt; &gt; 70: 00 03 00 00 04 04 00 00 00 00 00 00 00 00 00 00<br>
&gt; &gt; 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&gt; &gt; 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&gt; &gt; a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&gt; &gt; b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&gt; &gt; c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&gt; &gt; d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&gt; &gt; e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&gt; &gt; f0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&gt;<br>
&gt; OK, so as expected, the logical device with the hardware monitoring<br=
>
&gt; features is disabled. If you look at ticket #2182 starting at:<br>
&gt; <a href=3D"http://www.lm-sensors.org/ticket/2182#comment:13" target=3D=
"_blank">http://www.lm-sensors.org/ticket/2182#comment:13</a><br>
&gt;<br>
&gt; You&#39;ll see what we tried with the other user to enable the logical=
<br>
&gt; device and see if it &quot;woke up&quot; the &quot;emulated&quot; LM96=
000. It did not work<br>
&gt; for him, but feel free to try too and see if it helps on your board:<b=
r>
&gt;<br>
&gt; isaset -y 0x2e 0x2f 0x07 8<br>
&gt; isaset -y 0x2e 0x2f 0x60 0x02<br>
&gt; isaset -y 0x2e 0x2f 0x61 0x90<br>
&gt; isaset -y 0x2e 0x2f 0x30 1<br>
&gt;<br>
&gt; (After checking in /proc/ioports that there&#39;s nothing at 0x290 on =
your<br>
&gt; system.) Then:<br>
&gt;<br>
&gt; rmmod lm85<br>
&gt; modprobe lm85<br>
<br>
</div></div>Did you ever try this?<br>
<div class=3D"im"><br>
&gt; That being said, I&#39;m not holding my breath. Maybe your system has =
the<br>
&gt; same chip variant (WPCD377i) without the hardware monitoring feature<b=
r>
&gt; and that&#39;s the reason why all the readings are 0 and the actual<br=
>
&gt; monitoring is done by the Intel ICH chip.<br>
<br>
</div>Can you please look at your board (physically) and search for the<br>
Super-I/O chip? This should be one of:<br>
<br>
PC8374L<br>
WPCD374L<br>
WPCD376I<br>
WPCD377I<br>
<br>
I would like to know which one you have.</blockquote><div><br>Sorry for the=
 long delay, its the WPCD376I=A0 (which apparently is based on the WPCD374L=
 but without the legacy components).=A0 So maybe they are similar in how yo=
u interface with them.<br>
<br>See here: <a href=3D"http://www.nuvoton.com/hq/enu/ProductAndSales/Prod=
uctLines/ComputerIC/SuperIO/AdvancedSuperIOforDesktop/WPCD376I.htm">http://=
www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/ComputerIC/SuperIO/Adva=
ncedSuperIOforDesktop/WPCD376I.htm</a><br>
<br></div></div><br>

--000e0cd2900e65351404661db3e9--


--===============3186618379148772166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3186618379148772166==--
