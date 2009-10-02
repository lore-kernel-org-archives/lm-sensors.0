From: Mark Altern <mark.altern@gmail.com>
Date: Fri, 02 Oct 2009 19:23:54 +0000
Subject: Re: [lm-sensors] ATK0110
Message-Id: <526fa40a0910021223i6f652227l91bd2097ae69a91f@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5280085756080790670=="
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00910020341g5a42ddd0w6cd215c25b96daec@mail.gmail.com>
In-Reply-To: <68676e00910020341g5a42ddd0w6cd215c25b96daec@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5280085756080790670==
Content-Type: multipart/alternative; boundary=001636ed667d6a94c80474f8b46c

--001636ed667d6a94c80474f8b46c
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Oct 2, 2009 at 12:44 PM, Luca Tettamanti <kronos.it@gmail.com>wrote:

> (do not strip the CC)
>
> On Fri, Oct 2, 2009 at 7:16 PM, Mark Altern <mark.altern@gmail.com> wrote:
> > No,  I am NOT using any fancontrol or pwmconfig, the coretemp reported
> > around 37-40, which is consistant as in windows,  so the
> > CPU diode temp should definitely be lower than that. The w83667hg
> reported
> > the same diode CPU temp (36C) as I observed by several softwares under
> > windows 7, where I am sure it is correct. So w83667 indeed reported a lot
> of
> > other wrong values, like the voltages, but I believe it reports the
> correct
> > CPU diode temp.
> >
> > Thus,  atk0110 is working, but it report wrong value and push the fan
> > speeding up, which I confirmed by opening the case and touch the CPU heat
> > sink, and it is stone cold, but the fan is running like crazy, more than
> > 1000rpm, where it should only run at about 500rpm, as it does in Windows.
>
> I asked about fancontrol because atk0110 itself does not control the
> fan, but an external monitoring program may react to the higher
> temperature.
> Asus BIOS defines a "Q-FAN" mode, which - when set to auto - allows
> the system to adjust fan rotation based on CPU temperature. atk0110
> driver does not change the settings defined in the BIOS screen (I
> haven't decoded the interface yet!).
>
> > The funny thing is that right after computer startsup, the lm_sensors
> report
> > correct diode CPU temp, like around 36C, and fan is spinning at around
> > 600rpm, but after idling a minutes or two, that value suddenly jump up to
> > 47C and you hear the fan speeding up to 1100rmp, while the coretemps are
> > still the same as before, further more, I touched the "cold" CPU heat
> sink,
> > 47C is definitely NOT true.  So how does the atk0110 work?
>
> It just report the value calculated by the firmware, the driver itself
> does not perform any "adjustment" on the temperature.
>
> > Why this wrong reporting only happens after a minites of startup, instead
> of from the
> > beginning?
>
> Because the monitoring stuff embedded on the board decided so ;-)
> Really, the driver is just passing up the data. Please send me a copy
> of the DSDT.
>
> L
>
I will send you the DSDT after I come home from work. I have Q-fan in BIOS
enabled.

By the way, how does w83667 report/calculate the CPU temperature?

--001636ed667d6a94c80474f8b46c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Oct 2, 2009 at 12:44 PM, Luca Te=
ttamanti <span dir=3D"ltr">&lt;<a href=3D"http://kronos.it">kronos.it</a>@<=
a href=3D"http://gmail.com">gmail.com</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); m=
argin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
(do not strip the CC)<br>
<div class=3D"im"><br>
On Fri, Oct 2, 2009 at 7:16 PM, Mark Altern &lt;<a href=3D"mailto:mark.alte=
rn@gmail.com">mark.altern@gmail.com</a>&gt; wrote:<br>
&gt; No,=A0 I am NOT using any fancontrol or pwmconfig, the coretemp report=
ed<br>
&gt; around 37-40, which is consistant as in windows,=A0 so the<br>
&gt; CPU diode temp should definitely be lower than that. The w83667hg repo=
rted<br>
&gt; the same diode CPU temp (36C) as I observed by several softwares under=
<br>
&gt; windows 7, where I am sure it is correct. So w83667 indeed reported a =
lot of<br>
&gt; other wrong values, like the voltages, but I believe it reports the co=
rrect<br>
&gt; CPU diode temp.<br>
&gt;<br>
&gt; Thus,=A0 atk0110 is working, but it report wrong value and push the fa=
n<br>
&gt; speeding up, which I confirmed by opening the case and touch the CPU h=
eat<br>
&gt; sink, and it is stone cold, but the fan is running like crazy, more th=
an<br>
&gt; 1000rpm, where it should only run at about 500rpm, as it does in Windo=
ws.<br>
<br>
</div>I asked about fancontrol because atk0110 itself does not control the<=
br>
fan, but an external monitoring program may react to the higher<br>
temperature.<br>
Asus BIOS defines a &quot;Q-FAN&quot; mode, which - when set to auto - allo=
ws<br>
the system to adjust fan rotation based on CPU temperature. atk0110<br>
driver does not change the settings defined in the BIOS screen (I<br>
haven&#39;t decoded the interface yet!).<br>
<div class=3D"im"><br>
&gt; The funny thing is that right after computer startsup, the lm_sensors =
report<br>
&gt; correct diode CPU temp, like around 36C, and fan is spinning at around=
<br>
&gt; 600rpm, but after idling a minutes or two, that value suddenly jump up=
 to<br>
&gt; 47C and you hear the fan speeding up to 1100rmp, while the coretemps a=
re<br>
&gt; still the same as before, further more, I touched the &quot;cold&quot;=
 CPU heat sink,<br>
&gt; 47C is definitely NOT true.=A0 So how does the atk0110 work?<br>
<br>
</div>It just report the value calculated by the firmware, the driver itsel=
f<br>
does not perform any &quot;adjustment&quot; on the temperature.<br>
<div class=3D"im"><br>
&gt; Why this wrong reporting only happens after a minites of startup, inst=
ead of from the<br>
&gt; beginning?<br>
<br>
</div>Because the monitoring stuff embedded on the board decided so ;-)<br>
Really, the driver is just passing up the data. Please send me a copy<br>
of the DSDT.<br>
<font color=3D"#888888"><br>
L<br>
</font></blockquote></div>I will send you the DSDT after I come home from w=
ork. I have Q-fan in BIOS enabled.<br><br>By the way, how does w83667 repor=
t/calculate the CPU temperature? <br>

--001636ed667d6a94c80474f8b46c--


--===============5280085756080790670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5280085756080790670==--
