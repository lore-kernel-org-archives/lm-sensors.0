From: Sreekanth W <w.sreekanth@gmail.com>
Date: Sat, 02 Feb 2013 15:21:17 +0000
Subject: Re: [lm-sensors] SMSC SIO10n268 Super I/O Linux support
Message-Id: <CANSy19jw5ZBtG2DtDddq2UTWap5O0SnzEKueO=L00NtOnzXfGw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7434777091064922030=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CANSy19gSLySBGDBkD5bbTjY7F6y3vmqWquSC0=8HuV4rzr8krw@mail.gmail.com>
In-Reply-To: <CANSy19gSLySBGDBkD5bbTjY7F6y3vmqWquSC0=8HuV4rzr8krw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7434777091064922030==
Content-Type: multipart/alternative; boundary=e89a8fb2027669fd4904d4bf3e89

--e89a8fb2027669fd4904d4bf3e89
Content-Type: text/plain; charset=ISO-8859-1

Thanks again,

May be I'm new to the Super I/O device, I was just curious to know more
info about it, but not found much info on this device support in Linux,
though I found some code/patch in Coreboot and lm-sensors.

Let me test this device using the UART driver in Linux, and hope it should
work.

Sreekanth

On Sat, Feb 2, 2013 at 9:47 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Sat, Feb 02, 2013 at 09:31:38AM +0530, Sreekanth W wrote:
> > Hi Guenter,
> >
> Please don't top-post.
>
> > Thanks for your response.
> >
> > Yes, this Super I/O is not a Sensor.
> > But I'm just wondering will it work with the standard Linux 8250 UART
> > driver, or any additional driver is required for this device to control
> > it's Serial port registers and the Serial port to be functional.
> >
> Do you have any indication that there is a problem ?
>
> If not, the time to bother about it is if/when it is not working, not
> beforehand.
>
> Thanks,
> Guenter
>
> > Regards,
> > Sreekanth
> >
> > On Sat, Feb 2, 2013 at 12:05 AM, Guenter Roeck <linux@roeck-us.net>
> wrote:
> >
> > > On Fri, Feb 01, 2013 at 08:42:56PM +0530, Sreekanth W wrote:
> > > > Hello,
> > > >
> > > > I would like to know whether the SMSC SIO10n268 Super I/O support
> exist
> > > in
> > > > the Linux kernel? Does it need a Linux Kernel driver? OR does it work
> > > with
> > > > the lm-sensors package?
> > > >
> > > Unless I am missing something, this chip does not have hardware
> monitoring
> > > support, so there won't be a hardware monitoring driver for it.
> > >
> > > > I'm able to detect the device with "sensors-detect" and "superiotool"
> > > > utilities, also able to dump the device registers with "superiotool
> -d".
> > > >
> > > > How to configure a UART port connected to this Super IO device? Is
> there
> > > > any other application/tool for this?
> > > >
> > > Per datasheet: "High Speed NS16C550 Compatible UARTs with Send/Receive
> > > 16-Byte FIFOs". It should behave like a standard UART port.
> > > Do you have any indication that this is not the case ?
> > >
> > > Thanks,
> > > Guenter
> > >
>

--e89a8fb2027669fd4904d4bf3e89
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Thanks again, </div><div>=A0</div><div>May be I&#39;m new to the Super=
 I/O device, I was just curious to know more info about it, but not found m=
uch info on this device support in Linux, though I found some=A0code/patch =
in Coreboot and lm-sensors.</div>
<div>=A0</div><div>Let me=A0test this device using=A0the UART driver in=A0L=
inux, and hope it should work.</div><div>=A0</div><div>Sreekanth<br>=A0</di=
v><div class=3D"gmail_quote">On Sat, Feb 2, 2013 at 9:47 AM, Guenter Roeck =
<span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blan=
k">linux@roeck-us.net</a>&gt;</span> wrote:<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;padding-left:1ex;border-left-=
color:rgb(204,204,204);border-left-width:1px;border-left-style:solid" class=
=3D"gmail_quote">On Sat, Feb 02, 2013 at 09:31:38AM +0530, Sreekanth W wrot=
e:<br>

&gt; Hi Guenter,<br>
&gt;<br>
Please don&#39;t top-post.<br>
<div class=3D"im"><br>
&gt; Thanks for your response.<br>
&gt;<br>
&gt; Yes, this Super I/O is not a Sensor.<br>
&gt; But I&#39;m just wondering will it work with the standard Linux 8250 U=
ART<br>
&gt; driver, or any additional driver is required for this device to contro=
l<br>
&gt; it&#39;s Serial port registers and the Serial port to be functional.<b=
r>
&gt;<br>
</div>Do you have any indication that there is a problem ?<br>
<br>
If not, the time to bother about it is if/when it is not working, not befor=
ehand.<br>
<br>
Thanks,<br>
Guenter<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; Regards,<br>
&gt; Sreekanth<br>
&gt;<br>
&gt; On Sat, Feb 2, 2013 at 12:05 AM, Guenter Roeck &lt;<a href=3D"mailto:l=
inux@roeck-us.net">linux@roeck-us.net</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Fri, Feb 01, 2013 at 08:42:56PM +0530, Sreekanth W wrote:<br>
&gt; &gt; &gt; Hello,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I would like to know whether the SMSC SIO10n268 Super I/O su=
pport exist<br>
&gt; &gt; in<br>
&gt; &gt; &gt; the Linux kernel? Does it need a Linux Kernel driver? OR doe=
s it work<br>
&gt; &gt; with<br>
&gt; &gt; &gt; the lm-sensors package?<br>
&gt; &gt; &gt;<br>
&gt; &gt; Unless I am missing something, this chip does not have hardware m=
onitoring<br>
&gt; &gt; support, so there won&#39;t be a hardware monitoring driver for i=
t.<br>
&gt; &gt;<br>
&gt; &gt; &gt; I&#39;m able to detect the device with &quot;sensors-detect&=
quot; and &quot;superiotool&quot;<br>
&gt; &gt; &gt; utilities, also able to dump the device registers with &quot=
;superiotool -d&quot;.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; How to configure a UART port connected to this Super IO devi=
ce? Is there<br>
&gt; &gt; &gt; any other application/tool for this?<br>
&gt; &gt; &gt;<br>
&gt; &gt; Per datasheet: &quot;High Speed NS16C550 Compatible UARTs with Se=
nd/Receive<br>
&gt; &gt; 16-Byte FIFOs&quot;. It should behave like a standard UART port.<=
br>
&gt; &gt; Do you have any indication that this is not the case ?<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Guenter<br>
&gt; &gt;<br>
</div></div></blockquote></div><br>

--e89a8fb2027669fd4904d4bf3e89--


--===============7434777091064922030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7434777091064922030==--
