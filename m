From: "Dev, Kapil" <kapil_dev@brown.edu>
Date: Thu, 15 Aug 2013 04:32:34 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <CAFSPGzT6-i2QKEfnoa0FQOeRE=MaA5uWu5QK_o0KOek9ikBtmg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2162817926610073043=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2162817926610073043==
Content-Type: multipart/alternative; boundary=047d7b343b769120bf04e3f4f612

--047d7b343b769120bf04e3f4f612
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Aug 15, 2013 at 12:29 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> On 08/14/2013 09:16 PM, Dev, Kapil wrote:
>
>> Hi,
>>
>> Sorry for the verbose email. I am trying to read the temperature value as
>> accurately as possible, that's why.
>>
>> It is evident that there are some computations happening internally
>> before these values are reported. Here is what I have to say about the 4.5C
>> reported value.
>>
>> I am using A10 5700 APU amd processor. It has bulldozer architecure (
>> http://www.cpu-world.com/**CPUs/Bulldozer/TYPE-A10-**Series.html<http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html>).
>> Bulldozer architecture corresponds to 15h micro-architecture family  (
>> http://en.wikipedia.org/wiki/**List_of_AMD_CPU_**microarchitectures<http://en.wikipedia.org/wiki/List_of_AMD_CPU_microarchitectures>).
>> So, I looked at the official manual of 15h family
>> http://support.amd.com/us/**Processor_TechDocs/42301_15h_**
>> Mod_00h-0Fh_BKDG.pdf<http://support.amd.com/us/Processor_TechDocs/42301_15h_Mod_00h-0Fh_BKDG.pdf>).
>> And, I found the following:
>>
>> Page 219 and 393 (figure-14) of the document mention that bits 31:21 (11
>> bits) of the register D18F3xA4 denote the current temperature of the die as
>> reported by temperature calculation circuit (TCC). The maximum value that
>> could be represented by 11 bits is 2048 (2047, but ignore this for now) and
>> they want to translate that to 256. So, I think the magic number 125 is
>> obtained by computing 256/2048*1000. Line number 66-68 in k10temp.c (as
>> downloaded from the drivers' link) use 125 as the factor to compute the
>> value to be reported. I guess the factor of 1000 would be taken care
>> somewhere else inside the kernel.
>>
>>  The kernel reports the temperature to userland in milli-degrees Celsius.
>
>
>  It also means that the lowest resolution of reading the temperature is
>> 0.125C, which might mean that we could get a sub-degree resolution in
>> temperature reading?
>>
>>  ... which also answers this question.


Thanks! Does it mean that I can change the k10temp.c to read milli-degree
C. I have always seen integer readings.


>
>
>  I got a little confused about the way temperature-computation is
>> explained on page 393. The interpretation of D18F3xA4[31:21] seems to be
>> different based on the D18F3xA4[17:16] bits. Something similar, but not
>> exactly the same thing, is implemented in k10temp.c in lines 85-90. The
>> value (D18F3xA4[18:16]) is multiplied by 500 and then 52000 is added to it.
>> While, on page 393, I see <(CurTmp[10:2]*0.5)-49>. In line 89 of k10temp.c,
>> the hysteresis is computed as (D18F3xA4[27:24])*500,  i.e. four bits are
>> used. While on page 393, three bits (equivalent to 0.125*8 = 1C) is used as
>> hysteresis. Am I understanding things correctly here?
>>
>>  The 0.5 -> 500 is due to the conversion to milli-degrees.
> Adding Clemens to the thread - maybe he can help with the rest. I am not
> really an expert on AMD CPUs.
>
>
>  Also, if I want to apply any further correction to the reported raw
>> values, I guess I just need to put following piece of code in
>> /etc/sensors3.conf file:
>>
>> ------------------------------**------------------------------**-
>> chip "k10temp-*"
>>       compute temp1 (@+correction),(@-correction)
>> ------------------------------**------------------------------**-
>>
>> This should add correction to the temp1 value under PCI adapter alone and
>> not to the temp1 value under ISA adapter?
>>
>>  Yes, something like that.


Thanks for everything!

Regards,
Kapil


>
> Guenter
>
>

--047d7b343b769120bf04e3f4f612
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Aug 15, 2013 at 12:29 AM, Guente=
r Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=
=3D"_blank">linux@roeck-us.net</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<div class=3D"im">On 08/14/2013 09:16 PM, Dev, Kapil wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi,<br>
<br>
Sorry for the verbose email. I am trying to read the temperature value as a=
ccurately as possible, that&#39;s why.<br>
<br>
It is evident that there are some computations happening internally before =
these values are reported. Here is what I have to say about the 4.5C report=
ed value.<br>
<br>
I am using A10 5700 APU amd processor. It has bulldozer architecure (<a hre=
f=3D"http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html" target=
=3D"_blank">http://www.cpu-world.com/<u></u>CPUs/Bulldozer/TYPE-A10-<u></u>=
Series.html</a>). Bulldozer architecture corresponds to 15h micro-architect=
ure family =A0(<a href=3D"http://en.wikipedia.org/wiki/List_of_AMD_CPU_micr=
oarchitectures" target=3D"_blank">http://en.wikipedia.org/wiki/<u></u>List_=
of_AMD_CPU_<u></u>microarchitectures</a>). So, I looked at the official man=
ual of 15h family <a href=3D"http://support.amd.com/us/Processor_TechDocs/4=
2301_15h_Mod_00h-0Fh_BKDG.pdf" target=3D"_blank">http://support.amd.com/us/=
<u></u>Processor_TechDocs/42301_15h_<u></u>Mod_00h-0Fh_BKDG.pdf</a>). And, =
I found the following:<br>

<br>
Page 219 and 393 (figure-14) of the document mention that bits 31:21 (11 bi=
ts) of the register D18F3xA4 denote the current temperature of the die as r=
eported by temperature calculation circuit (TCC). The maximum value that co=
uld be represented by 11 bits is 2048 (2047, but ignore this for now) and t=
hey want to translate that to 256. So, I think the magic number 125 is obta=
ined by computing 256/2048*1000. Line number 66-68 in k10temp.c (as downloa=
ded from the drivers&#39; link) use 125 as the factor to compute the value =
to be reported. I guess the factor of 1000 would be taken care somewhere el=
se inside the kernel.<br>

<br>
</blockquote></div>
The kernel reports the temperature to userland in milli-degrees Celsius.<di=
v class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
It also means that the lowest resolution of reading the temperature is 0.12=
5C, which might mean that we could get a sub-degree resolution in temperatu=
re reading?<br>
<br>
</blockquote></div>
... which also answers this question.</blockquote><div><br></div><div>Thank=
s! Does it mean that I can change the k10temp.c to read milli-degree C. I h=
ave always seen integer readings.</div><div>=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<div class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I got a little confused about the way temperature-computation is explained =
on page 393. The interpretation of D18F3xA4[31:21] seems to be different ba=
sed on the D18F3xA4[17:16] bits. Something similar, but not exactly the sam=
e thing, is implemented in k10temp.c in lines 85-90. The value (D18F3xA4[18=
:16]) is multiplied by 500 and then 52000 is added to it. While, on page 39=
3, I see &lt;(CurTmp[10:2]*0.5)-49&gt;. In line 89 of k10temp.c, the hyster=
esis is computed as (D18F3xA4[27:24])*500, =A0i.e. four bits are used. Whil=
e on page 393, three bits (equivalent to 0.125*8 =3D 1C) is used as hystere=
sis. Am I understanding things correctly here?<br>

<br>
</blockquote></div>
The 0.5 -&gt; 500 is due to the conversion to milli-degrees.<br>
Adding Clemens to the thread - maybe he can help with the rest. I am not re=
ally an expert on AMD CPUs.<div class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Also, if I want to apply any further correction to the reported raw values,=
 I guess I just need to put following piece of code in /etc/sensors3.conf f=
ile:<br>
<br>
------------------------------<u></u>------------------------------<u></u>-=
<br>
chip &quot;k10temp-*&quot;<br>
=A0 =A0 =A0 compute temp1 (@+correction),(@-correction)<br>
------------------------------<u></u>------------------------------<u></u>-=
<br>
<br>
This should add correction to the temp1 value under PCI adapter alone and n=
ot to the temp1 value under ISA adapter?<br>
<br>
</blockquote></div>
Yes, something like that.</blockquote><div><br></div><div>Thanks for everyt=
hing!</div><div><br></div><div>Regards,</div><div>Kapil=A0</div><div><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
Guenter<br>
<br>
</font></span></blockquote></div><br>

--047d7b343b769120bf04e3f4f612--


--===============2162817926610073043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2162817926610073043==--
