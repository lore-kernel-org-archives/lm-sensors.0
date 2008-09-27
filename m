From: "Anthony Arobone" <aaroboneml@gmail.com>
Date: Sat, 27 Sep 2008 18:08:12 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <7bccedf10809271108n6ed2fdc3j19258befc9f91102@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1500197555789944214=="
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============1500197555789944214==
Content-Type: multipart/alternative; 
	boundary="----=_Part_26974_16225024.1222538892642"

------=_Part_26974_16225024.1222538892642
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Sep 27, 2008 at 4:47 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Anthony,
>
> On Fri, 26 Sep 2008 10:19:31 -0700, Anthony Arobone wrote:
> > Hi Jena,  thanks a lot for your help.
> >
> > My BIOS does display all the correct values for temps and voltage for
> > everything.
>
> OK. So either the LM96000 can be re-enabled, or there's another
> monitoring chip on your motherboard.
>
> Can you please list the labels and values displayed by your BIOS? To
> check whether this corresponds to the LM96000 inputs or not.



Here is what my BIOS list, the "xxx" is just a replacement for that actual 3
decimal numbers that i didn't capture:

CPU Die/Package Temp         Prochot-49C
Motherboard Temp                 38C
ICH Temp                              65C
MCH Temp                            45C

+12v                                     12.xxxv
+5v                                       5.xxxv
+3.3v Standby                       3.3xxv
MCH Vcc                              1.1135v
CPU 1 Vccp                          1.218v

CPU Cooling FAN                  836 RPM
Chassis Inlet FAN                  3061 RPM



>
>
> > > Can you please provide a dump of your chip? You should be able to get
> > > it the following way:
> > >
> > > # rmmod lm85
> > > # modprobe i2c-dev
> > > # i2cdump 0 0x2e b
> > >
> >
> > I have i2c-dev built into kernel. Hope that's not a problem.
>
> It's OK.
>
> > # i2cdump 0 0x2e b
> > WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> > I will probe file /dev/i2c/0, address 0x2e, mode byte
> > Continue? [Y/n] Y
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 20: 00 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff    ................
> > 30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 01 68    ..............?h
> > 40: 04 00 00 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ?.............??
> > 50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 c4    ????........bbb?
> > 60: c4 c4 00 00 80 80 80 00 00 00 64 64 64 44 44 a4    ??..???...dddDD?
> > 70: ff ff ff 00 00 00 08 00 00 22 6e 6e 6e 00 00 00    ......?.."nnn...
> > 80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
> > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > f0: 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00    ........?.......
>
> OK, so this is basically the same case as in ticket 2182: first version
> of the LM96000, and strange value in register 0x6f. So please do the
> same test I suggested in this ticket:
>
> # rmmod lm85
> # i2cset -y 0 0x2e 0x40 0x04
> # i2cset -y 0 0x2e 0x6f 0x00
> # i2cset -y 0 0x2e 0x40 0x05
> # modprobe lm85
>
> And report if it helps or not.
>

Didn't help.  Everything is still zero.  :(

------=_Part_26974_16225024.1222538892642
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><br><br><div class="gmail_quote">On Sat, Sep 27, 2008 at 4:47 AM, Jean Delvare <span dir="ltr">&lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Anthony,<br>
<div class="Ih2E3d"><br>
On Fri, 26 Sep 2008 10:19:31 -0700, Anthony Arobone wrote:<br>
&gt; Hi Jena, &nbsp;thanks a lot for your help.<br>
&gt;<br>
&gt; My BIOS does display all the correct values for temps and voltage for<br>
&gt; everything.<br>
<br>
</div>OK. So either the LM96000 can be re-enabled, or there&#39;s another<br>
monitoring chip on your motherboard.<br>
<br>
Can you please list the labels and values displayed by your BIOS? To<br>
check whether this corresponds to the LM96000 inputs or not.</blockquote><div><br><br>Here is what my BIOS list, the &quot;xxx&quot; is just a replacement for that actual 3 decimal numbers that i didn&#39;t capture:<br><br>
CPU Die/Package Temp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Prochot-49C<br>Motherboard Temp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 38C<br>ICH Temp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 65C<br>MCH Temp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 45C<br><br>+12v&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12.xxxv<br>
+5v&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.xxxv<br>+3.3v Standby&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.3xxv<br>MCH Vcc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.1135v<br>CPU 1 Vccp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.218v<br><br>CPU Cooling FAN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 836 RPM<br>
Chassis Inlet FAN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3061 RPM<br><br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<div class="Ih2E3d"><br>
&gt; &gt; Can you please provide a dump of your chip? You should be able to get<br>
&gt; &gt; it the following way:<br>
&gt; &gt;<br>
&gt; &gt; # rmmod lm85<br>
&gt; &gt; # modprobe i2c-dev<br>
&gt; &gt; # i2cdump 0 0x2e b<br>
&gt; &gt;<br>
&gt;<br>
&gt; I have i2c-dev built into kernel. Hope that&#39;s not a problem.<br>
<br>
</div>It&#39;s OK.<br>
<div class="Ih2E3d"><br>
&gt; # i2cdump 0 0x2e b<br>
&gt; WARNING! This program can confuse your I2C bus, cause data loss and worse!<br>
&gt; I will probe file /dev/i2c/0, address 0x2e, mode byte<br>
&gt; Continue? [Y/n] Y<br>
&gt; &nbsp; &nbsp; &nbsp;0 &nbsp;1 &nbsp;2 &nbsp;3 &nbsp;4 &nbsp;5 &nbsp;6 &nbsp;7 &nbsp;8 &nbsp;9 &nbsp;a &nbsp;b &nbsp;c &nbsp;d &nbsp;e &nbsp;f &nbsp; &nbsp;0123456789abcdef<br>
&gt; 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 &nbsp; &nbsp;................<br>
&gt; 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 &nbsp; &nbsp;................<br>
&gt; 20: 00 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; 30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 01 68 &nbsp; &nbsp;..............?h<br>
&gt; 40: 04 00 00 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f &nbsp; &nbsp;?.............??<br>
&gt; 50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 c4 &nbsp; &nbsp;????........bbb?<br>
&gt; 60: c4 c4 00 00 80 80 80 00 00 00 64 64 64 44 44 a4 &nbsp; &nbsp;??..???...dddDD?<br>
&gt; 70: ff ff ff 00 00 00 08 00 00 22 6e 6e 6e 00 00 00 &nbsp; &nbsp;......?..&quot;nnn...<br>
&gt; 80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 &nbsp; &nbsp;?...............<br>
&gt; 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 &nbsp; &nbsp;................<br>
&gt; a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 &nbsp; &nbsp;................<br>
&gt; b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 &nbsp; &nbsp;................<br>
&gt; c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 &nbsp; &nbsp;................<br>
&gt; d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 &nbsp; &nbsp;................<br>
&gt; e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 &nbsp; &nbsp;................<br>
&gt; f0: 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 &nbsp; &nbsp;........?.......<br>
<br>
</div>OK, so this is basically the same case as in ticket 2182: first version<br>
of the LM96000, and strange value in register 0x6f. So please do the<br>
same test I suggested in this ticket:<br>
<br>
# rmmod lm85<br>
# i2cset -y 0 0x2e 0x40 0x04<br>
# i2cset -y 0 0x2e 0x6f 0x00<br>
# i2cset -y 0 0x2e 0x40 0x05<br>
# modprobe lm85<br>
<br>
And report if it helps or not.<br>
</blockquote><div><br>Didn&#39;t help.&nbsp; Everything is still zero.&nbsp; :(<br><br>&nbsp;<br></div></div></div>

------=_Part_26974_16225024.1222538892642--


--===============1500197555789944214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1500197555789944214==--
