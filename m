From: Kenneth Cox <kencox1@gmail.com>
Date: Fri, 17 Feb 2012 04:29:04 +0000
Subject: Re: [lm-sensors] help with setup / chip support
Message-Id: <CAP4ecBMJ+_EnZ_ZeZzc28aBfRV14-WHZz3VGdss65BKrxGaeYA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0728356089571053197=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
In-Reply-To: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0728356089571053197==
Content-Type: multipart/alternative; boundary=e89a8f235177857aba04b9216271

--e89a8f235177857aba04b9216271
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2012 at 10:51 PM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Kenneth,
>
> On Wed, 15 Feb 2012 18:36:40 -0800, Kenneth Cox wrote:
> > Here is the results of sensors-detect as promised:
> >
> > # sensors-detect revision 5946 (2011-03-23 11:54:44 +0100)
> > # System: To Be Filled By O.E.M. To Be Filled By O.E.M.
>
> Obviously this is useless data, I've added a filter to sensors-detect.
>
> > # Board: ASRock A75M-HVS
> > (...)
> > Driver `to-be-written':
> >   * ISA bus, address 0x290
> >     Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)
>
> Obviously this is your monitoring chip. A more recent version of
> sensors-detect [1] would have told you to use the w83627ehf driver. If
> you run kernel 2.6.39 or later it should work (mostly) fine. For older
> kernels, or if you are affected by a bug in the early support, Guenter
> Roeck has a standalone version of the driver [2] which you could try if
> the web server works for you (it doesn't for me at the moment.) I also
> have a standalone version of the w83627ehf driver [3] but it isn't as
> up-to-date as Guenter's.
>
> [1] http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
> [2] http://roeck-us.net/linux/drivers/
> [3] http://khali.linux-fr.org/devel/misc/w83627ehf/
>
> Hope that helps,
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

Thanks for the response. I downloaded the new sensors-detect script and ran
it. I also installed Roeck's driver. Here is the output of sensors-detect:

# sensors-detect revision 6022 (2012-02-16 07:44:31 +0100)
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
AMD Family 15h thermal sensors...                           No
AMD Family 15h power sensors...                             No
Intel digital thermal sensor...                             No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Nuvoton NCT6776F Super IO Sensors'                   Success!
    (address 0x290, driver `w83627ehf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
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

Driver `w83627ehf':
  * ISA bus, address 0x290
    Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)

Driver `k10temp' (autoloaded):
  * Chip `AMD Family 12h and 14h thermal sensors' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors
for initialization at boot time.
You should now start the lm_sensors service to load the required
kernel modules.

Unloading i2c-dev... OK
Unloading cpuid... OK

But sensors does not give any more info:

k10temp-pci-00c3
Adapter: PCI adapter
temp1:         +9.6=B0C  (high =3D +70.0=B0C)
                       (crit =3D +70.0=B0C, hyst =3D +69.0=B0C)


Am I missing something?

Ken

--e89a8f235177857aba04b9216271
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Feb 15, 2012 at 10:51 PM, Jean Delvare <=
span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.o=
rg</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi Kenneth,<br>
<div class=3D"im"><br>
On Wed, 15 Feb 2012 18:36:40 -0800, Kenneth Cox wrote:<br>
&gt; Here is the results of sensors-detect as promised:<br>
&gt;<br>
&gt; # sensors-detect revision 5946 (2011-03-23 11:54:44 +0100)<br>
&gt; # System: To Be Filled By O.E.M. To Be Filled By O.E.M.<br>
<br>
</div>Obviously this is useless data, I&#39;ve added a filter to sensors-de=
tect.<br>
<br>
&gt; # Board: ASRock A75M-HVS<br>
&gt; (...)<br>
<div class=3D"im">&gt; Driver `to-be-written&#39;:<br>
&gt; =A0 * ISA bus, address 0x290<br>
&gt; =A0 =A0 Chip `Nuvoton NCT6776F Super IO Sensors&#39; (confidence: 9)<b=
r>
<br>
</div>Obviously this is your monitoring chip. A more recent version of<br>
sensors-detect [1] would have told you to use the w83627ehf driver. If<br>
you run kernel 2.6.39 or later it should work (mostly) fine. For older<br>
kernels, or if you are affected by a bug in the early support, Guenter<br>
Roeck has a standalone version of the driver [2] which you could try if<br>
the web server works for you (it doesn&#39;t for me at the moment.) I also<=
br>
have a standalone version of the w83627ehf driver [3] but it isn&#39;t as<b=
r>
up-to-date as Guenter&#39;s.<br>
<br>
[1] <a href=3D"http://dl.lm-sensors.org/lm-sensors/files/sensors-detect" ta=
rget=3D"_blank">http://dl.lm-sensors.org/lm-sensors/files/sensors-detect</a=
><br>
[2] <a href=3D"http://roeck-us.net/linux/drivers/" target=3D"_blank">http:/=
/roeck-us.net/linux/drivers/</a><br>
[3] <a href=3D"http://khali.linux-fr.org/devel/misc/w83627ehf/" target=3D"_=
blank">http://khali.linux-fr.org/devel/misc/w83627ehf/</a><br>
<br>
Hope that helps,<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Jean Delvare<br>
<a href=3D"http://khali.linux-fr.org/wishlist.html" target=3D"_blank">http:=
//khali.linux-fr.org/wishlist.html</a><br>
</font></span></blockquote></div><br>Thanks for the response. I downloaded =
the new sensors-detect script and ran it. I also installed Roeck&#39;s driv=
er. Here is the output of sensors-detect:<br><br># sensors-detect revision =
6022 (2012-02-16 07:44:31 +0100)<br>
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
AMD Family 15h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>AMD Family 15h power sensors...=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 No<br>Intel digital thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Intel AMB F=
B-DIMM thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 No<br>
VIA C7 thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>VIA Nano therm=
al sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br><br>Some Super I/O chips contain=
 embedded sensors. We have to write to<br>standard I/O ports to probe them.=
 This is usually safe.<br>
Do you want to scan for Super I/O sensors? (YES/no): <br>Probing for Super-=
I/O at 0x2e/0x2f<br>Trying family `National Semiconductor/ITE&#39;...=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying family `SMSC&#39;...=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Trying family `VIA/Winbond/Nuvoton/Fintek&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 Yes<br>Found `Nuvoton NCT6776F Super IO Sensors&#39;=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Success!<br>=A0=A0=A0 (=
address 0x290, driver `w83627ehf&#39;)<br>Probing for Super-I/O at 0x4e/0x4=
f<br>
Trying family `National Semiconductor/ITE&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No<br>Trying family `SMSC&#39;...=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 No<br>Trying family `VIA/Winbond/Nuvoton/Fintek&#39;...=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying family `ITE&#39;...=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
<br>Some systems (mainly servers) implement IPMI, a set of common interface=
s<br>through which system health data may be retrieved, amongst other thing=
s.<br>We first try to get the information from SMBIOS. If we don&#39;t find=
 it<br>
there, we have to read from arbitrary I/O ports to probe for such<br>interf=
aces. This is normally safe. Do you want to scan for IPMI<br>interfaces? (Y=
ES/no): <br>Probing for `IPMI BMC KCS&#39; at 0xca0...=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Probing for `IPMI BMC SMIC&#39; at 0xca8...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br><br>Some hardware monitoring chips are=
 accessible through the ISA I/O ports.<br>We have to write to arbitrary I/O=
 ports to probe them. This is usually<br>
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
 <br><br>Driver `w83627ehf&#39;:<br>=A0 * ISA bus, address 0x290<br>=A0=A0=
=A0 Chip `Nuvoton NCT6776F Super IO Sensors&#39; (confidence: 9)<br>
<br>Driver `k10temp&#39; (autoloaded):<br>=A0 * Chip `AMD Family 12h and 14=
h thermal sensors&#39; (confidence: 9)<br><br>Do you want to overwrite /etc=
/sysconfig/lm_sensors? (YES/no): <br>Copy prog/init/lm_sensors.init to /etc=
/init.d/lm_sensors<br>
for initialization at boot time.<br>You should now start the lm_sensors ser=
vice to load the required<br>kernel modules.<br><br>Unloading i2c-dev... OK=
<br>Unloading cpuid... OK<br><br>But sensors does not give any more info:<b=
r>
<br>k10temp-pci-00c3<br>Adapter: PCI adapter<br>temp1:=A0=A0=A0=A0=A0=A0=A0=
=A0 +9.6=B0C=A0 (high =3D +70.0=B0C)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (crit =3D +70.0=B0C, hyst =3D +69.0=B0C)<=
br><br><br>Am I missing something?<br><br>Ken<br>

--e89a8f235177857aba04b9216271--


--===============0728356089571053197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0728356089571053197==--
