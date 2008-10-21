From: "Anthony Arobone" <aaroboneml@gmail.com>
Date: Tue, 21 Oct 2008 19:06:43 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <7bccedf10810211206v633831d6r9e2a87be1cca3e78@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2112500177523652687=="
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2112500177523652687==
Content-Type: multipart/alternative; 
	boundary="----=_Part_12519_25945012.1224616003206"

------=_Part_12519_25945012.1224616003206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Sep 27, 2008 at 1:16 PM, Jean Delvare <khali@linux-fr.org> wrote:

> On Sat, 27 Sep 2008 11:08:12 -0700, Anthony Arobone wrote:
> > On Sat, Sep 27, 2008 at 4:47 AM, Jean Delvare <khali@linux-fr.org>
> wrote:
> > > OK. So either the LM96000 can be re-enabled, or there's another
> > > monitoring chip on your motherboard.
> > >
> > > Can you please list the labels and values displayed by your BIOS? To
> > > check whether this corresponds to the LM96000 inputs or not.
> >
> > Here is what my BIOS list, the "xxx" is just a replacement for that
> actual 3
> > decimal numbers that i didn't capture:
> >
> > CPU Die/Package Temp         Prochot-49C
> > Motherboard Temp                 38C
> > ICH Temp                              65C
> > MCH Temp                            45C
> >
> > +12v                                     12.xxxv
> > +5v                                       5.xxxv
> > +3.3v Standby                       3.3xxv
> > MCH Vcc                              1.1135v
> > CPU 1 Vccp                          1.218v
> >
> > CPU Cooling FAN                  836 RPM
> > Chassis Inlet FAN                  3061 RPM
>
> This seems to match the LM96000 features (assuming "CPU Die/Package
> Temp" is from the Intel Core internal sensor.)
>
> > > (...)
> > > OK, so this is basically the same case as in ticket 2182: first version
> > > of the LM96000, and strange value in register 0x6f. So please do the
> > > same test I suggested in this ticket:
> > >
> > > # rmmod lm85
> > > # i2cset -y 0 0x2e 0x40 0x04
> > > # i2cset -y 0 0x2e 0x6f 0x00
> > > # i2cset -y 0 0x2e 0x40 0x05
> > > # modprobe lm85
> > >
> > > And report if it helps or not.
> >
> > Didn't help.  Everything is still zero.  :(
>
> OK... No other idea for now.
>
>
> --
> Jean Delvare
>


Would the tech docs on this sensor be helpful?  I found them on the Intel
site.  It describes all the registers in detail.

See Chapter 23.
http://www.intel.com/Assets/PDF/datasheet/319973.pdf

Let me know if I can do any debugging or coding to help out.  I'm proficient
in C and C++.  Just don't understand how all this sensor stuff works ;)

------=_Part_12519_25945012.1224616003206
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Sep 27, 2008 at 1:16 PM, Jean Delvare <span dir="ltr">&lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span> wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Sat, 27 Sep 2008 11:08:12 -0700, Anthony Arobone wrote:<br>
&gt; On Sat, Sep 27, 2008 at 4:47 AM, Jean Delvare &lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
</div><div class="Ih2E3d">&gt; &gt; OK. So either the LM96000 can be re-enabled, or there&#39;s another<br>
&gt; &gt; monitoring chip on your motherboard.<br>
&gt; &gt;<br>
&gt; &gt; Can you please list the labels and values displayed by your BIOS? To<br>
&gt; &gt; check whether this corresponds to the LM96000 inputs or not.<br>
&gt;<br>
&gt; Here is what my BIOS list, the &quot;xxx&quot; is just a replacement for that actual 3<br>
&gt; decimal numbers that i didn&#39;t capture:<br>
&gt;<br>
&gt; CPU Die/Package Temp &nbsp; &nbsp; &nbsp; &nbsp; Prochot-49C<br>
&gt; Motherboard Temp &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 38C<br>
&gt; ICH Temp &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;65C<br>
&gt; MCH Temp &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;45C<br>
&gt;<br>
&gt; +12v &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 12.xxxv<br>
&gt; +5v &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 5.xxxv<br>
&gt; +3.3v Standby &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 3.3xxv<br>
&gt; MCH Vcc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1.1135v<br>
&gt; CPU 1 Vccp &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1.218v<br>
&gt;<br>
&gt; CPU Cooling FAN &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;836 RPM<br>
&gt; Chassis Inlet FAN &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;3061 RPM<br>
<br>
</div>This seems to match the LM96000 features (assuming &quot;CPU Die/Package<br>
Temp&quot; is from the Intel Core internal sensor.)<br>
<br>
&gt; &gt; (...)<br>
<div class="Ih2E3d">&gt; &gt; OK, so this is basically the same case as in ticket 2182: first version<br>
&gt; &gt; of the LM96000, and strange value in register 0x6f. So please do the<br>
&gt; &gt; same test I suggested in this ticket:<br>
&gt; &gt;<br>
&gt; &gt; # rmmod lm85<br>
&gt; &gt; # i2cset -y 0 0x2e 0x40 0x04<br>
&gt; &gt; # i2cset -y 0 0x2e 0x6f 0x00<br>
&gt; &gt; # i2cset -y 0 0x2e 0x40 0x05<br>
&gt; &gt; # modprobe lm85<br>
&gt; &gt;<br>
&gt; &gt; And report if it helps or not.<br>
&gt;<br>
&gt; Didn&#39;t help. &nbsp;Everything is still zero. &nbsp;:(<br>
<br>
</div>OK... No other idea for now.<br>
<br>
<br>
--<br>
<font color="#888888">Jean Delvare<br>
</font></blockquote></div><br><br>Would the tech docs on this sensor be helpful?&nbsp; I found them on the Intel site.&nbsp; It describes all the registers in detail.<br>
<br>
See Chapter 23.<br>
<a href="http://www.intel.com/Assets/PDF/datasheet/319973.pdf">http://www.intel.com/Assets/PDF/datasheet/319973.pdf</a><br>
<br>Let me know if I can do any debugging or coding to help out.&nbsp; I&#39;m proficient in C and C++.&nbsp; Just don&#39;t understand how all this sensor stuff works ;)<br><br>

------=_Part_12519_25945012.1224616003206--


--===============2112500177523652687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2112500177523652687==--
