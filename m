From: earl middlebrook <eamiddlebrook@gmail.com>
Date: Fri, 28 Jun 2013 14:34:26 +0000
Subject: Re: [lm-sensors] inaccurate fan speed
Message-Id: <CA+Ei6tkpUy-+8M+vcyyBYEFYDD1ocyjH1JsfYed5oxtX66t9YA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3627763305377353509=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+Ei6tk5vue20Ga9qoRrDDkxUxHU08QUrWAkXWogx562VzpQ+w@mail.gmail.com>
In-Reply-To: <CA+Ei6tk5vue20Ga9qoRrDDkxUxHU08QUrWAkXWogx562VzpQ+w@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============3627763305377353509==
Content-Type: multipart/alternative; boundary=047d7b6d8b769c76d504e037c6ba

--047d7b6d8b769c76d504e037c6ba
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

Sorry for the delay in responce, work conference...


On Fri, Jun 21, 2013 at 4:16 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Earl,
>
> Please keep the list included, so that your messages get archived.
>
> On Mon, 17 Jun 2013 12:21:14 -0600, earl middlebrook wrote:
> > Ubuntu did have thinkpad-acpi running.  I blacklisted it as suggested b=
y
> > Henrique.  Now the output of sensors is:
> > earl@ElFuturo[earl]
> > sensors                                                     [11:31AM]
> > acpitz-virtual-0
> > Adapter: Virtual device
> > temp1:        +70.0=B0C  (crit =3D +105.0=B0C)
> >
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:       +61.0=B0C  (high =3D +95.0=B0C, crit =3D +105.0=B0C)
> > Core 2:       +64.0=B0C  (high =3D +95.0=B0C, crit =3D +105.0=B0C)
> >
> > This seems much more reasonable.  Many of the temps detected by
> > thinkpad-acpi were 0C of fluctuating off the charts.
> > The cores temps are approximately the same as before.  They fluctuate
> > faster though.  Something about the update rate I suppose.
>
> The coretemp driver updates its values every second, and these
> integrated digital sensors are very prompt to reflect temperature
> changes.
>
> The values are relatively high but still reasonable: thermal margin is
> 31=B0C (not actual degrees Celsius BTW, but close enough.)
>
I assume the above are idle temperatures though, you should worry if
> the temperatures go too high when the machine is under load.
>
> > > (...)
> > > I had not heard of this before, but searching bugzilla.kernel.org for
> > > similar cases I found this report:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D27792
> > >
> > > The good news is that you're not alone. The bad news is that this bug
> > > report is getting old but the bug is still not fixed, apparently it's=
 a
> > > difficult one.
> >
> > It does look like it is not getting much attention any more...
>
> That's right. I've added a comment pointing to your report.
>
> > I dont understand much of what is going on but it sounds different than
> my
> > problem, at least on the surface.  For instance, I have no problems wit=
h
> > the buttons and the temps seem strange even after a cold boot.
>
> Yes, I have noticed these differences too, but I still suspect a common
> root cause.
>
> > > I'd recommend blacklisting thinkpad-acpi and doing a full cold boot o=
f
> the
> > > box (remove all batteries and AC, push power button at least ten time=
s
> for
> > > at least three seconds each, and the last one for at least 15
> seconds), to
> > > make sure thinkpad-acpi is not actually making matters worse.
> >
> > Done.  It removes non-sense sensor readings.  CPU still looks very hot.
> > The above sensors output was with only firefox up.
> >
> > > That said, usually these boxes work through the standard ACPI
> interface, and
> > > they _really_ depend on GPU and CPU throttling/clock/voltage control
> to keep
> > > cool.  Especially if the box has a cracked thermal interface or some
> other
> > > defect.
> >
> > Is this just a matter of getting in there and having a look?
>
> First you should ensure that all power saving options are enabled.
>
> For the CPU, these are C states and cpufreq (although the usefulness of
> cpufreq with good C states can be discussed.) Please install powertop,
> then check the Idle stats and Frequency stats panels (use the Tab key
> to navigate between these in recent versions of powertop.) You should
> see multiple C states in the first and multiple frequencies in the
> second.
>
> When the machine is idle, the CPU should spend most of the time at the
> lowest C states and the lowest frequency. If this isn't the case then
> something is wrong, either in the BIOS or in the kernel.
>

Here are Idle stats from PowerTOP:

**  Package              |             Core          |             CPU
0               CPU 2
                             |                             | C0 active
4.5%                0.5%
                             |                             | POLL
0.0%    0.0 ms      0.0%    0.0 ms
                             |                             | C1-NHM
0.0%    0.0 ms      0.0%    0.0 ms
C3 (pc3)   16.9%    | C3 (cc3)   15.0%    | C3-NHM      3.8%    0.9 ms
12.8%   32.3 ms
C6 (pc6)   59.9%    | C6 (cc6)   76.3%    | C6-NHM     89.3%    3.7 ms
86.3%    4.0 ms

                             |             Core          |             CPU
1               CPU 3
                             |                              | C0 active
1.6%                0.9%
                             |                              | POLL
0.0%    0.0 ms      0.0%    0.0 ms
                             |                              | C1-NHM
0.0%    0.0 ms      0.0%    0.0 ms
                             | C3 (cc3)    8.5%      | C3-NHM      4.3%
1.1 ms      5.3%    2.3 ms
                             | C6 (cc6)   86.0%     | C6-NHM     92.7%
3.3 ms     93.2%    3.3 ms


Here are Frequency Stats:

Package |             Core    |            CPU 0       CPU 2
                    |                     | Actual    2.0 Ghz     1.8 Ghz
Turbo Mode  14.8%   | Turbo Mode  12.8%   | Turbo Mode  12.5%        5.3%
2.40 Ghz     0.0%   | 2.40 Ghz     0.0%   | 2.40 Ghz     0.0%        0.0%
2.27 Ghz     0.1%   | 2.27 Ghz     0.1%   | 2.27 Ghz     0.1%        0.0%
2.14 Ghz     0.0%   | 2.14 Ghz     0.0%   | 2.14 Ghz     0.0%        0.0%
2.00 Ghz     0.0%   | 2.00 Ghz     0.0%   | 2.00 Ghz     0.0%        0.0%
1.87 Ghz     0.0%   | 1.87 Ghz     0.0%   | 1.87 Ghz     0.0%        0.0%
1.74 Ghz     0.9%   | 1.74 Ghz     0.6%   | 1.74 Ghz     0.5%        0.3%
1.60 Ghz     0.0%   | 1.60 Ghz     0.0%   | 1.60 Ghz     0.0%        0.0%
1466 Mhz     0.0%   | 1466 Mhz     0.0%   | 1466 Mhz     0.0%        0.0%
1333 Mhz     0.1%   | 1333 Mhz     0.0%   | 1333 Mhz     0.0%        0.0%

                    |             Core    |            CPU 1       CPU 3
                    |                     | Actual    1.8 Ghz     1.8 Ghz
                    | Turbo Mode  10.9%   | Turbo Mode  10.2%        8.7%
                    | 2.40 Ghz     0.0%   | 2.40 Ghz     0.0%        0.0%
                    | 2.27 Ghz     0.1%   | 2.27 Ghz     0.1%        0.0%
                    | 2.14 Ghz     0.0%   | 2.14 Ghz     0.0%        0.0%
                    | 2.00 Ghz     0.0%   | 2.00 Ghz     0.0%        0.0%
                    | 1.87 Ghz     0.0%   | 1.87 Ghz     0.0%        0.0%
                    | 1.74 Ghz     0.8%   | 1.74 Ghz     0.8%        0.8%
                    | 1.60 Ghz     0.0%   | 1.60 Ghz     0.0%        0.0%
                    | 1466 Mhz     0.0%   | 1466 Mhz     0.0%        0.0%
                    | 1333 Mhz     0.1%   | 1333 Mhz     0.0%        0.0%

Noticed this in Tunables:
>> Good          Using 'ondemand' cpufreq governor

Could I try to toggle it and see if there is a conflict?



> You may also check the power management of the graphics chip. But that
> depends a lot on which graphics chip you have and which driver you use
> for it.
>
> > > We really need a dump of the kernel boot messages to know more.
> >
> > Could you direct me to where this is located so I may pass it along?
>
> Right after boot, just do:
> $ dmesg > /tmp/dmesg.txt
> And share the file with us (send it via private e-mail or post it to
> some pastebin site.)
>
> Private E-mail on the way.

> --
> Jean Delvare
>



--=20
Earl Middlebrook
Potts Lab
University of Utah
Lab phone 801 585 9678

--047d7b6d8b769c76d504e037c6ba
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all,<br><br></div>Sorry for the delay in responce,=
 work conference...<br><div><div><div class=3D"gmail_extra"><br><br><div cl=
ass=3D"gmail_quote">On Fri, Jun 21, 2013 at 4:16 AM, Jean Delvare <span dir=
=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org" target=3D"_blank">khali@=
linux-fr.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi Earl,<br>
<br>
Please keep the list included, so that your messages get archived.<br>
<div><br>
On Mon, 17 Jun 2013 12:21:14 -0600, earl middlebrook wrote:<br>
&gt; Ubuntu did have thinkpad-acpi running. =A0I blacklisted it as suggeste=
d by<br>
&gt; Henrique. =A0Now the output of sensors is:<br>
&gt; earl@ElFuturo[earl]<br>
&gt; sensors =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [11:31AM]<br>
&gt; acpitz-virtual-0<br>
&gt; Adapter: Virtual device<br>
&gt; temp1: =A0 =A0 =A0 =A0+70.0=B0C =A0(crit =3D +105.0=B0C)<br>
&gt;<br>
&gt; coretemp-isa-0000<br>
&gt; Adapter: ISA adapter<br>
&gt; Core 0: =A0 =A0 =A0 +61.0=B0C =A0(high =3D +95.0=B0C, crit =3D +105.0=
=B0C)<br>
&gt; Core 2: =A0 =A0 =A0 +64.0=B0C =A0(high =3D +95.0=B0C, crit =3D +105.0=
=B0C)<br>
&gt;<br>
&gt; This seems much more reasonable. =A0Many of the temps detected by<br>
&gt; thinkpad-acpi were 0C of fluctuating off the charts.<br>
&gt; The cores temps are approximately the same as before. =A0They fluctuat=
e<br>
&gt; faster though. =A0Something about the update rate I suppose.<br>
<br>
</div>The coretemp driver updates its values every second, and these<br>
integrated digital sensors are very prompt to reflect temperature<br>
changes.<br>
<br>
The values are relatively high but still reasonable: thermal margin is<br>
31=B0C (not actual degrees Celsius BTW, but close enough.)<br></blockquote>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
I assume the above are idle temperatures though, you should worry if<br>
the temperatures go too high when the machine is under load.<br>
<br>
&gt; &gt; (...)<br>
<div>&gt; &gt; I had not heard of this before, but searching <a href=3D"htt=
p://bugzilla.kernel.org" target=3D"_blank">bugzilla.kernel.org</a> for<br>
&gt; &gt; similar cases I found this report:<br>
&gt; &gt; <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D27792" t=
arget=3D"_blank">https://bugzilla.kernel.org/show_bug.cgi?id=3D27792</a><br=
>
&gt; &gt;<br>
&gt; &gt; The good news is that you&#39;re not alone. The bad news is that =
this bug<br>
&gt; &gt; report is getting old but the bug is still not fixed, apparently =
it&#39;s a<br>
&gt; &gt; difficult one.<br>
&gt;<br>
&gt; It does look like it is not getting much attention any more...<br>
<br>
</div>That&#39;s right. I&#39;ve added a comment pointing to your report.<b=
r>
<div><br>
&gt; I dont understand much of what is going on but it sounds different tha=
n my<br>
&gt; problem, at least on the surface. =A0For instance, I have no problems =
with<br>
&gt; the buttons and the temps seem strange even after a cold boot.<br>
<br>
</div>Yes, I have noticed these differences too, but I still suspect a comm=
on<br>
root cause.<br>
<div><br>
&gt; &gt; I&#39;d recommend blacklisting thinkpad-acpi and doing a full col=
d boot of the<br>
&gt; &gt; box (remove all batteries and AC, push power button at least ten =
times for<br>
&gt; &gt; at least three seconds each, and the last one for at least 15 sec=
onds), to<br>
&gt; &gt; make sure thinkpad-acpi is not actually making matters worse.<br>
&gt;<br>
&gt; Done. =A0It removes non-sense sensor readings. =A0CPU still looks very=
 hot.<br>
&gt; The above sensors output was with only firefox up.<br>
&gt;<br>
&gt; &gt; That said, usually these boxes work through the standard ACPI int=
erface, and<br>
&gt; &gt; they _really_ depend on GPU and CPU throttling/clock/voltage cont=
rol to keep<br>
&gt; &gt; cool. =A0Especially if the box has a cracked thermal interface or=
 some other<br>
&gt; &gt; defect.<br>
&gt;<br>
&gt; Is this just a matter of getting in there and having a look?<br>
<br>
</div>First you should ensure that all power saving options are enabled.<br=
>
<br>
For the CPU, these are C states and cpufreq (although the usefulness of<br>
cpufreq with good C states can be discussed.) Please install powertop,<br>
then check the Idle stats and Frequency stats panels (use the Tab key<br>
to navigate between these in recent versions of powertop.) You should<br>
see multiple C states in the first and multiple frequencies in the<br>
second.<br>
<br>
When the machine is idle, the CPU should spend most of the time at the<br>
lowest C states and the lowest frequency. If this isn&#39;t the case then<b=
r>
something is wrong, either in the BIOS or in the kernel.<br></blockquote><d=
iv><br></div><div>Here are Idle stats from PowerTOP: <br></div><div><br><b>=
</b>=A0 Package=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 |=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Core =A0 =A0 =A0=A0 =A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 CPU 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CPU 2<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 =
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0=A0 =A0=
 | C0 active=A0=A0 4.5%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.5%<b=
r>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0=A0 =
=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0=A0=
 =A0 | POLL=A0=A0=A0=A0=A0=A0=A0 0.0%=A0=A0=A0 0.0 ms=A0=A0=A0=A0=A0 0.0%=
=A0=A0=A0 0.0 ms<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 =A0 =A0 =A0 =A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 =A0 =A0 =A0=A0 =A0 | C1-NHM=A0=A0=A0=A0=A0 0.0%=A0=A0=A0 0.0 ms=A0=A0=
=A0=A0=A0 0.0%=A0=A0=A0 0.0 ms<br>

C3 (pc3)=A0=A0 16.9%=A0=A0=A0 | C3 (cc3)=A0=A0 15.0%=A0=A0=A0 | C3-NHM=A0=
=A0=A0=A0=A0 3.8%=A0=A0=A0 0.9 ms=A0=A0=A0=A0 12.8%=A0=A0 32.3 ms<br>C6 (pc=
6)=A0=A0 59.9%=A0=A0=A0 | C6 (cc6)=A0=A0 76.3%=A0=A0=A0 | C6-NHM=A0=A0=A0=
=A0 89.3%=A0=A0=A0 3.7 ms=A0=A0=A0=A0 86.3%=A0=A0=A0 4.0 ms<br><br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0=A0 |=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Core=A0=A0 =A0 =A0 =A0=A0 |=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 CPU 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CP=
U 3<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0=
=A0 | C0 active=A0=A0 1.6%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.9=
%<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0=
=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0=
 =A0=A0 | POLL=A0=A0=A0=A0=A0=A0=A0 0.0%=A0=A0=A0 0.0 ms=A0=A0=A0=A0=A0 0.0=
%=A0=A0=A0 0.0 ms<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =
=A0 =A0 =A0 =A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | C1-NHM=A0=A0=A0=A0=A0 0.0%=A0=A0=A0 0.0 ms=A0=A0=A0=
=A0=A0 0.0%=A0=A0=A0 0.0 ms<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 | =
C3 (cc3)=A0=A0=A0 8.5%=A0=A0 =A0=A0 | C3-NHM=A0=A0=A0=A0=A0 4.3%=A0=A0=A0 1=
.1 ms=A0=A0=A0=A0=A0 5.3%=A0=A0=A0 2.3 ms<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0=A0 | C6 (cc6)=A0=A0 86.0%=A0=A0 =
=A0 | C6-NHM=A0=A0=A0=A0 92.7%=A0=A0=A0 3.3 ms=A0=A0=A0=A0 93.2%=A0=A0=A0 3=
.3 ms<br></div><div>
<br>
<br>Here are Frequency Stats:<br><br>Package |=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Core=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CPU 0=A0=A0=A0=
=A0=A0=A0 CPU 2<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | Actual=
=A0=A0=A0 2.0 Ghz=A0=A0=A0=A0 1.8 Ghz<br>Turbo Mode=A0 14.8%=A0=A0 | Turbo =
Mode=A0 12.8%=A0=A0 | Turbo Mode=A0 12.5%=A0=A0=A0=A0=A0=A0=A0 5.3%<br>

2.40 Ghz=A0=A0=A0=A0 0.0%=A0=A0 | 2.40 Ghz=A0=A0=A0=A0 0.0%=A0=A0 | 2.40 Gh=
z=A0=A0=A0=A0 0.0%=A0=A0=A0=A0=A0=A0=A0 0.0%<br>2.27 Ghz=A0=A0=A0=A0 0.1%=
=A0=A0 | 2.27 Ghz=A0=A0=A0=A0 0.1%=A0=A0 | 2.27 Ghz=A0=A0=A0=A0 0.1%=A0=A0=
=A0=A0=A0=A0=A0 0.0%<br>2.14 Ghz=A0=A0=A0=A0 0.0%=A0=A0 | 2.14 Ghz=A0=A0=A0=
=A0 0.0%=A0=A0 | 2.14 Ghz=A0=A0=A0=A0 0.0%=A0=A0=A0=A0=A0=A0=A0 0.0%<br>

2.00 Ghz=A0=A0=A0=A0 0.0%=A0=A0 | 2.00 Ghz=A0=A0=A0=A0 0.0%=A0=A0 | 2.00 Gh=
z=A0=A0=A0=A0 0.0%=A0=A0=A0=A0=A0=A0=A0 0.0%<br>1.87 Ghz=A0=A0=A0=A0 0.0%=
=A0=A0 | 1.87 Ghz=A0=A0=A0=A0 0.0%=A0=A0 | 1.87 Ghz=A0=A0=A0=A0 0.0%=A0=A0=
=A0=A0=A0=A0=A0 0.0%<br>1.74 Ghz=A0=A0=A0=A0 0.9%=A0=A0 | 1.74 Ghz=A0=A0=A0=
=A0 0.6%=A0=A0 | 1.74 Ghz=A0=A0=A0=A0 0.5%=A0=A0=A0=A0=A0=A0=A0 0.3%<br>

1.60 Ghz=A0=A0=A0=A0 0.0%=A0=A0 | 1.60 Ghz=A0=A0=A0=A0 0.0%=A0=A0 | 1.60 Gh=
z=A0=A0=A0=A0 0.0%=A0=A0=A0=A0=A0=A0=A0 0.0%<br>1466 Mhz=A0=A0=A0=A0 0.0%=
=A0=A0 | 1466 Mhz=A0=A0=A0=A0 0.0%=A0=A0 | 1466 Mhz=A0=A0=A0=A0 0.0%=A0=A0=
=A0=A0=A0=A0=A0 0.0%<br>1333 Mhz=A0=A0=A0=A0 0.1%=A0=A0 | 1333 Mhz=A0=A0=A0=
=A0 0.0%=A0=A0 | 1333 Mhz=A0=A0=A0=A0 0.0%=A0=A0=A0=A0=A0=A0=A0 0.0%<br>

<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 Core=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
PU 1=A0=A0=A0=A0=A0=A0 CPU 3<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 | Actual=A0=A0=A0 1.8 Ghz=A0=A0=A0=A0 1.8 Ghz<br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | Turbo Mode=A0 10.9%=A0=A0 | Turbo Mo=
de=A0 10.2%=A0=A0=A0=A0=A0=A0=A0 8.7%<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 2.40 Ghz=A0=A0=
=A0=A0 0.0%=A0=A0 | 2.40 Ghz=A0=A0=A0=A0 0.0%=A0=A0=A0=A0=A0=A0=A0 0.0%<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 2.27 Ghz=A0=A0=
=A0=A0 0.1%=A0=A0 | 2.27 Ghz=A0=A0=A0=A0 0.1%=A0=A0=A0=A0=A0=A0=A0 0.0%<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 2.14 Ghz=A0=A0=
=A0=A0 0.0%=A0=A0 | 2.14 Ghz=A0=A0=A0=A0 0.0%=A0=A0=A0=A0=A0=A0=A0 0.0%<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 2.00 Ghz=A0=A0=
=A0=A0 0.0%=A0=A0 | 2.00 Ghz=A0=A0=A0=A0 0.0%=A0=A0=A0=A0=A0=A0=A0 0.0%<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1.87 Ghz=A0=A0=
=A0=A0 0.0%=A0=A0 | 1.87 Ghz=A0=A0=A0=A0 0.0%=A0=A0=A0=A0=A0=A0=A0 0.0%<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1.74 Ghz=A0=A0=
=A0=A0 0.8%=A0=A0 | 1.74 Ghz=A0=A0=A0=A0 0.8%=A0=A0=A0=A0=A0=A0=A0 0.8%<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1.60 Ghz=A0=A0=
=A0=A0 0.0%=A0=A0 | 1.60 Ghz=A0=A0=A0=A0 0.0%=A0=A0=A0=A0=A0=A0=A0 0.0%<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1466 Mhz=A0=A0=
=A0=A0 0.0%=A0=A0 | 1466 Mhz=A0=A0=A0=A0 0.0%=A0=A0=A0=A0=A0=A0=A0 0.0%<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1333 Mhz=A0=A0=
=A0=A0 0.1%=A0=A0 | 1333 Mhz=A0=A0=A0=A0 0.0%=A0=A0=A0=A0=A0=A0=A0 0.0%<br>

<br></div><div>Noticed this in Tunables:<br>&gt;&gt; Good=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Using &#39;ondemand&#39; cpufreq governor=A0=A0=A0=A0=A0=A0=A0=A0=
 <br><br></div><div>Could I try to toggle it and see if there is a conflict=
?<br></div><div><br>=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">

You may also check the power management of the graphics chip. But that<br>
depends a lot on which graphics chip you have and which driver you use<br>
for it.<br>
<div><br>
&gt; &gt; We really need a dump of the kernel boot messages to know more.<b=
r>
&gt;<br>
&gt; Could you direct me to where this is located so I may pass it along?<b=
r>
<br>
</div>Right after boot, just do:<br>
$ dmesg &gt; /tmp/dmesg.txt<br>
And share the file with us (send it via private e-mail or post it to<br>
some pastebin site.)<br>
<span><font color=3D"#888888"><br></font></span></blockquote><div>Private E=
-mail on the way. <br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<span><font color=3D"#888888">
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Earl Midd=
lebrook<div>Potts Lab</div><div>University of Utah</div><div>Lab phone <a h=
ref=3D"tel:801%20585%209678" value=3D"+18015859678" target=3D"_blank">801 5=
85 9678</a></div>
<div><br></div>
</div></div></div></div>

--047d7b6d8b769c76d504e037c6ba--


--===============3627763305377353509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3627763305377353509==--
