From: Kenneth Cox <kencox1@gmail.com>
Date: Thu, 16 Feb 2012 02:36:40 +0000
Subject: Re: [lm-sensors] help with setup / chip support
Message-Id: <CAP4ecBOgtG1cfykmecBD9Yoh3KVqVA7fyHVWrR3y5es5mZw_Fw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4469302105339724536=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
In-Reply-To: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============4469302105339724536==
Content-Type: multipart/alternative; boundary=bcaec5555112b122e204b90bb28f

--bcaec5555112b122e204b90bb28f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2012 at 7:17 AM, Andreas Herrmann <andreas.herrmann3@amd.co=
m
> wrote:

> On Wed, Feb 15, 2012 at 06:21:19AM -0800, Kenneth Cox wrote:
> > Jean,
> >
> > Thanks for the response.
> >
> > On Tue, Feb 14, 2012 at 11:29 PM, Jean Delvare <khali@linux-fr.org>
> wrote:
> >
> >     Hi Kenneth,
> >
> >     On Mon, 13 Feb 2012 16:46:33 -0800, Kenneth Cox wrote:
> >     > I am having trouble getting lm-sensors to work as it should I
> believe
> >     that
> >     > part of the problem is support for a newer chip set. here are the
> specs:
> >     >
> >     > CPU: AMD A4-3400 APU with Radeon(tm) HD Graphics
> >     > family(18) model(1) stepping(0)
> >     >
> >     > MoBo: ASRock A75M-HVS
> >     >
> >     > I'm using the onboard Radeon graphics.
> >     >
> >     > I ran the sensors-detect script saying yes to everything. The
> output of
> >     > sensors:
> >     > k10temp-pci-00c3
> >     > Adapter: PCI adapter
> >     > temp1:         +9.8=B0C  (high =3D +70.0=B0C)
> >     >                        (crit =3D +70.0=B0C, hyst =3D +69.0=B0C)
> >     >
> >     > That's much colder than room temp and only gives data for the PCI
> >     adapter.
> >
> >     This isn't the temperature of "the PCI adapter", the value is from
> your
> >     CPU. This happens to be implemented as a PCI device in AMD
> processors,
> >     which is why you see "PCI adapter" in the output, but this is rathe=
r
> >     misleading I admit.
> >
> >     The reported temperature indeed looks wrong, however it isn't
> >     necessarily surprising. This isn't an absolute temperature, but
> rather
> >     a temperature margin from the CPU's max, and it is only accurate wh=
en
> >     you get close to the limit. So from the above, one can say that you=
r
> >     CPU is running very cool ans safe, and that's about it.
> >
> >     That being said, I think this is the first report I see for this
> family
> >     of CPU. Andreas, Andre, do you think there's any bug to be fixed
> here?
> >
> >
> > Got it. That's excellent news. At least I know I can trust the output t=
o
> let me
> > know if it's getting to warm. I did not trust it at all before.
> >
> >
> >     > I also tried downloading the latest version of sensors-detect fro=
m
> >     > http://www.lm-sensors.org/wiki/Devices and rerunning. It did not
> change
> >     > anything.
> >     >
> >     > Is there a way to get sensor data for the CPU and accurate data
> from the
> >     > PCI adapter? Any help would be appreciated.
> >
> >     What kind of system is this? If this is a laptop you're probably ou=
t
> of
> >     luck. If this is a desktop system, I would expect a hardware
> monitoring
> >     chip on the SMBus or in the Super-I/O chip. Maybe it is too recent
> and
> >     we don't know about it yet. Please provide the full output of
> >     sensors-detect.
>
> Hi Kenneth,
>
> I just can second what Jean already said. The reported temperature
> (Tctl) is
>
>  "on its own scale aligned to the processors cooling
>  requirements. Therefore Tctl does not represent a temperature which
>  could be measured on the die or the case of the processor. Instead,
>  it specifies the processor temperature relative to the maximum
>  operating temperature, Tctl_max."
>
> (Quoted from the AMD Family 12h Processor BKDG.) You have a FM1 socket
> processor. Tctl_max is 70 in your case.  So the reported temperature
> of 9.8 is far below that maximum operating temperature.
>
>
> HTH,
>
> Andreas
>
>
>
Thank you Andreas.

Here is the results of sensors-detect as promised:

# sensors-detect revision 5946 (2011-03-23 11:54:44 +0100)
# System: To Be Filled By O.E.M. To Be Filled By O.E.M.
# Board: ASRock A75M-HVS

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   Success!
    (driver `k10temp')
Intel digital thermal sensor...                             No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Nuvoton NCT6776F Super IO Sensors'                   Success!
    (address 0x290, driver `to-be-written')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-piix4' for device 0000:00:14.0: AMD Hudson-2 SMBus
Module i2c-dev loaded successfully.

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
Do you want to scan it? (yes/NO/selectively): yes
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `to-be-written':
  * ISA bus, address 0x290
    Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)

Driver `k10temp' (autoloaded):
  * Chip `AMD Family 12h and 14h thermal sensors' (confidence: 9)

Note: there is no driver for Nuvoton NCT6776F Super IO Sensors yet.
Check http://www.lm-sensors.org/wiki/Devices for updates.

No modules to load, skipping modules configuration.

Unloading i2c-dev... OK
Unloading cpuid... OK

Thanks,
Ken

--bcaec5555112b122e204b90bb28f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Feb 15, 2012 at 7:17 AM, Andreas Herrman=
n <span dir=3D"ltr">&lt;<a href=3D"mailto:andreas.herrmann3@amd.com">andrea=
s.herrmann3@amd.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
<div class=3D"HOEnZb"><div class=3D"h5">On Wed, Feb 15, 2012 at 06:21:19AM =
-0800, Kenneth Cox wrote:<br>
&gt; Jean,<br>
&gt;<br>
&gt; Thanks for the response.<br>
&gt;<br>
&gt; On Tue, Feb 14, 2012 at 11:29 PM, Jean Delvare &lt;<a href=3D"mailto:k=
hali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 Hi Kenneth,<br>
&gt;<br>
&gt; =A0 =A0 On Mon, 13 Feb 2012 16:46:33 -0800, Kenneth Cox wrote:<br>
&gt; =A0 =A0 &gt; I am having trouble getting lm-sensors to work as it shou=
ld I believe<br>
&gt; =A0 =A0 that<br>
&gt; =A0 =A0 &gt; part of the problem is support for a newer chip set. here=
 are the specs:<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; CPU: AMD A4-3400 APU with Radeon(tm) HD Graphics<br>
&gt; =A0 =A0 &gt; family(18) model(1) stepping(0)<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; MoBo: ASRock A75M-HVS<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; I&#39;m using the onboard Radeon graphics.<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; I ran the sensors-detect script saying yes to everything.=
 The output of<br>
&gt; =A0 =A0 &gt; sensors:<br>
&gt; =A0 =A0 &gt; k10temp-pci-00c3<br>
&gt; =A0 =A0 &gt; Adapter: PCI adapter<br>
&gt; =A0 =A0 &gt; temp1: =A0 =A0 =A0 =A0 +9.8=B0C =A0(high =3D +70.0=B0C)<b=
r>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(crit =3D =
+70.0=B0C, hyst =3D +69.0=B0C)<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; That&#39;s much colder than room temp and only gives data=
 for the PCI<br>
&gt; =A0 =A0 adapter.<br>
&gt;<br>
&gt; =A0 =A0 This isn&#39;t the temperature of &quot;the PCI adapter&quot;,=
 the value is from your<br>
&gt; =A0 =A0 CPU. This happens to be implemented as a PCI device in AMD pro=
cessors,<br>
&gt; =A0 =A0 which is why you see &quot;PCI adapter&quot; in the output, bu=
t this is rather<br>
&gt; =A0 =A0 misleading I admit.<br>
&gt;<br>
&gt; =A0 =A0 The reported temperature indeed looks wrong, however it isn&#3=
9;t<br>
&gt; =A0 =A0 necessarily surprising. This isn&#39;t an absolute temperature=
, but rather<br>
&gt; =A0 =A0 a temperature margin from the CPU&#39;s max, and it is only ac=
curate when<br>
&gt; =A0 =A0 you get close to the limit. So from the above, one can say tha=
t your<br>
&gt; =A0 =A0 CPU is running very cool ans safe, and that&#39;s about it.<br=
>
&gt;<br>
&gt; =A0 =A0 That being said, I think this is the first report I see for th=
is family<br>
&gt; =A0 =A0 of CPU. Andreas, Andre, do you think there&#39;s any bug to be=
 fixed here?<br>
&gt;<br>
&gt;<br>
&gt; Got it. That&#39;s excellent news. At least I know I can trust the out=
put to let me<br>
&gt; know if it&#39;s getting to warm. I did not trust it at all before.<br=
>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 &gt; I also tried downloading the latest version of sensors-de=
tect from<br>
&gt; =A0 =A0 &gt; <a href=3D"http://www.lm-sensors.org/wiki/Devices" target=
=3D"_blank">http://www.lm-sensors.org/wiki/Devices</a> and rerunning. It di=
d not change<br>
&gt; =A0 =A0 &gt; anything.<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; Is there a way to get sensor data for the CPU and accurat=
e data from the<br>
&gt; =A0 =A0 &gt; PCI adapter? Any help would be appreciated.<br>
&gt;<br>
&gt; =A0 =A0 What kind of system is this? If this is a laptop you&#39;re pr=
obably out of<br>
&gt; =A0 =A0 luck. If this is a desktop system, I would expect a hardware m=
onitoring<br>
&gt; =A0 =A0 chip on the SMBus or in the Super-I/O chip. Maybe it is too re=
cent and<br>
&gt; =A0 =A0 we don&#39;t know about it yet. Please provide the full output=
 of<br>
&gt; =A0 =A0 sensors-detect.<br>
<br>
</div></div>Hi Kenneth,<br>
<br>
I just can second what Jean already said. The reported temperature<br>
(Tctl) is<br>
<br>
 =A0&quot;on its own scale aligned to the processors cooling<br>
 =A0requirements. Therefore Tctl does not represent a temperature which<br>
 =A0could be measured on the die or the case of the processor. Instead,<br>
 =A0it specifies the processor temperature relative to the maximum<br>
 =A0operating temperature, Tctl_max.&quot;<br>
<br>
(Quoted from the AMD Family 12h Processor BKDG.) You have a FM1 socket<br>
processor. Tctl_max is 70 in your case. =A0So the reported temperature<br>
of 9.8 is far below that maximum operating temperature.<br>
<br>
<br>
HTH,<br>
<br>
Andreas<br>
<br>
<br>
</blockquote></div><br>Thank you Andreas.<br><br>Here is the results of sen=
sors-detect as promised:<br><br># sensors-detect revision 5946 (2011-03-23 =
11:54:44 +0100)<br># System: To Be Filled By O.E.M. To Be Filled By O.E.M.<=
br>
# Board: ASRock A75M-HVS<br><br>This program will help you determine which =
kernel modules you need<br>to load to use lm_sensors most effectively. It i=
s generally safe<br>and recommended to accept the default answers to all qu=
estions,<br>
unless you know what you&#39;re doing.<br><br>Some south bridges, CPUs or m=
emory controllers contain embedded sensors.<br>Do you want to scan for them=
? This is totally safe. (YES/no): <br>Module cpuid loaded successfully.<br>
Silicon Integrated Systems SIS5595...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>VIA VT82C686 Integrated Sensors...=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=
<br>VIA VT8231 Integrated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>AMD K8 thermal sensors...=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
AMD Family 10h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>AMD Family 11h thermal sensors..=
.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 No<br>AMD Family 12h and 14h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Success!<br>=A0=A0=A0 (driver `k10temp&#3=
9;)<br>
Intel digital thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Intel AMB FB-DIMM thermal =
sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 No<br>VIA C7 thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br=
>VIA Nano thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
<br>Some Super I/O chips contain embedded sensors. We have to write to<br>s=
tandard I/O ports to probe them. This is usually safe.<br>Do you want to sc=
an for Super I/O sensors? (YES/no): <br>Probing for Super-I/O at 0x2e/0x2f<=
br>
Trying family `National Semiconductor&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying family `SMSC&#39;...=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No<br>Trying family `VIA/Winbond/Nuvoton/Fintek&#39;...=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes<br>Found `Nuvoton NCT6776F S=
uper IO Sensors&#39;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
Success!<br>
=A0=A0=A0 (address 0x290, driver `to-be-written&#39;)<br>Probing for Super-=
I/O at 0x4e/0x4f<br>Trying family `National Semiconductor&#39;...=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying family `SMSC&#39=
;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Trying family `VIA/Winbond/Nuvoton/Fintek&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No<br>Trying family `ITE&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 No<br><br>Some systems (mainly servers) implement IPMI, a set =
of common interfaces<br>through which system health data may be retrieved, =
amongst other things.<br>
We first try to get the information from SMBIOS. If we don&#39;t find it<br=
>there, we have to read from arbitrary I/O ports to probe for such<br>inter=
faces. This is normally safe. Do you want to scan for IPMI<br>interfaces? (=
YES/no): <br>
Probing for `IPMI BMC KCS&#39; at 0xca0...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `IPMI BMC SMIC&#39; at 0xc=
a8...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br><br=
>Some hardware monitoring chips are accessible through the ISA I/O ports.<b=
r>We have to write to arbitrary I/O ports to probe them. This is usually<br=
>
safe though. Yes, you do have ISA I/O ports even if you do not have any<br>=
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes<br>Probing =
for `National Semiconductor LM78&#39; at 0x290...=A0=A0=A0=A0=A0=A0 No<br>P=
robing for `National Semiconductor LM79&#39; at 0x290...=A0=A0=A0=A0=A0=A0 =
No<br>
Probing for `Winbond W83781D&#39; at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `Winbond W83782D&#39; at 0x290..=
.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br><br>Lastly, w=
e can probe the I2C/SMBus adapters for connected hardware<br>monitoring dev=
ices. This is the most risky part, and while it works<br>
reasonably well on most systems, it has been reported to cause trouble<br>o=
n some systems.<br>Do you want to probe the I2C/SMBus adapters now? (YES/no=
): <br>Using driver `i2c-piix4&#39; for device 0000:00:14.0: AMD Hudson-2 S=
MBus<br>
Module i2c-dev loaded successfully.<br><br>Next adapter: SMBus PIIX4 adapte=
r at 0b00 (i2c-0)<br>Do you want to scan it? (yes/NO/selectively): yes<br>C=
lient found at address 0x50<br>Probing for `Analog Devices ADM1033&#39;...=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Probing for `Analog Devices ADM1034&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `SPD EEPROM&#39;...=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Yes<br>=A0=A0=A0 (confidence 8, not a hardware monitoring c=
hip)<br>Probing for `EDID EEPROM&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Client found at address 0x51<br>Probing for `Analog Devices ADM1033&#39;...=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing =
for `Analog Devices ADM1034&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `SPD EEPROM&#39;...=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Yes<br>
=A0=A0=A0 (confidence 8, not a hardware monitoring chip)<br><br>Now follows=
 a summary of the probes I have just done.<br>Just press ENTER to continue:=
 <br><br>Driver `to-be-written&#39;:<br>=A0 * ISA bus, address 0x290<br>=A0=
=A0=A0 Chip `Nuvoton NCT6776F Super IO Sensors&#39; (confidence: 9)<br>
<br>Driver `k10temp&#39; (autoloaded):<br>=A0 * Chip `AMD Family 12h and 14=
h thermal sensors&#39; (confidence: 9)<br><br>Note: there is no driver for =
Nuvoton NCT6776F Super IO Sensors yet.<br>Check <a href=3D"http://www.lm-se=
nsors.org/wiki/Devices">http://www.lm-sensors.org/wiki/Devices</a> for upda=
tes.<br>
<br>No modules to load, skipping modules configuration.<br><br>Unloading i2=
c-dev... OK<br>Unloading cpuid... OK<br><br>Thanks,<br>Ken<br>

--bcaec5555112b122e204b90bb28f--


--===============4469302105339724536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4469302105339724536==--
