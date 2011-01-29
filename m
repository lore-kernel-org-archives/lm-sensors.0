From: Dylan <dylan.parker@gmail.com>
Date: Sat, 29 Jan 2011 20:18:31 +0000
Subject: Re: [lm-sensors] Fluctuating min/max/div causing alarms
Message-Id: <AANLkTinix3Bz_epzZG9vywnJW=FYkW0eVfBVsO+Mbt3K@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7973330465483830154=="
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik+SWY4Ka8oCH+rcApNsd6DufNriKR2f6hFYCkJ@mail.gmail.com>
In-Reply-To: <AANLkTik+SWY4Ka8oCH+rcApNsd6DufNriKR2f6hFYCkJ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7973330465483830154==
Content-Type: multipart/alternative; boundary=0016e6da98be26cdd3049b01e406

--0016e6da98be26cdd3049b01e406
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Jan 29, 2011 at 12:11 PM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Dylan,
>
> On Sat, 29 Jan 2011 11:54:47 -0800, Dylan wrote:
> > Hello all.
> >
> > I've done my best so far to solve my problems with information available
> but
> > I've hit a rut and I'm hoping I can get help here.
> >
> > I have a SuperMicro X8SIL-F motherboard with a WinBond W8367DHG sensor
> chip.
> > The CPU is an Intel Xeon X3440 running stock at 2.53GHz.
> > I am running UNRAID v4.7 which is based on Slackware kernel 2.6.32
> > This came with sensors v3.0.3 and libsensors v3.0.3.
> >
> > I have tweaked my sensors3.conf based on comparable systems as well as
> the
> > thresholds specified via the boards IPMI interface.
> >
> > PROBLEM: Upon booting the sensors readout displays reasonable values and
> all
> > the min/max values are as I set them. No ALARMs visible.
> > Within hours (minutes?) various min/max values change causing the
> reasonable
> > voltage/rpm/temp to now be out of range... resulting in ALARMs being
> raised.
> >
> > QUESTION: What is causing, say, the VBAT min value to suddenly change
> from
> > my setting of +2.82V to 0V? Or the min RPM for HD FAN 2 to change from
> > 400RPM to 0RPM?
> >
> > Simply executing "sensors -s" again changes the values back and clears
> the
> > ALARMs, but this is not feasible to do this multiple times per day after
> > confirming the ALARMs are false.
>
> Never use native hwmon drivers together with IPMI. They access the same
> device in a non-synchronized manner, resulting in reads from / write to
> the wrong register. The problem your describe is most certainly caused
> by this. If your system uses IPMI, don't load native hwmon drivers.
>

Thanks for your quick response. Your idea of conflicting reads/writes sounds
very plausible.
So, with UNRAID I am no explicitly loading any hwmon drives or IPMI drivers.
Can you give me a pointer as to how I might resolve this conflict?
Is this an issue as how I've modified sensors3.conf or something more
fundamental with kernel modules?

Thanks!
Dylan Parker


>
> > On a slight aside, I am unable to set the div values on my fans and the
> > associated /sys/class/hwmon4/device/fanX_div files are read-only.
>
> This is by driver design, the w83627ehf driver tries to be smart and to
> pick the best clock divider value for you automatically.
>
> > As these values change causing ALARMs to be thrown in the sensors output,
> > there is no related events in the IPMI sensor logs.
> >
> > Any help appreciated!
>
> --
> Jean Delvare
>

--0016e6da98be26cdd3049b01e406
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sat, Jan 29, 2011 at 12:11 PM, Jean D=
elvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@li=
nux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

Hi Dylan,<br>
<div class=3D"im"><br>
On Sat, 29 Jan 2011 11:54:47 -0800, Dylan wrote:<br>
&gt; Hello all.<br>
&gt;<br>
&gt; I&#39;ve done my best so far to solve my problems with information ava=
ilable but<br>
&gt; I&#39;ve hit a rut and I&#39;m hoping I can get help here.<br>
&gt;<br>
&gt; I have a SuperMicro X8SIL-F motherboard with a WinBond W8367DHG sensor=
 chip.<br>
&gt; The CPU is an Intel Xeon X3440 running stock at 2.53GHz.<br>
&gt; I am running UNRAID v4.7 which is based on Slackware kernel 2.6.32<br>
&gt; This came with sensors v3.0.3 and libsensors v3.0.3.<br>
&gt;<br>
&gt; I have tweaked my sensors3.conf based on comparable systems as well as=
 the<br>
&gt; thresholds specified via the boards IPMI interface.<br>
&gt;<br>
&gt; PROBLEM: Upon booting the sensors readout displays reasonable values a=
nd all<br>
&gt; the min/max values are as I set them. No ALARMs visible.<br>
&gt; Within hours (minutes?) various min/max values change causing the reas=
onable<br>
&gt; voltage/rpm/temp to now be out of range... resulting in ALARMs being r=
aised.<br>
&gt;<br>
&gt; QUESTION: What is causing, say, the VBAT min value to suddenly change =
from<br>
&gt; my setting of +2.82V to 0V? Or the min RPM for HD FAN 2 to change from=
<br>
&gt; 400RPM to 0RPM?<br>
&gt;<br>
&gt; Simply executing &quot;sensors -s&quot; again changes the values back =
and clears the<br>
&gt; ALARMs, but this is not feasible to do this multiple times per day aft=
er<br>
&gt; confirming the ALARMs are false.<br>
<br>
</div>Never use native hwmon drivers together with IPMI. They access the sa=
me<br>
device in a non-synchronized manner, resulting in reads from / write to<br>
the wrong register. The problem your describe is most certainly caused<br>
by this. If your system uses IPMI, don&#39;t load native hwmon drivers.<br>=
</blockquote><div><br></div><div>Thanks for your quick response. Your idea =
of conflicting reads/writes sounds very plausible.</div><div>So, with UNRAI=
D I am no explicitly loading any hwmon drives or IPMI drivers. Can you give=
 me a pointer as to how I might resolve this conflict?</div>

<div>Is this an issue as how I&#39;ve modified sensors3.conf or something m=
ore fundamental with kernel modules?</div><div><br></div><div>Thanks!</div>=
<div>Dylan Parker</div><div>=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">


<div class=3D"im"><br>
&gt; On a slight aside, I am unable to set the div values on my fans and th=
e<br>
&gt; associated /sys/class/hwmon4/device/fanX_div files are read-only.<br>
<br>
</div>This is by driver design, the w83627ehf driver tries to be smart and =
to<br>
pick the best clock divider value for you automatically.<br>
<div class=3D"im"><br>
&gt; As these values change causing ALARMs to be thrown in the sensors outp=
ut,<br>
&gt; there is no related events in the IPMI sensor logs.<br>
&gt;<br>
&gt; Any help appreciated!<br>
<br>
</div>--<br>
<font color=3D"#888888">Jean Delvare<br>
</font></blockquote></div><br>

--0016e6da98be26cdd3049b01e406--


--===============7973330465483830154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7973330465483830154==--
