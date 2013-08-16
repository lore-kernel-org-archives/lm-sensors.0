From: "Dev, Kapil" <kapil_dev@brown.edu>
Date: Fri, 16 Aug 2013 03:48:18 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <CAFSPGzRF97+RSRpfbrALk1S=YYp7MiSb1pHVDa0mdo3rp1BjMQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4364719677719917787=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============4364719677719917787==
Content-Type: multipart/alternative; boundary=047d7b621ef2175c6904e40876fa

--047d7b621ef2175c6904e40876fa
Content-Type: text/plain; charset=ISO-8859-1

Thanks Clemens!

On Thu, Aug 15, 2013 at 3:55 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> > On 08/14/2013 09:16 PM, Dev, Kapil wrote:
> >> I got a little confused about the way temperature-computation is
> >> explained on page 393. The interpretation of D18F3xA4[31:21] seems to
> >> be different based on the D18F3xA4[17:16] bits.
>
> These two bits should always be 00; Linux never tries to write the
> temperature value.
>

I see. It means  that D18F3xA4[31:21] always denotes the Tctl temperature
(control temperature). Where, Tctl <= Tmeasured <= Tctl+TmpMaxDiffUp. The
value of TmpMaxDiffUp is between 0 and 9C depending on the value of two
bits, D18F3xA4[6:5]. Should I check the value of these two bits, or did you
already figure that out? So, line 68 is really what I should worry about:

return sprintf(buf, "%u\n", (regval >> 21) * 125);

 I installed ubuntu 12.04.02 LTS on another hard-disk and installed
lm-sensors on that. I did not install the driver from
http://khali.linux-fr.org/devel/lm-sensors/drivers/k10temp/k10temp.c manually,
because it was already installed in the kernel. I noticed, that the
reported temperature was very erratic, changing anywhere between 3 C and
30C, even when there was no workload running on the cpu.

>> Something similar, but not exactly the same thing, is implemented in
> >> k10temp.c in lines 85-90. The value (D18F3xA4[18:16])
>
> No, this value is D18F3x64[22:16].
>

Sorry, it was a typo from my side. If I understand it correctly, the
implementation is such that it reports following values:
1) Highest temperature = 70; due to "return sprintf(buf, "%d\n", 70 * 1000
in c-code);"
2) Critical temperature = mostly 70; due to D18F3x64[22:16]*0.5+52 (value =
((regval >> 16) & 0x7f) * 500 + 52000; in c-code), which kind of means
that D18F3x64[22:16]
is mostly fixed to 36?
3)  Hysteresis value: From  D18F3x64[22:16]*0.5+52 -
D18F3x64[22:16]*0.5  (value
-= ((regval >> 24) & 0xf) * 500; in c-code). Is the value of D18F3x64[22:16]
fixed or it changes based on some condition?



>
> >> is multiplied by 500 and then 52000 is added to it. While, on page
> >> 393, I see <(CurTmp[10:2]*0.5)-49>.
>
> On page 382, I see <(HtcTmpLmt*0.5)+52>.
>
>
Again, thanks a lot! As I said, I am trying to compute the temperature
values as accurately as possible because my project involves calibrating
the die-temperature values against other measurements

Regards,
Kapil



>
> Regards,
> Clemens
>

--047d7b621ef2175c6904e40876fa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks Clemens!<br><br><div class=3D"gmail_quote">On Thu, Aug 15, 2013 at 3=
:55 AM, Clemens Ladisch <span dir=3D"ltr">&lt;<a href=3D"mailto:clemens@lad=
isch.de" target=3D"_blank">clemens@ladisch.de</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<div class=3D"im">&gt; On 08/14/2013 09:16 PM, Dev, Kapil wrote:<br>
</div><div class=3D"im">&gt;&gt; I got a little confused about the way temp=
erature-computation is<br>
&gt;&gt; explained on page 393. The interpretation of D18F3xA4[31:21] seems=
 to<br>
&gt;&gt; be different based on the D18F3xA4[17:16] bits.<br>
<br>
</div>These two bits should always be 00; Linux never tries to write the<br=
>
temperature value.<br></blockquote><div><br></div><div>I see. It means =A0t=
hat D18F3xA4[31:21] always denotes the Tctl temperature (control temperatur=
e). Where, Tctl &lt;=3D Tmeasured &lt;=3D Tctl+TmpMaxDiffUp. The value of T=
mpMaxDiffUp is between 0 and 9C depending on the value of two bits, D18F3xA=
4[6:5]. Should I check the value of these two bits, or did you already figu=
re that out? So, line 68 is really what I should worry about:=A0</div>
<div><span style=3D"white-space:pre-wrap"><br></span></div><div><span style=
=3D"white-space:pre-wrap">return sprintf(buf, &quot;%u\n&quot;, (regval &gt=
;&gt; 21) * 125);</span></div><div><br></div><div>=A0I installed ubuntu 12.=
04.02 LTS on another hard-disk and installed lm-sensors on that. I did not =
install the driver from=A0<a href=3D"http://khali.linux-fr.org/devel/lm-sen=
sors/drivers/k10temp/k10temp.c">http://khali.linux-fr.org/devel/lm-sensors/=
drivers/k10temp/k10temp.c</a>=A0manually, because it was already installed =
in the kernel. I noticed, that the reported temperature was very erratic, c=
hanging anywhere between 3 C and 30C, even when there was no workload runni=
ng on the cpu.</div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"im">
&gt;&gt; Something similar, but not exactly the same thing, is implemented =
in<br>
&gt;&gt; k10temp.c in lines 85-90. The value (D18F3xA4[18:16])<br>
<br>
</div>No, this value is D18F3x64[22:16].<br></blockquote><div><br></div><di=
v>Sorry, it was a typo from my side. If I understand it correctly, the impl=
ementation is such that it reports following values:</div><div>1) Highest t=
emperature =3D 70; due to &quot;<span style=3D"white-space:pre-wrap">return=
 sprintf(buf, &quot;%d\n&quot;, 70 * 1000 in c-code);&quot;</span></div>
<div>2) Critical temperature =3D mostly 70; due to=A0D18F3x64[22:16]*0.5+52=
 (<span style=3D"white-space:pre-wrap">value =3D ((regval &gt;&gt; 16) &amp=
; 0x7f) * 500 + 52000; in  c-code), which kind of means that </span>D18F3x6=
4[22:16] is mostly fixed to 36?</div>
<div>3) =A0Hysteresis value: From =A0D18F3x64[22:16]*0.5+52 - D18F3x64[22:1=
6]*0.5 =A0(<span style=3D"white-space:pre-wrap">value -=3D ((regval &gt;&gt=
; 24) &amp; 0xf) * 500; in c-code). Is the value of </span>D18F3x64[22:16] =
fixed or it changes based on some condition?</div>
<div><br></div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im"><br>
&gt;&gt; is multiplied by 500 and then 52000 is added to it. While, on page=
<br>
&gt;&gt; 393, I see &lt;(CurTmp[10:2]*0.5)-49&gt;.<br>
<br>
</div>On page 382, I see &lt;(HtcTmpLmt*0.5)+52&gt;.<br>
<br></blockquote><div><br></div><div>Again, thanks a lot! As I said, I am t=
rying to compute the temperature values as accurately as possible because m=
y project involves calibrating the die-temperature values against other mea=
surements</div>
<div><br></div><div>Regards,</div><div>Kapil</div><div><br></div><div>=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
<br>
Regards,<br>
Clemens<br>
</blockquote></div><br>

--047d7b621ef2175c6904e40876fa--


--===============4364719677719917787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4364719677719917787==--
