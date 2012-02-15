From: Kenneth Cox <kencox1@gmail.com>
Date: Wed, 15 Feb 2012 14:21:19 +0000
Subject: Re: [lm-sensors] help with setup / chip support
Message-Id: <CAP4ecBNwk0WXeLDW2LqiA0SOuvv4qyoKM5QKPEUhtu=RUsnipw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4760050190479320516=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
In-Reply-To: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============4760050190479320516==
Content-Type: multipart/alternative; boundary=14dae9399097df9fb604b9016c44

--14dae9399097df9fb604b9016c44
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jean,

Thanks for the response.

On Tue, Feb 14, 2012 at 11:29 PM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Kenneth,
>
> On Mon, 13 Feb 2012 16:46:33 -0800, Kenneth Cox wrote:
> > I am having trouble getting lm-sensors to work as it should I believe
> that
> > part of the problem is support for a newer chip set. here are the specs=
:
> >
> > CPU: AMD A4-3400 APU with Radeon(tm) HD Graphics
> > family(18) model(1) stepping(0)
> >
> > MoBo: ASRock A75M-HVS
> >
> > I'm using the onboard Radeon graphics.
> >
> > I ran the sensors-detect script saying yes to everything. The output of
> > sensors:
> > k10temp-pci-00c3
> > Adapter: PCI adapter
> > temp1:         +9.8=B0C  (high =3D +70.0=B0C)
> >                        (crit =3D +70.0=B0C, hyst =3D +69.0=B0C)
> >
> > That's much colder than room temp and only gives data for the PCI
> adapter.
>
> This isn't the temperature of "the PCI adapter", the value is from your
> CPU. This happens to be implemented as a PCI device in AMD processors,
> which is why you see "PCI adapter" in the output, but this is rather
> misleading I admit.
>
> The reported temperature indeed looks wrong, however it isn't
> necessarily surprising. This isn't an absolute temperature, but rather
> a temperature margin from the CPU's max, and it is only accurate when
> you get close to the limit. So from the above, one can say that your
> CPU is running very cool ans safe, and that's about it.
>
> That being said, I think this is the first report I see for this family
> of CPU. Andreas, Andre, do you think there's any bug to be fixed here?
>

Got it. That's excellent news. At least I know I can trust the output to
let me know if it's getting to warm. I did not trust it at all before.

> I also tried downloading the latest version of sensors-detect from
> > http://www.lm-sensors.org/wiki/Devices and rerunning. It did not change
> > anything.
> >
> > Is there a way to get sensor data for the CPU and accurate data from th=
e
> > PCI adapter? Any help would be appreciated.
>
> What kind of system is this? If this is a laptop you're probably out of
> luck. If this is a desktop system, I would expect a hardware monitoring
> chip on the SMBus or in the Super-I/O chip. Maybe it is too recent and
> we don't know about it yet. Please provide the full output of
> sensors-detect.
>
> --
> Jean Delvare
>

I built is a dual purpose HTPC and home server. It's in a micro ATX case.
This is the mother board: ASRock A75M-HVS FM1 AMD A75 (Hudson D3) HDMI SATA
6Gb/s USB 3.0 Micro ATX AMD Motherboard with UEFI BIOS. I'm running Ubuntu
11.10. Any other info that would be helpful?

The current configuration is sitting in a cabinet under the TV. I'm a bit
nervous about closing the cabinet door on it and not getting enough air
flow, so I wanted to monitor the temp with the door closed but I didn't
trust the output. There's a fair amount of space around the machine but
still. It's good to know now that I can trust the output to let me know if
it's getting too hot in there. Still it would be nice to see some other
output.

I'll send the output of sensors-detect this evening.

Thanks again,
Ken

--14dae9399097df9fb604b9016c44
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jean,<div><br></div><div>Thanks for the response.<br clear=3D"all"><br><div=
 class=3D"gmail_quote">On Tue, Feb 14, 2012 at 11:29 PM, Jean Delvare <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</=
a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Kenneth,<br>
<div class=3D"im"><br>
On Mon, 13 Feb 2012 16:46:33 -0800, Kenneth Cox wrote:<br>
&gt; I am having trouble getting lm-sensors to work as it should I believe =
that<br>
&gt; part of the problem is support for a newer chip set. here are the spec=
s:<br>
&gt;<br>
&gt; CPU: AMD A4-3400 APU with Radeon(tm) HD Graphics<br>
&gt; family(18) model(1) stepping(0)<br>
&gt;<br>
&gt; MoBo: ASRock A75M-HVS<br>
&gt;<br>
&gt; I&#39;m using the onboard Radeon graphics.<br>
&gt;<br>
&gt; I ran the sensors-detect script saying yes to everything. The output o=
f<br>
&gt; sensors:<br>
&gt; k10temp-pci-00c3<br>
&gt; Adapter: PCI adapter<br>
&gt; temp1: =A0 =A0 =A0 =A0 +9.8=B0C =A0(high =3D +70.0=B0C)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(crit =3D +70.0=B0C, hy=
st =3D +69.0=B0C)<br>
&gt;<br>
&gt; That&#39;s much colder than room temp and only gives data for the PCI =
adapter.<br>
<br>
</div>This isn&#39;t the temperature of &quot;the PCI adapter&quot;, the va=
lue is from your<br>
CPU. This happens to be implemented as a PCI device in AMD processors,<br>
which is why you see &quot;PCI adapter&quot; in the output, but this is rat=
her<br>
misleading I admit.<br>
<br>
The reported temperature indeed looks wrong, however it isn&#39;t<br>
necessarily surprising. This isn&#39;t an absolute temperature, but rather<=
br>
a temperature margin from the CPU&#39;s max, and it is only accurate when<b=
r>
you get close to the limit. So from the above, one can say that your<br>
CPU is running very cool ans safe, and that&#39;s about it.<br>
<br>
That being said, I think this is the first report I see for this family<br>
of CPU. Andreas, Andre, do you think there&#39;s any bug to be fixed here?<=
br></blockquote><div><br></div><div>Got it. That&#39;s excellent news. At l=
east I know I can trust the output to let me know if it&#39;s getting to wa=
rm. I did not trust it at all before.</div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"im">
&gt; I also tried downloading the latest version of sensors-detect from<br>
&gt; <a href=3D"http://www.lm-sensors.org/wiki/Devices" target=3D"_blank">h=
ttp://www.lm-sensors.org/wiki/Devices</a> and rerunning. It did not change<=
br>
&gt; anything.<br>
&gt;<br>
&gt; Is there a way to get sensor data for the CPU and accurate data from t=
he<br>
&gt; PCI adapter? Any help would be appreciated.<br>
<br>
</div>What kind of system is this? If this is a laptop you&#39;re probably =
out of<br>
luck. If this is a desktop system, I would expect a hardware monitoring<br>
chip on the SMBus or in the Super-I/O chip. Maybe it is too recent and<br>
we don&#39;t know about it yet. Please provide the full output of<br>
sensors-detect.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br></div><div>I built is a dual purpose H=
TPC and home server. It&#39;s in a micro ATX case.=A0</div><div>This is the=
 mother board:=A0ASRock A75M-HVS FM1 AMD A75 (Hudson D3) HDMI SATA 6Gb/s US=
B 3.0 Micro ATX AMD Motherboard with UEFI BIOS. I&#39;m running Ubuntu 11.1=
0. Any other info that would be helpful?</div>
<div><br></div><div>The current configuration is sitting in a cabinet under=
 the TV. I&#39;m a bit nervous about closing the cabinet door on it and not=
 getting enough air flow, so I wanted to monitor the temp with the door clo=
sed but I didn&#39;t trust the output. There&#39;s a fair amount of space a=
round the machine but still. It&#39;s good to know now that I can trust the=
 output to let me know if it&#39;s getting too hot in there. Still it would=
 be nice to see some other output.=A0</div>
<div><br></div><div>I&#39;ll send the output of sensors-detect this evening=
.</div><div><br></div><div>Thanks again,</div><div>Ken<br><br><br></div>

--14dae9399097df9fb604b9016c44--


--===============4760050190479320516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4760050190479320516==--
