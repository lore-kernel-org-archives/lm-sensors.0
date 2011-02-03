From: Dylan <dylan.parker@gmail.com>
Date: Thu, 03 Feb 2011 21:56:11 +0000
Subject: Re: [lm-sensors] Fluctuating min/max/div causing alarms
Message-Id: <AANLkTikwg_rSRSH2ntP5WOt9419UAEScQmT+A7i-juKZ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6056725460121602966=="
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik+SWY4Ka8oCH+rcApNsd6DufNriKR2f6hFYCkJ@mail.gmail.com>
In-Reply-To: <AANLkTik+SWY4Ka8oCH+rcApNsd6DufNriKR2f6hFYCkJ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6056725460121602966==
Content-Type: multipart/alternative; boundary=20cf30433ef89de824049b67d660

--20cf30433ef89de824049b67d660
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Jan 29, 2011 at 12:31 PM, Jean Delvare <khali@linux-fr.org> wrote:

> On Sat, 29 Jan 2011 12:18:31 -0800, Dylan wrote:
> > On Sat, Jan 29, 2011 at 12:11 PM, Jean Delvare <khali@linux-fr.org>
> wrote:
> > > Never use native hwmon drivers together with IPMI. They access the same
> > > device in a non-synchronized manner, resulting in reads from / write to
> > > the wrong register. The problem your describe is most certainly caused
> > > by this. If your system uses IPMI, don't load native hwmon drivers.
> >
> > Thanks for your quick response. Your idea of conflicting reads/writes
> sounds
> > very plausible.
> > So, with UNRAID I am no explicitly loading any hwmon drives or IPMI
> drivers.
>
> You certainly do, as the w83627ehf driver (native hwmon driver) does
> not load automatically. Most likely, you ran sensors-detect, and it
> detected the chip and created a configuration file for you. As I am not
> familiar with UNRAID, you'll have to figure out by yourself which
> configuration file mentions the w83627ehf driver, and remove it. It's
> certainly somewhere under /etc, so a brutal:
> # grep -r w83627ehf /etc
> might answer the question.
>

UnRAID is a pre-compiled kernel and filesystem that gets loaded into RAM
each reboot. After digging through the .config provided I found it does
indeed have w83627ehf compiled into the kernel.

I recompiled the kernel with the module not loaded by default and -- ta daa
-- no more random alarms and warnings from my motherboard or the IPMI
interface. But of course I also don't get any sensor data via lm-sensors.


> > Can you give me a pointer as to how I might resolve this conflict?
>
> As you are apparently using IPMI on this machine, the best solution is
> to not load the w83627ehf driver. Which unfortunately means no
> integration with libsensors-based monitoring applications, but IPMI
> support comes at this price for the time being.
>
>
I did dig around to see if there was a ipmisensors module for my kernel but
unfortunately there is not. It seems I'm left with ipmitool for now which is
fine but I just don't get the nice lm-sensors integration I was hoping for.
Ah well. Thank goodness there is no more alarms :)



> > Is this an issue as how I've modified sensors3.conf or something more
> > fundamental with kernel modules?
>
> This is related to kernel modules, yes.
>
> --
> Jean Delvare
>


Thanks again Jean. You helped me solve my problem.

Dylan Parker

--20cf30433ef89de824049b67d660
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sat, Jan 29, 2011 at 12:31 PM, Jean D=
elvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@li=
nux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div class=3D"im">On Sat, 29 Jan 2011 12:18:31 -0800, Dylan wrote:<br>
&gt; On Sat, Jan 29, 2011 at 12:11 PM, Jean Delvare &lt;<a href=3D"mailto:k=
hali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
</div><div class=3D"im">&gt; &gt; Never use native hwmon drivers together w=
ith IPMI. They access the same<br>
&gt; &gt; device in a non-synchronized manner, resulting in reads from / wr=
ite to<br>
&gt; &gt; the wrong register. The problem your describe is most certainly c=
aused<br>
&gt; &gt; by this. If your system uses IPMI, don&#39;t load native hwmon dr=
ivers.<br>
&gt;<br>
&gt; Thanks for your quick response. Your idea of conflicting reads/writes =
sounds<br>
&gt; very plausible.<br>
&gt; So, with UNRAID I am no explicitly loading any hwmon drives or IPMI dr=
ivers.<br>
<br>
</div>You certainly do, as the w83627ehf driver (native hwmon driver) does<=
br>
not load automatically. Most likely, you ran sensors-detect, and it<br>
detected the chip and created a configuration file for you. As I am not<br>
familiar with UNRAID, you&#39;ll have to figure out by yourself which<br>
configuration file mentions the w83627ehf driver, and remove it. It&#39;s<b=
r>
certainly somewhere under /etc, so a brutal:<br>
# grep -r w83627ehf /etc<br>
might answer the question.<br></blockquote><div><br></div><div>UnRAID is a =
pre-compiled kernel and filesystem that gets loaded into RAM each reboot. A=
fter digging through the .config provided I found it does indeed have w8362=
7ehf compiled into the kernel.</div>

<div>=A0</div><div>I recompiled the kernel with the module not loaded by de=
fault and -- ta daa -- no more random alarms and warnings from my motherboa=
rd or the IPMI interface. But of course I also don&#39;t get any sensor dat=
a via lm-sensors.</div>

<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im"><br>
&gt; Can you give me a pointer as to how I might resolve this conflict?<br>
<br>
</div>As you are apparently using IPMI on this machine, the best solution i=
s<br>
to not load the w83627ehf driver. Which unfortunately means no<br>
integration with libsensors-based monitoring applications, but IPMI<br>
support comes at this price for the time being.<br>
<div class=3D"im"><br></div></blockquote><div><br></div><div>I did dig arou=
nd to see if there was a ipmisensors module for my kernel but unfortunately=
 there is not. It seems I&#39;m left with ipmitool for now which is fine bu=
t I just don&#39;t get the nice lm-sensors integration I was hoping for. Ah=
 well. Thank goodness there is no more alarms :)</div>

<div><br></div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div class=3D"=
im">
&gt; Is this an issue as how I&#39;ve modified sensors3.conf or something m=
ore<br>
&gt; fundamental with kernel modules?<br>
<br>
</div>This is related to kernel modules, yes.<br>
<br>
--<br>
<font color=3D"#888888">Jean Delvare<br>
</font></blockquote></div><br><div><br></div><div>Thanks again Jean. You he=
lped me solve my problem.</div><div><br></div><div>Dylan Parker</div>

--20cf30433ef89de824049b67d660--


--===============6056725460121602966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6056725460121602966==--
