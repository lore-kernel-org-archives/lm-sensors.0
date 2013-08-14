From: "Dev, Kapil" <kapil_dev@brown.edu>
Date: Wed, 14 Aug 2013 20:45:43 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <CAFSPGzSf0Cusfa=uo39H3hnYmZxG9bgrcnkEo46TrnMHquqwNQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="089e0160bc92f0ebb504e3ee700f"
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--089e0160bc92f0ebb504e3ee700f
Content-Type: multipart/alternative; boundary=089e0160bc92f0ebb104e3ee700d

--089e0160bc92f0ebb104e3ee700d
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2013 at 4:03 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Aug 14, 2013 at 03:06:35PM -0400, Dev, Kapil wrote:
> > On Wed, Aug 14, 2013 at 2:29 PM, Guenter Roeck <linux@roeck-us.net>
> wrote:
> >
> > > On Wed, Aug 14, 2013 at 01:20:57PM -0400, Dev, Kapil wrote:
> > > > On Wed, Aug 14, 2013 at 1:30 AM, Guenter Roeck <linux@roeck-us.net>
> > > wrote:
> > > >
> > > > > On 08/13/2013 10:17 PM, Kapil Dev wrote:
> > > > >
> > > > >>
> > > > >> On Aug 14, 2013, at 12:56 AM, Guenter Roeck <linux@roeck-us.net>
> > > wrote:
> > > > >>
> > > > >>  On 08/13/2013 08:09 PM, Dev, Kapil wrote:
> > > > >>>
> > > > >>>>
> > > > >>>>
> > > > >>>> On Tue, Aug 13, 2013 at 11:02 PM, Guenter Roeck <
> linux@roeck-us.net
> > > <mailto:
> > > > >>>> linux@roeck-us.net>> wrote:
> > > > >>>>
> > > > >>>>     On 08/13/2013 07:41 PM, Dev, Kapil wrote:
> > > > >>>>
> > > > >>>>         Thanks again Guenter!
> > > > >>>>
> > > > >>>>
> > > > >>>>
> > > > >>>>
> > > > >>>>         On Tue, Aug 13, 2013 at 5:51 PM, Guenter Roeck <
> > > > >>>> linux@roeck-us.net <mailto:linux@roeck-us.net> <mailto:
> > > > >>>> linux@roeck-us.net <mailto:linux@roeck-us.net>>> wrote:
> > > > >>>>
> > > > >>>>              On Tue, Aug 13, 2013 at 05:11:31PM -0400, Dev,
> Kapil
> > > wrote:
> > > > >>>>               > Thanks for the response Guenter!
> > > > >>>>               >
> > > > >>>>               > I put the system on load and I noticed their
> value
> > > > >>>> hardly changes. To my
> > > > >>>>               > surprise, I ran a benchmark for 3 minutes and
> none
> > > of
> > > > >>>> temp*  values changed
> > > > >>>>               > during execution. The highest reported
> temperature
> > > is
> > > > >>>> always 48C.
> > > > >>>>               >
> > > > >>>>               > I was expecting that the internal temperature
> would
> > > > >>>> have "sensor =3D thermal
> > > > >>>>               > diode" or "sensor =3D core" as a keyword. I
> thought
> > > > >>>> "sensor=3Dthermistor" means
> > > > >>>>               > the corresponding sensor is on the motherboard
> and
> > > not
> > > > >>>> the internal
> > > > >>>>               > die-sensor.
> > > > >>>>               >
> > > > >>>>              Sure, but who knows if they put a sensor below th=
e
> CPU
> > > for
> > > > >>>> some reason ...
> > > > >>>>
> > > > >>>>              I am not familiar with the A10 CPUs. Are those
> similar
> > > to
> > > > >>>> K10 ?
> > > > >>>>              If so, maybe the k10temp driver works or could be
> > > extended
> > > > >>>> to support it.
> > > > >>>>              Can you give it a try ?
> > > > >>>>
> > > > >>>>              If it does not work out of the box, can you send
> me the
> > > > >>>> output of "lspci -nn" ?
> > > > >>>>
> > > > >>>>
> > > > >>>>         Kapil: I believe K10 corresponds to A8 seried, and A10
> has
> > > > >>>> Bulldozer architecture (http://www.cpu-world.com/__**
> > > > >>>> CPUs/Bulldozer/TYPE-A10-__**Series.html<
> > > http://www.cpu-world.com/__CPUs/Bulldozer/TYPE-A10-__Series.html><
> > > > >>>>
> http://www.cpu-world.com/**CPUs/Bulldozer/TYPE-A10-**Series.html<
> > > http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html>>).
> > > > >>>> I am not sure how different they are though. I tried K10, but =
it
> > > did not
> > > > >>>> work out of the box. I am looking into k10temp.c driver now.
> Also,I
> > > am
> > > > >>>> attaching the output of "lspci -nn" command herewith; you migh=
t
> > > have to
> > > > >>>> open it using wordpad for proper formatting..
> > > > >>>>
> > > > >>>>
> > > > >>>>     Your lspci output includes
> > > > >>>>
> > > > >>>>     00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD]
> Device
> > > > >>>> [1022:1403]
> > > > >>>>
> > > > >>>>     which is supported by the latest k10temp driver. Support w=
as
> > > added
> > > > >>>> early last year.
> > > > >>>>     What is your kernel version, and can you switch to a more
> recent
> > > > >>>> version ?
> > > > >>>>
> > > > >>>>
> > > > >>>> Kapil: I have 2.6.39-020639-generic kernel. Is it too old
> kernel for
> > > > >>>> k10temp driver to work? Which stable kernel should I upgrade t=
o?
> > > > >>>>
> > > > >>>>
> > > > >>> You need 3.4 or later.
> > > > >>>
> > > > >>
> > > > >> Kapil: I was trying to avoid updating the kernel because my
> current
> > > > >> kernel is setup for running different type of benchmarks etc.
> Seems
> > > like I
> > > > >> can't avoid updating the kernel; I will do it..
> > > > >>
> > > > >>  Alternative would be to back-port the k10temp driver from a lat=
er
> > > > > kernel. Then you can keep running the old one.
> > > > >
> > > > >
> > > > Kapil: Not sure how to do that. I am already taking the k10temp
> driver
> > > from
> > > > here: http://khali.linux-fr.org/devel/lm-sensors/drivers/k10temp/an=
d
> > > > compiling and using it.
> > > >
> > > That version should already have support for your chip unless I am
> missing
> > > something. If you already use it, a newer kernel version will not hel=
p.
> > >
> > > Do you get any kernel log message when you try to load it ?
> > >
> >
> > Kapil: When I insert the module using: sudo insmod k10temp.ko, I don't
> get
> > any message on terminal. However, when I compile ktemp10.c file using
> make,
> > I get following warnings; I am not sure if they are acceptable.
> >
> -------------------------------------------------------------------------=
---
> > make[1]: Entering directory
> `/usr/src/linux-headers-2.6.39-020639-generic'
> >   CC [M]  /home/amd_a10/k10temp_driver/k10temp.o
> > /home//amd_a10/k10temp_driver/k10temp.c:232: warning: data definition h=
as
> > no type or storage class
> > /home//amd_a10/k10temp_driver/k10temp.c:232: warning: type defaults to
> > =91int=92 in declaration of =91module_pci_driver=92
> > /home//amd_a10/k10temp_driver/k10temp.c:232: warning: parameter names
> > (without types) in function declaration
> > /home//amd_a10/k10temp_driver/k10temp.c:225: warning: =91k10temp_driver=
=92
> > defined but not used
> >   Building modules, stage 2.
> >   MODPOST 1 modules
> >   CC      /home/amd_a10/k10temp_driver/k10temp.mod.o
> >   LD [M]  /home/amd_a10/k10temp_driver/k10temp.ko
> > make[1]: Leaving directory `/usr/src/linux-headers-2.6.39-020639-generi=
c'
> >
> There is no definition for module_pci_driver in your kernel,
> thus the initialization code won't run and the driver will
> not really be doing anything.
>
> You will have to replace
>
> module_pci_driver(k10temp_driver);
>
> with
>
> static int __init k10temp_init(void)
> {
>         return pci_register_driver(&k10temp_driver);
> }
>
> static void __exit k10temp_exit(void)
> {
>         pci_unregister_driver(&k10temp_driver);
> }
>
> module_init(k10temp_init)
> module_exit(k10temp_exit)
>
>
Kapil: After making above changes, I think it seems to work now. Now I am
getting following output from sensors:
f71869-isa-0e80
Adapter: ISA adapter
in0:         +1.69 V
in1:         +0.90 V
in2:         +1.21 V
in3:         +1.22 V
in4:         +1.49 V
in5:         +1.22 V
in6:         +1.19 V
in7:         +1.73 V
in8:         +1.66 V
fan1:       2177 RPM
fan2:          0 RPM  ALARM
fan3:          0 RPM  ALARM
temp1:       +24.0 C  (high =3D +85.0 C, hyst =3D +81.0 C)
                      (crit =3D +100.0 C, hyst =3D +96.0 C)  sensor =3D the=
rmistor
temp2:       +32.0 C  (high =3D +85.0 C, hyst =3D +81.0 C)
                      (crit =3D +100.0 C, hyst =3D +96.0 C)  sensor =3D the=
rmistor
temp3:       +48.0 C  (high =3D +70.0 C, hyst =3D +68.0 C)
                      (crit =3D +85.0 C, hyst =3D +83.0 C)  sensor =3D ther=
mistor

k10temp-pci-00c3
Adapter: PCI adapter
temp1:       +4.5 C  (high =3D +70.0 C, crit =3D +70.0 C)

I believe temp1 from PCI adapter denotes the core-temperature? But, it is
definitely off by 20-30C; its hard to believe that the temperature would be
4.5C under fan based cooling system. I ran a SPEC hmmer benchmark and
plotted the temperature over time. temp1 seems to change now. I am
attaching the plots herewith.

Please let me know if there is a way to calibrate the core-temperature.

Thanks a lot for your help!


Guenter
>
>

--089e0160bc92f0ebb104e3ee700d
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Aug 14, 2013 at 4:03 PM, Guenter=
 Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=
=3D"_blank">linux@roeck-us.net</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On Wed, Aug 14, 2013 at 03:06:35PM =
-0400, Dev, Kapil wrote:<br>
&gt; On Wed, Aug 14, 2013 at 2:29 PM, Guenter Roeck &lt;<a href=3D"mailto:l=
inux@roeck-us.net">linux@roeck-us.net</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Wed, Aug 14, 2013 at 01:20:57PM -0400, Dev, Kapil wrote:<br>
&gt; &gt; &gt; On Wed, Aug 14, 2013 at 1:30 AM, Guenter Roeck &lt;<a href=
=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a>&gt;<br>
&gt; &gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On 08/13/2013 10:17 PM, Kapil Dev wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; On Aug 14, 2013, at 12:56 AM, Guenter Roeck &lt;<a =
href=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a>&gt;<br>
&gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; =A0On 08/13/2013 08:09 PM, Dev, Kapil wrote:<br>
&gt; &gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; On Tue, Aug 13, 2013 at 11:02 PM, Guenter R=
oeck &lt;<a href=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a><br>
&gt; &gt; &lt;mailto:<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; <a href=3D"mailto:linux@roeck-us.net">linux=
@roeck-us.net</a>&gt;&gt; wrote:<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 On 08/13/2013 07:41 PM, Dev, Kapil =
wrote:<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 Thanks again Guenter!<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 On Tue, Aug 13, 2013 at 5:5=
1 PM, Guenter Roeck &lt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; <a href=3D"mailto:linux@roeck-us.net">linux=
@roeck-us.net</a> &lt;mailto:<a href=3D"mailto:linux@roeck-us.net">linux@ro=
eck-us.net</a>&gt; &lt;mailto:<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; <a href=3D"mailto:linux@roeck-us.net">linux=
@roeck-us.net</a> &lt;mailto:<a href=3D"mailto:linux@roeck-us.net">linux@ro=
eck-us.net</a>&gt;&gt;&gt; wrote:<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0On Tue, Aug 13, =
2013 at 05:11:31PM -0400, Dev, Kapil<br>
&gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; Thanks for=
 the response Guenter!<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; I put the =
system on load and I noticed their value<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; hardly changes. To my<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; surprise, =
I ran a benchmark for 3 minutes and none<br>
&gt; &gt; of<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; temp* =A0values changed<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; during exe=
cution. The highest reported temperature<br>
&gt; &gt; is<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; always 48C.<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; I was expe=
cting that the internal temperature would<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; have &quot;sensor =3D thermal<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; diode&quot=
; or &quot;sensor =3D core&quot; as a keyword. I thought<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; &quot;sensor=3Dthermistor&quot; means<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; the corres=
ponding sensor is on the motherboard and<br>
&gt; &gt; not<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; the internal<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; die-sensor=
.<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0Sure, but who kn=
ows if they put a sensor below the CPU<br>
&gt; &gt; for<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; some reason ...<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0I am not familia=
r with the A10 CPUs. Are those similar<br>
&gt; &gt; to<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; K10 ?<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0If so, maybe the=
 k10temp driver works or could be<br>
&gt; &gt; extended<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; to support it.<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0Can you give it =
a try ?<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0If it does not w=
ork out of the box, can you send me the<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; output of &quot;lspci -nn&quot; ?<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 Kapil: I believe K10 corres=
ponds to A8 seried, and A10 has<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; Bulldozer architecture (<a href=3D"http://w=
ww.cpu-world.com/__**" target=3D"_blank">http://www.cpu-world.com/__**</a><=
br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; CPUs/Bulldozer/TYPE-A10-__**Series.html&lt;=
<br>
&gt; &gt; <a href=3D"http://www.cpu-world.com/__CPUs/Bulldozer/TYPE-A10-__S=
eries.html" target=3D"_blank">http://www.cpu-world.com/__CPUs/Bulldozer/TYP=
E-A10-__Series.html</a>&gt;&lt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; <a href=3D"http://www.cpu-world.com/**CPUs/=
Bulldozer/TYPE-A10-**Series.html" target=3D"_blank">http://www.cpu-world.co=
m/**CPUs/Bulldozer/TYPE-A10-**Series.html</a>&lt;<br>
&gt; &gt; <a href=3D"http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Serie=
s.html" target=3D"_blank">http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-=
Series.html</a>&gt;&gt;).<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; I am not sure how different they are though=
. I tried K10, but it<br>
&gt; &gt; did not<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; work out of the box. I am looking into k10t=
emp.c driver now. Also,I<br>
&gt; &gt; am<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; attaching the output of &quot;lspci -nn&quo=
t; command herewith; you might<br>
&gt; &gt; have to<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; open it using wordpad for proper formatting=
..<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 Your lspci output includes<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 00:18.3 Host bridge [0600]: Advance=
d Micro Devices [AMD] Device<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; [1022:1403]<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 which is supported by the latest k1=
0temp driver. Support was<br>
&gt; &gt; added<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; early last year.<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; =A0 =A0 What is your kernel version, and ca=
n you switch to a more recent<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; version ?<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; Kapil: I have 2.6.39-020639-generic kernel.=
 Is it too old kernel for<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt; k10temp driver to work? Which stable kernel=
 should I upgrade to?<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt; You need 3.4 or later.<br>
&gt; &gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; Kapil: I was trying to avoid updating the kernel be=
cause my current<br>
&gt; &gt; &gt; &gt;&gt; kernel is setup for running different type of bench=
marks etc. Seems<br>
&gt; &gt; like I<br>
&gt; &gt; &gt; &gt;&gt; can&#39;t avoid updating the kernel; I will do it..=
<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; =A0Alternative would be to back-port the k10temp dr=
iver from a later<br>
&gt; &gt; &gt; &gt; kernel. Then you can keep running the old one.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; Kapil: Not sure how to do that. I am already taking the k10t=
emp driver<br>
&gt; &gt; from<br>
&gt; &gt; &gt; here: <a href=3D"http://khali.linux-fr.org/devel/lm-sensors/=
drivers/k10temp/" target=3D"_blank">http://khali.linux-fr.org/devel/lm-sens=
ors/drivers/k10temp/</a> and<br>
&gt; &gt; &gt; compiling and using it.<br>
&gt; &gt; &gt;<br>
&gt; &gt; That version should already have support for your chip unless I a=
m missing<br>
&gt; &gt; something. If you already use it, a newer kernel version will not=
 help.<br>
&gt; &gt;<br>
&gt; &gt; Do you get any kernel log message when you try to load it ?<br>
&gt; &gt;<br>
&gt;<br>
&gt; Kapil: When I insert the module using: sudo insmod k10temp.ko, I don&#=
39;t get<br>
&gt; any message on terminal. However, when I compile ktemp10.c file using =
make,<br>
&gt; I get following warnings; I am not sure if they are acceptable.<br>
&gt; ----------------------------------------------------------------------=
------<br>
&gt; make[1]: Entering directory `/usr/src/linux-headers-2.6.39-020639-gene=
ric&#39;<br>
&gt; =A0 CC [M] =A0/home/amd_a10/k10temp_driver/k10temp.o<br>
&gt; /home//amd_a10/k10temp_driver/k10temp.c:232: warning: data definition =
has<br>
&gt; no type or storage class<br>
&gt; /home//amd_a10/k10temp_driver/k10temp.c:232: warning: type defaults to=
<br>
&gt; =91int=92 in declaration of =91module_pci_driver=92<br>
&gt; /home//amd_a10/k10temp_driver/k10temp.c:232: warning: parameter names<=
br>
&gt; (without types) in function declaration<br>
&gt; /home//amd_a10/k10temp_driver/k10temp.c:225: warning: =91k10temp_drive=
r=92<br>
&gt; defined but not used<br>
&gt; =A0 Building modules, stage 2.<br>
&gt; =A0 MODPOST 1 modules<br>
&gt; =A0 CC =A0 =A0 =A0/home/amd_a10/k10temp_driver/k10temp.mod.o<br>
&gt; =A0 LD [M] =A0/home/amd_a10/k10temp_driver/k10temp.ko<br>
&gt; make[1]: Leaving directory `/usr/src/linux-headers-2.6.39-020639-gener=
ic&#39;<br>
&gt;<br>
</div></div>There is no definition for module_pci_driver in your kernel,<br=
>
thus the initialization code won&#39;t run and the driver will<br>
not really be doing anything.<br>
<br>
You will have to replace<br>
<br>
module_pci_driver(k10temp_driver);<br>
<br>
with<br>
<br>
static int __init k10temp_init(void)<br>
{<br>
=A0 =A0 =A0 =A0 return pci_register_driver(&amp;k10temp_driver);<br>
}<br>
<br>
static void __exit k10temp_exit(void)<br>
{<br>
=A0 =A0 =A0 =A0 pci_unregister_driver(&amp;k10temp_driver);<br>
}<br>
<br>
module_init(k10temp_init)<br>
module_exit(k10temp_exit)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div><br></div><div>Kapil: After making above changes, I think it seems =
to work now. Now I am getting following output from sensors:</div><div>f718=
69-isa-0e80</div>
<div>Adapter: ISA adapter</div><div>in0: =A0 =A0 =A0 =A0 +1.69 V</div><div>=
in1: =A0 =A0 =A0 =A0 +0.90 V</div><div>in2: =A0 =A0 =A0 =A0 +1.21 V</div><d=
iv>in3: =A0 =A0 =A0 =A0 +1.22 V</div><div>in4: =A0 =A0 =A0 =A0 +1.49 V</div=
><div>in5: =A0 =A0 =A0 =A0 +1.22 V</div><div>
in6: =A0 =A0 =A0 =A0 +1.19 V</div><div>in7: =A0 =A0 =A0 =A0 +1.73 V</div><d=
iv>in8: =A0 =A0 =A0 =A0 +1.66 V</div><div>fan1: =A0 =A0 =A0 2177 RPM</div><=
div>fan2: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM</div><div>fan3: =A0 =A0 =A0 =A0=
 =A00 RPM =A0ALARM</div><div>temp1: =A0 =A0 =A0 +24.0 C =A0(high =3D +85.0 =
C, hyst =3D +81.0 C) =A0</div>
<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +100.0 C, hyst =
=3D +96.0 C) =A0sensor =3D thermistor</div><div>temp2: =A0 =A0 =A0 +32.0 C =
=A0(high =3D +85.0 C, hyst =3D +81.0 C) =A0</div><div>=A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +100.0 C, hyst =3D +96.0 C) =A0sensor =3D=
 thermistor</div>
<div>temp3: =A0 =A0 =A0 +48.0 C =A0(high =3D +70.0 C, hyst =3D +68.0 C) =A0=
</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +85.0 C, h=
yst =3D +83.0 C) =A0sensor =3D thermistor</div><div><br></div><div>k10temp-=
pci-00c3</div><div>Adapter: PCI adapter</div>
<div>temp1: =A0 =A0 =A0 +4.5 C =A0(high =3D +70.0 C, crit =3D +70.0 C) =A0=
=A0</div><div><br></div><div>I believe temp1 from PCI adapter denotes the c=
ore-temperature? But, it is definitely off by 20-30C; its hard to believe t=
hat the temperature would be 4.5C under fan based cooling system. I ran a S=
PEC hmmer benchmark and plotted the temperature over time. temp1 seems to c=
hange now. I am attaching the plots herewith.</div>
<div><br></div><div>Please let me know if there is a way to calibrate the c=
ore-temperature.</div><div><br></div><div>Thanks a lot for your help!</div>=
<div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888">
Guenter<br>
<br>
</font></span></blockquote></div><br>

--089e0160bc92f0ebb104e3ee700d--

--089e0160bc92f0ebb504e3ee700f
Content-Type: application/pdf; name="testTempSensor.pdf"
Content-Disposition: attachment; filename="testTempSensor.pdf"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hkd0dggq0

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
+faPT3ff4e9fdXs1b1Ykcj4Op3Fp2G8KrX8AVjHTSGVuZHN0cmVhbQplbmRvYmoKNiAwIG9iagox
Nzg3CmVuZG9iago0IDAgb2JqCjw8L1R5cGUvUGFnZS9NZWRpYUJveCBbMCAwIDYxMiA3OTJdCi9S
b3RhdGUgMC9QYXJlbnQgMyAwIFIKL1Jlc291cmNlczw8L1Byb2NTZXRbL1BERiAvVGV4dF0KL0V4
dEdTdGF0ZSA5IDAgUgovRm9udCAxMCAwIFIKPj4KL0NvbnRlbnRzIDUgMCBSCj4+CmVuZG9iagoz
IDAgb2JqCjw8IC9UeXBlIC9QYWdlcyAvS2lkcyBbCjQgMCBSCl0gL0NvdW50IDEKPj4KZW5kb2Jq
CjEgMCBvYmoKPDwvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMyAwIFIKL01ldGFkYXRhIDEyIDAgUgo+
PgplbmRvYmoKNyAwIG9iago8PC9UeXBlL0V4dEdTdGF0ZQovT1BNIDE+PmVuZG9iago5IDAgb2Jq
Cjw8L1I3CjcgMCBSPj4KZW5kb2JqCjEwIDAgb2JqCjw8L1I4CjggMCBSPj4KZW5kb2JqCjggMCBv
YmoKPDwvQmFzZUZvbnQvSGVsdmV0aWNhL1R5cGUvRm9udAovRW5jb2RpbmcgMTEgMCBSL1N1YnR5
cGUvVHlwZTE+PgplbmRvYmoKMTEgMCBvYmoKPDwvVHlwZS9FbmNvZGluZy9EaWZmZXJlbmNlc1sK
NDUvbWludXNdPj4KZW5kb2JqCjEyIDAgb2JqCjw8L0xlbmd0aCAxMzUxPj5zdHJlYW0KPD94cGFj
a2V0IGJlZ2luPSfvu78nIGlkPSdXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQnPz4KPD9hZG9iZS14
YXAtZmlsdGVycyBlc2M9IkNSTEYiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSdhZG9iZTpuczptZXRh
LycgeDp4bXB0az0nWE1QIHRvb2xraXQgMi45LjEtMTMsIGZyYW1ld29yayAxLjYnPgo8cmRmOlJE
RiB4bWxuczpyZGY9J2h0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMn
IHhtbG5zOmlYPSdodHRwOi8vbnMuYWRvYmUuY29tL2lYLzEuMC8nPgo8cmRmOkRlc2NyaXB0aW9u
IHJkZjphYm91dD0nYzczMzNjODYtMDc3Yy0xMWUzLTAwMDAtNmI0ODZkYmE4NTZlJyB4bWxuczpw
ZGY9J2h0dHA6Ly9ucy5hZG9iZS5jb20vcGRmLzEuMy8nIHBkZjpQcm9kdWNlcj0nQXJ0aWZleCBH
aG9zdHNjcmlwdCA4LjU0Jy8+CjxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSdjNzMzM2M4Ni0w
NzdjLTExZTMtMDAwMC02YjQ4NmRiYTg1NmUnIHhtbG5zOnhhcD0naHR0cDovL25zLmFkb2JlLmNv
bS94YXAvMS4wLycgeGFwOk1vZGlmeURhdGU9JzIwMTMtMDgtMTQnIHhhcDpDcmVhdGVEYXRlPScy
MDEzLTA4LTE0Jz48eGFwOkNyZWF0b3JUb29sPkFydGlmZXggR2hvc3RzY3JpcHQgOC41NCBQREYg
V3JpdGVyPC94YXA6Q3JlYXRvclRvb2w+PC9yZGY6RGVzY3JpcHRpb24+CjxyZGY6RGVzY3JpcHRp
b24gcmRmOmFib3V0PSdjNzMzM2M4Ni0wNzdjLTExZTMtMDAwMC02YjQ4NmRiYTg1NmUnIHhtbG5z
OnhhcE1NPSdodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vJyB4YXBNTTpEb2N1bWVudElE
PSdjNzMzM2M4Ni0wNzdjLTExZTMtMDAwMC02YjQ4NmRiYTg1NmUnLz4KPHJkZjpEZXNjcmlwdGlv
biByZGY6YWJvdXQ9J2M3MzMzYzg2LTA3N2MtMTFlMy0wMDAwLTZiNDg2ZGJhODU2ZScgeG1sbnM6
ZGM9J2h0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvJyBkYzpmb3JtYXQ9J2FwcGxpY2F0
aW9uL3BkZic+PGRjOnRpdGxlPjxyZGY6QWx0PjxyZGY6bGkgeG1sOmxhbmc9J3gtZGVmYXVsdCc+
QzpcXFVzZXJzXFxTY2FsZVxcQXBwRGF0YVxcTG9jYWxcXFRlbXBcXHRwYjgzYzQwNWJfMWJhOF80
NjJiXzkwMzlfMGRiYzdmNDU2MzQ2LnBzPC9yZGY6bGk+PC9yZGY6QWx0PjwvZGM6dGl0bGU+PC9y
ZGY6RGVzY3JpcHRpb24+CjwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0ndyc/PgplbmRzdHJlYW0KZW5kb2JqCjIgMCBv
YmoKPDwvUHJvZHVjZXIoQXJ0aWZleCBHaG9zdHNjcmlwdCA4LjU0KQovQ3JlYXRpb25EYXRlKEQ6
MjAxMzA4MTQxNjM3MDQpCi9Nb2REYXRlKEQ6MjAxMzA4MTQxNjM3MDQpCi9DcmVhdG9yKE1BVExB
QiwgVGhlIE1hdGh3b3JrcywgSW5jLiBWZXJzaW9uIDcuMTAuMC40OTkgXChSMjAxMGFcKS4gT3Bl
cmF0aW5nIFN5c3RlbTogTWljcm9zb2Z0IFdpbmRvd3MgNy4pCi9UaXRsZShDOlxcVXNlcnNcXFNj
YWxlXFxBcHBEYXRhXFxMb2NhbFxcVGVtcFxcdHBiODNjNDA1Yl8xYmE4XzQ2MmJfOTAzOV8wZGJj
N2Y0NTYzNDYucHMpPj5lbmRvYmoKeHJlZgowIDEzCjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAw
MjExMCAwMDAwMCBuIAowMDAwMDAzODE0IDAwMDAwIG4gCjAwMDAwMDIwNTEgMDAwMDAgbiAKMDAw
MDAwMTg5MiAwMDAwMCBuIAowMDAwMDAwMDE1IDAwMDAwIG4gCjAwMDAwMDE4NzIgMDAwMDAgbiAK
MDAwMDAwMjE3NSAwMDAwMCBuIAowMDAwMDAyMjc1IDAwMDAwIG4gCjAwMDAwMDIyMTYgMDAwMDAg
biAKMDAwMDAwMjI0NSAwMDAwMCBuIAowMDAwMDAyMzU1IDAwMDAwIG4gCjAwMDAwMDI0MTMgMDAw
MDAgbiAKdHJhaWxlcgo8PCAvU2l6ZSAxMyAvUm9vdCAxIDAgUiAvSW5mbyAyIDAgUgovSUQgWzww
MEJENzE5RjhCNDk5M0ZBMDUzRDMwREI0NDJDNDczOT48MDBCRDcxOUY4QjQ5OTNGQTA1M0QzMERC
NDQyQzQ3Mzk+XQo+PgpzdGFydHhyZWYKNDEyNQolJUVPRgo=
--089e0160bc92f0ebb504e3ee700f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--089e0160bc92f0ebb504e3ee700f--
