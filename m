From: Sergio Cipolla <secipolla@gmail.com>
Date: Sat, 04 Feb 2012 19:32:51 +0000
Subject: Re: [lm-sensors] it87 chip and kernel 3.2.2 issue.
Message-Id: <CANLOsR45Fi-JUJ_7McuSy0aZMWLw53SH5FTh70Yuec2cSptVjQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9098983119811860454=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CANLOsR7+rDwQ6o=UUysYj2bUQmq8aRK6C+khMqAxasyzQZCbLg@mail.gmail.com>
In-Reply-To: <CANLOsR7+rDwQ6o=UUysYj2bUQmq8aRK6C+khMqAxasyzQZCbLg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============9098983119811860454==
Content-Type: multipart/alternative; boundary=f46d044794dfecdcf204b8287f69

--f46d044794dfecdcf204b8287f69
Content-Type: text/plain; charset=ISO-8859-1

On 4 February 2012 17:11, Jean Delvare <khali@linux-fr.org> wrote:

> On Sat, 4 Feb 2012 16:24:20 -0200, Sergio Cipolla wrote:
> > Hello, I have a K7VTA3 mobo with an it87 monitoring chip. In spite of
> >
> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
> > ,
> > sensors work fine here up until kernel 3.2.1 (reporting voltage, all
> temps
> > and fans). As soon as the kernel was upgraded to 3.2.2 sensors stopped
> > working.
>
> See:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2012-January/034935.html
>
> I'll update the FAQ to mention this, as this is going to be a recurrent
> complaint I'm afraid.
>
> --
> Jean Delvare
>
Thanks Jean.
So from kernel 2.6.39 till 3.2.1 it was behaving just as if I set
acpi_enforce_resources=lax in the kernel cmdline now?
My system is an old Athlon XP, if I disable ACPI in the BIOS would I lose
anything else besides not being able to shut down the PC from the case
button?
I know this has gone 'off-topic', just asking in case it's a simple answer.
Regards.

--f46d044794dfecdcf204b8287f69
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On 4 February 2012 17:11, Jean Delvare <=
span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.o=
rg</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"im">On Sat, 4 Feb 2012 16:24:20 -0200, Sergio Cipolla wrote:<=
br>
&gt; Hello, I have a K7VTA3 mobo with an it87 monitoring chip. In spite of<=
br>
&gt; <a href=3D"http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavest=
oppedworkinginkernel2.6.31" target=3D"_blank">http://www.lm-sensors.org/wik=
i/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31</a><br>
&gt; ,<br>
&gt; sensors work fine here up until kernel 3.2.1 (reporting voltage, all t=
emps<br>
&gt; and fans). As soon as the kernel was upgraded to 3.2.2 sensors stopped=
<br>
&gt; working.<br>
<br>
</div>See:<br>
<a href=3D"http://lists.lm-sensors.org/pipermail/lm-sensors/2012-January/03=
4935.html" target=3D"_blank">http://lists.lm-sensors.org/pipermail/lm-senso=
rs/2012-January/034935.html</a><br>
<br>
I&#39;ll update the FAQ to mention this, as this is going to be a recurrent=
<br>
complaint I&#39;m afraid.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
</font></span></blockquote></div>Thanks Jean.<div>So from kernel 2.6.39 til=
l 3.2.1 it was behaving just as if I set acpi_enforce_resources=3Dlax in th=
e kernel cmdline now?</div><div>My system is an old Athlon XP, if I disable=
 ACPI in the BIOS would I lose anything else besides not being able to shut=
 down the PC from the case button?</div>

<div>I know this has gone &#39;off-topic&#39;, just asking in case it&#39;s=
 a simple answer.</div><div>Regards.</div>

--f46d044794dfecdcf204b8287f69--


--===============9098983119811860454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9098983119811860454==--
