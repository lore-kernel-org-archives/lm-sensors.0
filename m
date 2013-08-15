From: "Dev, Kapil" <kapil_dev@brown.edu>
Date: Thu, 15 Aug 2013 04:16:11 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <CAFSPGzR8XtAsi6F88GiO3SFpw1D7oMuDvS8PDSbQUBo2rDLG3A@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0109088581776128379=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0109088581776128379==
Content-Type: multipart/alternative; boundary=001a11c274d8fa1ed104e3f4bb2d

--001a11c274d8fa1ed104e3f4bb2d
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Sorry for the verbose email. I am trying to read the temperature value as
accurately as possible, that's why.

It is evident that there are some computations happening internally before
these values are reported. Here is what I have to say about the 4.5C
reported value.

I am using A10 5700 APU amd processor. It has bulldozer architecure (
http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html). Bulldozer
architecture corresponds to 15h micro-architecture family  (
http://en.wikipedia.org/wiki/List_of_AMD_CPU_microarchitectures). So, I
looked at the official manual of 15h family
http://support.amd.com/us/Processor_TechDocs/42301_15h_Mod_00h-0Fh_BKDG.pdf).
And, I found the following:

Page 219 and 393 (figure-14) of the document mention that bits 31:21 (11
bits) of the register D18F3xA4 denote the current temperature of the die as
reported by temperature calculation circuit (TCC). The maximum value that
could be represented by 11 bits is 2048 (2047, but ignore this for now) and
they want to translate that to 256. So, I think the magic number 125 is
obtained by computing 256/2048*1000. Line number 66-68 in k10temp.c (as
downloaded from the drivers' link) use 125 as the factor to compute the
value to be reported. I guess the factor of 1000 would be taken care
somewhere else inside the kernel.

It also means that the lowest resolution of reading the temperature is
0.125C, which might mean that we could get a sub-degree resolution in
temperature reading?

I got a little confused about the way temperature-computation is explained
on page 393. The interpretation of D18F3xA4[31:21] seems to be different
based on the D18F3xA4[17:16] bits. Something similar, but not exactly the
same thing, is implemented in k10temp.c in lines 85-90. The value
(D18F3xA4[18:16]) is multiplied by 500 and then 52000 is added to it.
While, on page 393, I see <(CurTmp[10:2]*0.5)-49>. In line 89 of k10temp.c,
the hysteresis is computed as (D18F3xA4[27:24])*500,  i.e. four bits are
used. While on page 393, three bits (equivalent to 0.125*8 = 1C) is used as
hysteresis. Am I understanding things correctly here?

Also, if I want to apply any further correction to the reported raw values,
I guess I just need to put following piece of code in /etc/sensors3.conf
file:

-------------------------------------------------------------
chip "k10temp-*"
     compute temp1 (@+correction),(@-correction)
-------------------------------------------------------------

This should add correction to the temp1 value under PCI adapter alone and
not to the temp1 value under ISA adapter?

Thanks,
Kapil


On Wed, Aug 14, 2013 at 6:39 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Aug 14, 2013 at 04:45:43PM -0400, Dev, Kapil wrote:
>
> [ ... ]
>
> > Kapil: After making above changes, I think it seems to work now. Now I am
> > getting following output from sensors:
> > f71869-isa-0e80
> > Adapter: ISA adapter
> > in0:         +1.69 V
> > in1:         +0.90 V
> > in2:         +1.21 V
> > in3:         +1.22 V
> > in4:         +1.49 V
> > in5:         +1.22 V
> > in6:         +1.19 V
> > in7:         +1.73 V
> > in8:         +1.66 V
> > fan1:       2177 RPM
> > fan2:          0 RPM  ALARM
> > fan3:          0 RPM  ALARM
> > temp1:       +24.0 C  (high = +85.0 C, hyst = +81.0 C)
> >                       (crit = +100.0 C, hyst = +96.0 C)  sensor =
> thermistor
> > temp2:       +32.0 C  (high = +85.0 C, hyst = +81.0 C)
> >                       (crit = +100.0 C, hyst = +96.0 C)  sensor =
> thermistor
> > temp3:       +48.0 C  (high = +70.0 C, hyst = +68.0 C)
> >                       (crit = +85.0 C, hyst = +83.0 C)  sensor =
> thermistor
> >
> > k10temp-pci-00c3
> > Adapter: PCI adapter
> > temp1:       +4.5 C  (high = +70.0 C, crit = +70.0 C)
> >
> > I believe temp1 from PCI adapter denotes the core-temperature? But, it is
>
> Correct.
>
> > definitely off by 20-30C; its hard to believe that the temperature would
> be
> > 4.5C under fan based cooling system. I ran a SPEC hmmer benchmark and
> > plotted the temperature over time. temp1 seems to change now. I am
> > attaching the plots herewith.
> >
> Yes, that is pretty common with AMD chips.
>
> > Please let me know if there is a way to calibrate the core-temperature.
> >
> Yes, you'll have to do it in /etc/sensors3.conf. Basically you'll have to
> figure out what you think the real temperature is and add it to the raw
> temperature provided by the driver.
>
> Guenter
>

--001a11c274d8fa1ed104e3f4bb2d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>Sorry for the verbose email. I am trying to read the=
 temperature value as accurately as possible, that&#39;s why.</div><div><br=
></div><div><div>It is evident that there are some computations happening i=
nternally before these values are reported. Here is what I have to say abou=
t the 4.5C reported=A0value.</div>
<div><br></div><div>I am using A10 5700 APU amd processor. It has bulldozer=
 architecure (<a href=3D"http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-S=
eries.html" target=3D"_blank">http://www.cpu-world.com/CPUs/Bulldozer/TYPE-=
A10-Series.html</a>). Bulldozer architecture corresponds to 15h micro-archi=
tecture family =A0(<a href=3D"http://en.wikipedia.org/wiki/List_of_AMD_CPU_=
microarchitectures" target=3D"_blank">http://en.wikipedia.org/wiki/List_of_=
AMD_CPU_microarchitectures</a>). So, I looked at the official manual of 15h=
 family=A0<a href=3D"http://support.amd.com/us/Processor_TechDocs/42301_15h=
_Mod_00h-0Fh_BKDG.pdf" target=3D"_blank">http://support.amd.com/us/Processo=
r_TechDocs/42301_15h_Mod_00h-0Fh_BKDG.pdf</a>). And, I found the following:=
</div>
<div><br></div><div>Page 219 and 393 (figure-14) of the document mention th=
at bits 31:21 (11 bits) of the register=A0D18F3xA4 denote the current tempe=
rature of the die as reported by temperature calculation circuit (TCC). The=
 maximum value that could be represented by 11 bits is 2048 (2047, but igno=
re this for now) and they want to translate that to 256. So, I think the ma=
gic number 125 is obtained by computing 256/2048*1000. Line number 66-68 in=
 k10temp.c (as downloaded from the drivers&#39; link) use 125 as the factor=
 to compute the value to be reported. I guess the factor of 1000 would be t=
aken care somewhere else inside the kernel.=A0</div>
<div><br></div><div>It also means that the lowest resolution of reading the=
 temperature is 0.125C, which might mean that we could get a sub-degree res=
olution in temperature reading?</div><div><br></div><div>I got a little con=
fused about the way temperature-computation is explained on page 393. The i=
nterpretation of D18F3xA4[31:21] seems to be different based on the D18F3xA=
4[17:16] bits. Something similar, but not exactly the same thing, is implem=
ented in k10temp.c in lines 85-90. The value (D18F3xA4[18:16]) is multiplie=
d by 500 and then 52000 is added to it. While, on page 393, I see &lt;(CurT=
mp[10:2]*0.5)-49&gt;. In line 89 of k10temp.c, the hysteresis is computed a=
s (D18F3xA4[27:24])*500, =A0i.e. four bits are used. While on page 393, thr=
ee bits (equivalent to 0.125*8 =3D 1C) is used as hysteresis. Am I understa=
nding things correctly here?</div>
<div><br></div><div>Also, if I want to apply any further correction to the =
reported raw values, I guess I just need to put following piece of code in =
/etc/sensors3.conf file:</div><div><br></div><div>-------------------------=
------------------------------------</div>
<div>chip &quot;k10temp-*&quot;</div><div>=A0 =A0 =A0compute temp1 (@+corre=
ction),(@-correction)</div><div>-------------------------------------------=
------------------</div><div><br></div><div>This should add correction to t=
he temp1 value under PCI adapter alone and not to the temp1 value under ISA=
 adapter?</div>
<div><br></div><div>Thanks,</div><div>Kapil</div><div><br></div><br><div cl=
ass=3D"gmail_quote">On Wed, Aug 14, 2013 at 6:39 PM, Guenter Roeck <span di=
r=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux=
@roeck-us.net</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Wed, Aug 14, 2013 at 04:45:43PM -0400, De=
v, Kapil wrote:<br>
<br>
[ ... ]<br>
<div><div class=3D"h5"><br>
&gt; Kapil: After making above changes, I think it seems to work now. Now I=
 am<br>
&gt; getting following output from sensors:<br>
&gt; f71869-isa-0e80<br>
&gt; Adapter: ISA adapter<br>
&gt; in0: =A0 =A0 =A0 =A0 +1.69 V<br>
&gt; in1: =A0 =A0 =A0 =A0 +0.90 V<br>
&gt; in2: =A0 =A0 =A0 =A0 +1.21 V<br>
&gt; in3: =A0 =A0 =A0 =A0 +1.22 V<br>
&gt; in4: =A0 =A0 =A0 =A0 +1.49 V<br>
&gt; in5: =A0 =A0 =A0 =A0 +1.22 V<br>
&gt; in6: =A0 =A0 =A0 =A0 +1.19 V<br>
&gt; in7: =A0 =A0 =A0 =A0 +1.73 V<br>
&gt; in8: =A0 =A0 =A0 =A0 +1.66 V<br>
&gt; fan1: =A0 =A0 =A0 2177 RPM<br>
&gt; fan2: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM<br>
&gt; fan3: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM<br>
&gt; temp1: =A0 =A0 =A0 +24.0 C =A0(high =3D +85.0 C, hyst =3D +81.0 C)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +100.0 C, hyst =
=3D +96.0 C) =A0sensor =3D thermistor<br>
&gt; temp2: =A0 =A0 =A0 +32.0 C =A0(high =3D +85.0 C, hyst =3D +81.0 C)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +100.0 C, hyst =
=3D +96.0 C) =A0sensor =3D thermistor<br>
&gt; temp3: =A0 =A0 =A0 +48.0 C =A0(high =3D +70.0 C, hyst =3D +68.0 C)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +85.0 C, hyst =
=3D +83.0 C) =A0sensor =3D thermistor<br>
&gt;<br>
&gt; k10temp-pci-00c3<br>
&gt; Adapter: PCI adapter<br>
&gt; temp1: =A0 =A0 =A0 +4.5 C =A0(high =3D +70.0 C, crit =3D +70.0 C)<br>
&gt;<br>
&gt; I believe temp1 from PCI adapter denotes the core-temperature? But, it=
 is<br>
<br>
</div></div>Correct.<br>
<div class=3D"im"><br>
&gt; definitely off by 20-30C; its hard to believe that the temperature wou=
ld be<br>
&gt; 4.5C under fan based cooling system. I ran a SPEC hmmer benchmark and<=
br>
&gt; plotted the temperature over time. temp1 seems to change now. I am<br>
&gt; attaching the plots herewith.<br>
&gt;<br>
</div>Yes, that is pretty common with AMD chips.<br>
<div class=3D"im"><br>
&gt; Please let me know if there is a way to calibrate the core-temperature=
.<br>
&gt;<br>
</div>Yes, you&#39;ll have to do it in /etc/sensors3.conf. Basically you&#3=
9;ll have to<br>
figure out what you think the real temperature is and add it to the raw<br>
temperature provided by the driver.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br>
</font></span></blockquote></div><br></div>

--001a11c274d8fa1ed104e3f4bb2d--


--===============0109088581776128379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0109088581776128379==--
