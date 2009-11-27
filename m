From: =?ISO-8859-1?Q?Charles_Pr=E9vot?= <charlesprevot@gmail.com>
Date: Fri, 27 Nov 2009 08:24:56 +0000
Subject: Re: [lm-sensors] /sys/class/hwmon/ numbering
Message-Id: <18910e4d0911270024n40153626wefc513ec221d0f80@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0391372531931252014=="
List-Id: <lm-sensors.vger.kernel.org>
References: <18910e4d0911260014m5fe3445cmf423b25e6a68bf50@mail.gmail.com>
In-Reply-To: <18910e4d0911260014m5fe3445cmf423b25e6a68bf50@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0391372531931252014==
Content-Type: multipart/alternative; boundary=00032555819edffbef047956069d

--00032555819edffbef047956069d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2009 at 9:01 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Bonjour Charles,
>
> On Thu, 26 Nov 2009 09:14:45 +0100, Charles Pr=E9vot wrote:
> > I have some problems configuring the fancontrol script, because each ti=
me
> I
> > shutdown my computer, when I reboot my /sys/class/hwmon/ is different
> > (subfolders hwmon? are numbered differently).
> > What is responsible for this order ?
> > How can I configure it to have i fixed order ?
> >
> > my motherboard is a Asus MN2 SLI DELUXE with AMD CPU
> > below some results:
> >
> > $ls -l /sys/class/hwmon/hwmon?/
> > /sys/class/hwmon/hwmon0/:
> > total 0
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 name
> > drwxr-xr-x 2 root root    0 2009-11-26 08:51 power
> > lrwxrwxrwx 1 root root    0 2009-11-26 08:51 subsystem ->
> > ../../../../class/hwmon
> > -r--r--r-- 1 root root 4096 2009-11-26 08:51 temp1_crit
> > -r--r--r-- 1 root root 4096 2009-11-26 08:35 temp1_input
> > -rw-r--r-- 1 root root 4096 2009-11-26 08:51 uevent
> >
> > /sys/class/hwmon/hwmon1/:
> > total 0
> > lrwxrwxrwx 1 root root    0 2009-11-26 08:30 device ->
> ../../../ATK0110:00
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan1_input
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan1_label
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan1_max
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan1_min
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan2_input
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan2_label
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan2_max
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan2_min
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan3_input
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan3_label
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan3_max
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan3_min
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_input
> > -r--r--r-- 1 root root 4096 2009-11-26 08:27 in0_label
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_max
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_min
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_input
> > -r--r--r-- 1 root root 4096 2009-11-26 08:27 in1_label
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_max
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_min
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_input
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 in2_label
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_max
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_min
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_input
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 in3_label
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_max
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_min
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 name
> > drwxr-xr-x 2 root root    0 2009-11-26 08:30 power
> > lrwxrwxrwx 1 root root    0 2009-11-26 08:30 subsystem ->
> > ../../../../../../../class/hwmon
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp1_crit
> > -r--r--r-- 1 root root 4096 2009-11-26 08:11 temp1_input
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp1_label
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp1_max
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp2_crit
> > -r--r--r-- 1 root root 4096 2009-11-26 08:26 temp2_input
> > -r--r--r-- 1 root root 4096 2009-11-26 08:33 temp2_label
> > -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp2_max
> > -rw-r--r-- 1 root root 4096 2009-11-26 08:30 uevent
> >
> > /sys/class/hwmon/hwmon2/:
> > total 0
> > lrwxrwxrwx 1 root root    0 2009-11-26 08:35 device -> ../../../it87.65=
6
> > drwxr-xr-x 2 root root    0 2009-11-26 08:51 power
> > lrwxrwxrwx 1 root root    0 2009-11-26 08:51 subsystem ->
> > ../../../../../class/hwmon
> > -rw-r--r-- 1 root root 4096 2009-11-26 08:51 uevent
> >
> > $ cat /sys/class/hwmon/hwmon0/name
> > acpitz
> > $ cat /sys/class/hwmon/hwmon1/name
> > atk0110
>
> This is not the question you were asking, but you should NOT be using
> drivers asus_atk0110 and it87 together. They access the same piece of
> hardware, without synchronization of any form, which is dangerous. If
> your kernel is recent enough that it has the asus_atk0110 driver (you
> did not tell us the exact kernel version... I guess 2.6.30?) then you
> should stop using the it87 driver. Kernel 2.6.31 and later will prevent
> you from loading it87 so you better get used to it.
>
Ok, if you say so... I was using it87 because sensors-detect told me to. I'=
m
using the latest kernel version proposed by ubuntu karmic (should be
2.6.31-15 but I'm not in front of this computer right now). I will
investigate this when I get back home.
Is asus_atk0110 supposed to managed the "Cool'n Quiet" feature ?

>
> This will indirectly solve your problem, although probably not the way
> you would like: the asus_atk0110 driver doesn't offer manual fan speed
> control facilities, instead you must select the automatic fan speed
> control strategy in the BIOS.
>
I think the strategy is ok in the bios settings (as far as I recall it was
working on windows), but I will look at it too. I don't want a manual fan
speed control, I was using the fancontrol script to slow them depending on
the temperatures, if the bios can do it automatically it's ok for me, but
I'm not sure it's the case...

>
> I'm not sure about the ACPI thermal zone, I thought Asus boards did not
> have one. Luca, ever seen this before? Is it OK to use both the ACPI
> thermal driver and the asus_atk0110 driver at the same time?
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

--00032555819edffbef047956069d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Nov 27, 2009 at 9:01 AM, Jean De=
lvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@lin=
ux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Bonjour Charles,<br>
<div><div></div><div class=3D"h5"><br>
On Thu, 26 Nov 2009 09:14:45 +0100, Charles Pr=E9vot wrote:<br>
&gt; I have some problems configuring the fancontrol script, because each t=
ime I<br>
&gt; shutdown my computer, when I reboot my /sys/class/hwmon/ is different<=
br>
&gt; (subfolders hwmon? are numbered differently).<br>
&gt; What is responsible for this order ?<br>
&gt; How can I configure it to have i fixed order ?<br>
&gt;<br>
&gt; my motherboard is a Asus MN2 SLI DELUXE with AMD CPU<br>
&gt; below some results:<br>
&gt;<br>
&gt; $ls -l /sys/class/hwmon/hwmon?/<br>
&gt; /sys/class/hwmon/hwmon0/:<br>
&gt; total 0<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 name<br>
&gt; drwxr-xr-x 2 root root =A0 =A00 2009-11-26 08:51 power<br>
&gt; lrwxrwxrwx 1 root root =A0 =A00 2009-11-26 08:51 subsystem -&gt;<br>
&gt; ../../../../class/hwmon<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:51 temp1_crit<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:35 temp1_input<br>
&gt; -rw-r--r-- 1 root root 4096 2009-11-26 08:51 uevent<br>
&gt;<br>
&gt; /sys/class/hwmon/hwmon1/:<br>
&gt; total 0<br>
&gt; lrwxrwxrwx 1 root root =A0 =A00 2009-11-26 08:30 device -&gt; ../../..=
/ATK0110:00<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan1_input<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan1_label<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan1_max<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan1_min<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan2_input<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan2_label<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan2_max<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan2_min<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan3_input<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan3_label<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 fan3_max<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 fan3_min<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_input<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:27 in0_label<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_max<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_min<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_input<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:27 in1_label<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_max<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_min<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_input<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 in2_label<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_max<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_min<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_input<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 in3_label<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_max<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_min<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 name<br>
&gt; drwxr-xr-x 2 root root =A0 =A00 2009-11-26 08:30 power<br>
&gt; lrwxrwxrwx 1 root root =A0 =A00 2009-11-26 08:30 subsystem -&gt;<br>
&gt; ../../../../../../../class/hwmon<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp1_crit<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:11 temp1_input<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp1_label<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp1_max<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp2_crit<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:26 temp2_input<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:33 temp2_label<br>
&gt; -r--r--r-- 1 root root 4096 2009-11-26 08:30 temp2_max<br>
&gt; -rw-r--r-- 1 root root 4096 2009-11-26 08:30 uevent<br>
&gt;<br>
&gt; /sys/class/hwmon/hwmon2/:<br>
&gt; total 0<br>
&gt; lrwxrwxrwx 1 root root =A0 =A00 2009-11-26 08:35 device -&gt; ../../..=
/it87.656<br>
&gt; drwxr-xr-x 2 root root =A0 =A00 2009-11-26 08:51 power<br>
&gt; lrwxrwxrwx 1 root root =A0 =A00 2009-11-26 08:51 subsystem -&gt;<br>
&gt; ../../../../../class/hwmon<br>
&gt; -rw-r--r-- 1 root root 4096 2009-11-26 08:51 uevent<br>
&gt;<br>
&gt; $ cat /sys/class/hwmon/hwmon0/name<br>
&gt; acpitz<br>
&gt; $ cat /sys/class/hwmon/hwmon1/name<br>
&gt; atk0110<br>
<br>
</div></div>This is not the question you were asking, but you should NOT be=
 using<br>
drivers asus_atk0110 and it87 together. They access the same piece of<br>
hardware, without synchronization of any form, which is dangerous. If<br>
your kernel is recent enough that it has the asus_atk0110 driver (you<br>
did not tell us the exact kernel version... I guess 2.6.30?) then you<br>
should stop using the it87 driver. Kernel 2.6.31 and later will prevent<br>
you from loading it87 so you better get used to it.<br></blockquote><div>Ok=
, if you say so... I was using it87 because sensors-detect told me to. I&#3=
9;m using the latest kernel version proposed by ubuntu karmic (should be 2.=
6.31-15 but I&#39;m not in front of this computer right now). I will invest=
igate this when I get back home.<br>
Is asus_atk0110 supposed to managed the &quot;Cool&#39;n Quiet&quot; featur=
e ?<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px so=
lid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
This will indirectly solve your problem, although probably not the way<br>
you would like: the asus_atk0110 driver doesn&#39;t offer manual fan speed<=
br>
control facilities, instead you must select the automatic fan speed<br>
control strategy in the BIOS.<br></blockquote><div>I think the strategy is =
ok in the bios settings (as far as I recall it was working on windows), but=
 I will look at it too. I don&#39;t want a manual fan speed control, I was =
using the fancontrol script to slow them depending on the temperatures, if =
the bios can do it automatically it&#39;s ok for me, but I&#39;m not sure i=
t&#39;s the case... <br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
I&#39;m not sure about the ACPI thermal zone, I thought Asus boards did not=
<br>
have one. Luca, ever seen this before? Is it OK to use both the ACPI<br>
thermal driver and the asus_atk0110 driver at the same time?<br>
<font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
<a href=3D"http://khali.linux-fr.org/wishlist.html" target=3D"_blank">http:=
//khali.linux-fr.org/wishlist.html</a><br>
</font></blockquote></div><br>

--00032555819edffbef047956069d--


--===============0391372531931252014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0391372531931252014==--
