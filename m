From: Simon Tims <si@cog24.com>
Date: Wed, 29 Aug 2012 12:53:05 +0000
Subject: [lm-sensors] Patching help
Message-Id: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3680664074773275991=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3680664074773275991==
Content-Type: multipart/alternative; boundary=bcaec517a9d432e61404c8670ac6

--bcaec517a9d432e61404c8670ac6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I've spent many hours reading up on patching lm-sensors but I'm either
looking in the wrong place, mis-understanding the patch command, or a
combination!

uname -a reports:
3.2.0-29-generic-pae #46-Ubuntu SMP Fri Jul 27 17:25:43 UTC 2012 i686
athlon i386 GNU/Linux

This is an HP Proliant Microserver N40L.  There are a few threads about
this hardware and I see people have got sensors working properly on this
machine, but I can't find how to patch the software correctly.

Here's my sensors-detect:

# sensors-detect revision 5984 (2011-07-10 21:22:53 +0200)
# System: HP ProLiant MicroServer

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           Success!
    (driver `k10temp')
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
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
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
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
Found `IPMI BMC KCS'...                                     Success!
    (confidence 8, driver `to-be-written')

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc
SB600/SB700/SB800 SMBus

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x18
Handled by driver `jc42' (already loaded), chip type `jc42'
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Next adapter: Radeon i2c bit bus 0x90 (i2c-1)
Do you want to scan it? (YES/no/selectively):

Next adapter: Radeon i2c bit bus 0x91 (i2c-2)
Do you want to scan it? (YES/no/selectively):


Next adapter: Radeon i2c bit bus 0x92 (i2c-3)
Do you want to scan it? (YES/no/selectively):
Next adapter: Radeon i2c bit bus 0x93 (i2c-4)
Do you want to scan it? (YES/no/selectively):

Next adapter: Radeon i2c bit bus 0x14 (i2c-5)
Do you want to scan it? (YES/no/selectively):

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `jc42':
  * Bus `SMBus PIIX4 adapter at 0b00'
    Busdriver `i2c_piix4', I2C address 0x18
    Chip `jc42' (confidence: 6)

Driver `to-be-written':
  * ISA bus
    Chip `IPMI BMC KCS' (confidence: 8)

Driver `k10temp' (autoloaded):
  * Chip `AMD Family 10h thermal sensors' (confidence: 9)

Note: there is no driver for IPMI BMC KCS yet.
Check http://www.lm-sensors.org/wiki/Devices for updates.

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
jc42
#----cut here----
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)n



Here's the output of sensors:

jc42-i2c-0-18
Adapter: SMBus PIIX4 adapter at 0b00
temp1:        +30.5=C2=B0C  (low  =3D  +0.0=C2=B0C)                  ALARM =
(HIGH,
CRIT)
                       (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
                       (crit =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)

k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +31.5=C2=B0C  (high =3D +70.0=C2=B0C)
                       (crit =3D +100.0=C2=B0C, hyst =3D +95.0=C2=B0C)


With help from Eddi De Pieri I got to this post:

http://www.spinics.net/lists/linux-i2c/msg07284.html

but I can't establish the exact process.  I was able to download the new
sensors-detect binary, set it executable and run it.  I get these results:

# sensors-detect revision 5984 (2011-07-10 21:22:53 +0200)
# System: HP ProLiant MicroServer

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): y
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           Success!
    (driver `k10temp')
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
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
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
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
Found `IPMI BMC KCS'...                                     Success!
    (confidence 8, driver `to-be-written')

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc
SB600/SB700/SB800 SMBus

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x18
Handled by driver `jc42' (already loaded), chip type `jc42'
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...
Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Next adapter: Radeon i2c bit bus 0x90 (i2c-1)
Do you want to scan it? (YES/no/selectively):
Next adapter: Radeon i2c bit bus 0x91 (i2c-2)
Do you want to scan it? (YES/no/selectively):

Next adapter: Radeon i2c bit bus 0x92 (i2c-3)
Do you want to scan it? (YES/no/selectively):

Next adapter: Radeon i2c bit bus 0x93 (i2c-4)
Do you want to scan it? (YES/no/selectively):

Next adapter: Radeon i2c bit bus 0x14 (i2c-5)
Do you want to scan it? (YES/no/selectively):

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `jc42':
  * Bus `SMBus PIIX4 adapter at 0b00'
    Busdriver `i2c_piix4', I2C address 0x18
    Chip `jc42' (confidence: 6)

Driver `to-be-written':
  * ISA bus
    Chip `IPMI BMC KCS' (confidence: 8)

Driver `k10temp' (autoloaded):
  * Chip `AMD Family 10h thermal sensors' (confidence: 9)

Note: there is no driver for IPMI BMC KCS yet.
Check http://www.lm-sensors.org/wiki/Devices for updates.


Do you want to generate /etc/conf.d/lm_sensors? Enter s to specify other
file name?
  (YES/no/s): y
Sorry, can't create /etc/conf.d/lm_sensors (No such file or directory). at
/usr/sbin/sensors-detect-new line 6502, <STDIN> line 13.


This seems to generate an error at the end, see above.

The threads I've read seem to mention patching an i2c driver, which I can't
find on my system.

Can anyone tell me exactly what process I need to follow?  Or where I
should ask if this list is the wrong place?

Thank you


Simon

--bcaec517a9d432e61404c8670ac6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I&#39;ve spent many hours reading up on patching lm-=
sensors but I&#39;m either looking in the wrong place, mis-understanding th=
e patch command, or a combination!</div><div><br></div><div>uname -a report=
s:</div>
<div><div>3.2.0-29-generic-pae #46-Ubuntu SMP Fri Jul 27 17:25:43 UTC 2012 =
i686 athlon i386 GNU/Linux</div></div><div><br></div><div>This is an HP Pro=
liant Microserver N40L. =A0There are a few threads about this hardware and =
I see people have got sensors working properly on this machine, but I can&#=
39;t find how to patch the software correctly.</div>
<div><br></div><div>Here&#39;s my sensors-detect:</div>
<div><br></div><div><div># sensors-detect revision 5984 (2011-07-10 21:22:5=
3 +0200)</div><div># System: HP ProLiant MicroServer</div><div><br></div><d=
iv>This program will help you determine which kernel modules you need</div>

<div>to load to use lm_sensors most effectively. It is generally safe</div>=
<div>and recommended to accept the default answers to all questions,</div><=
div>unless you know what you&#39;re doing.</div><div><br></div><div>Some so=
uth bridges, CPUs or memory controllers contain embedded sensors.</div>

<div>Do you want to scan for them? This is totally safe. (YES/no):</div><di=
v>Silicon Integrated Systems SIS5595... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 No</div><div>VIA VT82C686 Integrated Sensors... =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div><div>

VIA VT8231 Integrated Sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0No</div><div>AMD K8 thermal sensors... =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>AMD Family 10h=
 thermal sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Suc=
cess!</div>
<div>
=A0 =A0 (driver `k10temp&#39;)</div><div>AMD Family 11h thermal sensors... =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>AMD Family=
 12h and 14h thermal sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div=
><div>AMD Family 15h thermal sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 No</div>

<div>AMD Family 15h power sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 No</div><div>Intel digital thermal sensor... =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>Intel AMB FB-D=
IMM thermal sensor... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</d=
iv><div>

VIA C7 thermal sensor... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0No</div><div>VIA Nano thermal sensor... =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div><div><br></d=
iv><div>Some Super I/O chips contain embedded sensors. We have to write to<=
/div>

<div>standard I/O ports to probe them. This is usually safe.</div><div>Do y=
ou want to scan for Super I/O sensors? (YES/no):</div><div>Probing for Supe=
r-I/O at 0x2e/0x2f</div><div>Trying family `National Semiconductor/ITE&#39;=
... =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div>

<div>Trying family `SMSC&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>Trying family `VIA/Winbond/Nuv=
oton/Fintek&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>Trying family =
`ITE&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0No</div>

<div>Probing for Super-I/O at 0x4e/0x4f</div><div>Trying family `National S=
emiconductor/ITE&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>Trying fa=
mily `SMSC&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 No</div><div>Trying family `VIA/Winbond/Nuvoton/Fintek&#39;=
... =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div>

<div>Trying family `ITE&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div><div><br></div><div>Some systems (m=
ainly servers) implement IPMI, a set of common interfaces</div><div>through=
 which system health data may be retrieved, amongst other things.</div>

<div>We first try to get the information from SMBIOS. If we don&#39;t find =
it</div><div>there, we have to read from arbitrary I/O ports to probe for s=
uch</div><div>interfaces. This is normally safe. Do you want to scan for IP=
MI</div>

<div>interfaces? (YES/no):</div><div>Found `IPMI BMC KCS&#39;... =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Success!</d=
iv><div>=A0 =A0 (confidence 8, driver `to-be-written&#39;)</div><div><br></=
div><div>Some hardware monitoring chips are accessible through the ISA I/O =
ports.</div>

<div>We have to write to arbitrary I/O ports to probe them. This is usually=
</div><div>safe though. Yes, you do have ISA I/O ports even if you do not h=
ave any</div><div>ISA slots! Do you want to scan the ISA I/O ports? (YES/no=
):</div>

<div>Probing for `National Semiconductor LM78&#39; at 0x290... =A0 =A0 =A0 =
No</div><div>Probing for `National Semiconductor LM79&#39; at 0x290... =A0 =
=A0 =A0 No</div><div>Probing for `Winbond W83781D&#39; at 0x290... =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div>

<div>Probing for `Winbond W83782D&#39; at 0x290... =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 No</div><div><br></div><div>Lastly, we can probe the I2C/SMBus =
adapters for connected hardware</div><div>monitoring devices. This is the m=
ost risky part, and while it works</div>

<div>reasonably well on most systems, it has been reported to cause trouble=
</div><div>on some systems.</div><div>Do you want to probe the I2C/SMBus ad=
apters now? (YES/no):</div><div>Using driver `i2c-piix4&#39; for device 000=
0:00:14.0: ATI Technologies Inc SB600/SB700/SB800 SMBus</div>

<div><br></div><div>Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)</div>=
<div>Do you want to scan it? (YES/no/selectively):</div><div>Client found a=
t address 0x18</div><div>Handled by driver `jc42&#39; (already loaded), chi=
p type `jc42&#39;</div>

<div>Client found at address 0x50</div><div>Probing for `Analog Devices ADM=
1033&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>Probing f=
or `Analog Devices ADM1034&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
No</div><div>Probing for `SPD EEPROM&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Yes</div>

<div>=A0 =A0 (confidence 8, not a hardware monitoring chip)</div><div>Probi=
ng for `EDID EEPROM&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0No</div><div><br></div><div>Next adapter: Radeon i2c bit bu=
s 0x90 (i2c-1)</div><div>Do you want to scan it? (YES/no/selectively):</div=
>

<div><br></div><div>Next adapter: Radeon i2c bit bus 0x91 (i2c-2)</div><div=
>Do you want to scan it? (YES/no/selectively):</div><div><br></div><div><br=
></div><div>Next adapter: Radeon i2c bit bus 0x92 (i2c-3)</div><div>Do you =
want to scan it? (YES/no/selectively):</div>

<div>Next adapter: Radeon i2c bit bus 0x93 (i2c-4)</div><div>Do you want to=
 scan it? (YES/no/selectively):</div><div><br></div><div>Next adapter: Rade=
on i2c bit bus 0x14 (i2c-5)</div><div>Do you want to scan it? (YES/no/selec=
tively):</div>

<div><br></div><div>Now follows a summary of the probes I have just done.</=
div><div>Just press ENTER to continue:</div><div><br></div><div>Driver `jc4=
2&#39;:</div><div>=A0 * Bus `SMBus PIIX4 adapter at 0b00&#39;</div><div>
=A0 =A0 Busdriver `i2c_piix4&#39;, I2C address 0x18</div>
<div>=A0 =A0 Chip `jc42&#39; (confidence: 6)</div><div><br></div><div>Drive=
r `to-be-written&#39;:</div><div>=A0 * ISA bus</div><div>=A0 =A0 Chip `IPMI=
 BMC KCS&#39; (confidence: 8)</div><div><br></div><div>Driver `k10temp&#39;=
 (autoloaded):</div>

<div>=A0 * Chip `AMD Family 10h thermal sensors&#39; (confidence: 9)</div><=
div><br></div><div>Note: there is no driver for IPMI BMC KCS yet.</div><div=
>Check <a href=3D"http://www.lm-sensors.org/wiki/Devices" target=3D"_blank"=
>http://www.lm-sensors.org/wiki/Devices</a> for updates.</div>

<div><br></div><div>To load everything that is needed, add this to /etc/mod=
ules:</div><div>#----cut here----</div><div># Chip drivers</div><div>jc42</=
div><div>#----cut here----</div><div>If you have some drivers built into yo=
ur kernel, the list above will</div>

<div>contain too many modules. Skip the appropriate ones!</div><div><br></d=
iv><div>Do you want to add these lines automatically to /etc/modules? (yes/=
NO)n</div></div><div><br></div><div><br></div><div><br><div>Here&#39;s the =
output of sensors:
</div></div><div><br></div><div><div>jc42-i2c-0-18</div><div>Adapter: SMBus=
 PIIX4 adapter at 0b00</div><div>temp1: =A0 =A0 =A0 =A0+30.5=C2=B0C =A0(low=
 =A0=3D =A0+0.0=C2=B0C) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ALARM (HIGH, CRI=
T)</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(high =3D =A0+0=
.0=C2=B0C, hyst =3D =A0+0.0=C2=B0C)</div>

<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(crit =3D =A0+0.0=C2=B0=
C, hyst =3D =A0+0.0=C2=B0C)</div><div><br></div><div>k10temp-pci-00c3</div>=
<div>Adapter: PCI adapter</div><div>temp1: =A0 =A0 =A0 =A0+31.5=C2=B0C =A0(=
high =3D +70.0=C2=B0C)</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(crit =3D +100.0=C2=B0C, hyst =3D +95.0=C2=B0C)</div>

</div><div><br></div><div><br></div><div>With help from=A0<span style=3D"ba=
ckground-color:rgb(255,255,255);color:rgb(34,34,34);font-family:arial,sans-=
serif;font-size:13px;white-space:nowrap">Eddi De Pieri I got to this post:<=
/span></div>
<div><span style=3D"background-color:rgb(255,255,255);color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:13px;white-space:nowrap"><br></span><=
/div><div><a href=3D"http://www.spinics.net/lists/linux-i2c/msg07284.html">=
http://www.spinics.net/lists/linux-i2c/msg07284.html</a>
</div><div><br></div><div>but I can&#39;t establish the exact process. =A0I=
 was able to download the new sensors-detect binary, set it executable and =
run it. =A0I get these results:</div><div><br></div><div><div># sensors-det=
ect revision 5984 (2011-07-10 21:22:53 +0200)</div>
<div># System: HP ProLiant MicroServer</div><div><br></div><div>This progra=
m will help you determine which kernel modules you need</div><div>to load t=
o use lm_sensors most effectively. It is generally safe</div><div>and recom=
mended to accept the default answers to all questions,</div>
<div>unless you know what you&#39;re doing.</div><div><br></div><div>Some s=
outh bridges, CPUs or memory controllers contain embedded sensors.</div><di=
v>Do you want to scan for them? This is totally safe. (YES/no): y</div>
<div>Silicon Integrated Systems SIS5595... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 No</div><div>VIA VT82C686 Integrated Sensors... =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div><div>VIA VT8231 Integrated Sens=
ors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div><div>
AMD K8 thermal sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 No</div><div>AMD Family 10h thermal sensors... =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Success!</div><div>=A0 =A0 (dri=
ver `k10temp&#39;)</div><div>AMD Family 11h thermal sensors... =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div>
<div>AMD Family 12h and 14h thermal sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 No</div><div>AMD Family 15h thermal sensors... =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>AMD Family 15h power sensors..=
. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>
Intel digital thermal sensor... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 No</div><div>Intel AMB FB-DIMM thermal sensor... =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>VIA C7 thermal sensor... =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</=
div><div>VIA Nano thermal sensor... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div>
<div><br></div><div>Some Super I/O chips contain embedded sensors. We have =
to write to</div><div>standard I/O ports to probe them. This is usually saf=
e.</div><div>Do you want to scan for Super I/O sensors? (YES/no):</div>
<div>Probing for Super-I/O at 0x2e/0x2f</div><div>Trying family `National S=
emiconductor/ITE&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div>Trying fa=
mily `SMSC&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 No</div><div>Trying family `VIA/Winbond/Nuvoton/Fintek&#39;=
... =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div>
<div>Trying family `ITE&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div><div>Probing for Super-I/O at 0x4e/=
0x4f</div><div>Trying family `National Semiconductor/ITE&#39;... =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 No</div><div>Trying family `SMSC&#39;... =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div>
<div>Trying family `VIA/Winbond/Nuvoton/Fintek&#39;... =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 No</div><div>Trying family `ITE&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No</div><div><br></div><div=
>Some systems (mainly servers) implement IPMI, a set of common interfaces</=
div>
<div>through which system health data may be retrieved, amongst other thing=
s.</div><div>We first try to get the information from SMBIOS. If we don&#39=
;t find it</div><div>there, we have to read from arbitrary I/O ports to pro=
be for such</div>
<div>interfaces. This is normally safe. Do you want to scan for IPMI</div><=
div>interfaces? (YES/no):</div><div>Found `IPMI BMC KCS&#39;... =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Success!</div>=
<div>=A0 =A0 (confidence 8, driver `to-be-written&#39;)</div>
<div><br></div><div>Some hardware monitoring chips are accessible through t=
he ISA I/O ports.</div><div>We have to write to arbitrary I/O ports to prob=
e them. This is usually</div><div>safe though. Yes, you do have ISA I/O por=
ts even if you do not have any</div>
<div>ISA slots! Do you want to scan the ISA I/O ports? (YES/no):</div><div>=
Probing for `National Semiconductor LM78&#39; at 0x290... =A0 =A0 =A0 No</d=
iv><div>Probing for `National Semiconductor LM79&#39; at 0x290... =A0 =A0 =
=A0 No</div>
<div>Probing for `Winbond W83781D&#39; at 0x290... =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 No</div><div>Probing for `Winbond W83782D&#39; at 0x290... =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No</div><div><br></div><div>Lastly, we can =
probe the I2C/SMBus adapters for connected hardware</div>
<div>monitoring devices. This is the most risky part, and while it works</d=
iv><div>reasonably well on most systems, it has been reported to cause trou=
ble</div><div>on some systems.</div><div>Do you want to probe the I2C/SMBus=
 adapters now? (YES/no):</div>
<div>Using driver `i2c-piix4&#39; for device 0000:00:14.0: ATI Technologies=
 Inc SB600/SB700/SB800 SMBus</div><div><br></div><div>Next adapter: SMBus P=
IIX4 adapter at 0b00 (i2c-0)</div><div>Do you want to scan it? (YES/no/sele=
ctively):</div>
<div>Client found at address 0x18</div><div>Handled by driver `jc42&#39; (a=
lready loaded), chip type `jc42&#39;</div><div>Client found at address 0x50=
</div><div>Probing for `Analog Devices ADM1033&#39;... =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 No</div>
<div>Probing for `Analog Devices ADM1034&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 No</div><div>Probing for `SPD EEPROM&#39;...</div><div>Yes<=
/div><div>=A0 =A0 (confidence 8, not a hardware monitoring chip)</div><div>=
Probing for `EDID EEPROM&#39;... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0No</div>
<div><br></div><div>Next adapter: Radeon i2c bit bus 0x90 (i2c-1)</div><div=
>Do you want to scan it? (YES/no/selectively):</div><div>Next adapter: Rade=
on i2c bit bus 0x91 (i2c-2)</div><div>Do you want to scan it? (YES/no/selec=
tively):</div>
<div><br></div><div>Next adapter: Radeon i2c bit bus 0x92 (i2c-3)</div><div=
>Do you want to scan it? (YES/no/selectively):</div><div><br></div><div>Nex=
t adapter: Radeon i2c bit bus 0x93 (i2c-4)</div><div>Do you want to scan it=
? (YES/no/selectively):</div>
<div><br></div><div>Next adapter: Radeon i2c bit bus 0x14 (i2c-5)</div><div=
>Do you want to scan it? (YES/no/selectively):</div><div><br></div><div>Now=
 follows a summary of the probes I have just done.</div><div>Just press ENT=
ER to continue:</div>
<div><br></div><div>Driver `jc42&#39;:</div><div>=A0 * Bus `SMBus PIIX4 ada=
pter at 0b00&#39;</div><div>=A0 =A0 Busdriver `i2c_piix4&#39;, I2C address =
0x18</div><div>=A0 =A0 Chip `jc42&#39; (confidence: 6)</div><div><br></div>=
<div>Driver `to-be-written&#39;:</div>
<div>=A0 * ISA bus</div><div>=A0 =A0 Chip `IPMI BMC KCS&#39; (confidence: 8=
)</div><div><br></div><div>Driver `k10temp&#39; (autoloaded):</div><div>=A0=
 * Chip `AMD Family 10h thermal sensors&#39; (confidence: 9)</div><div><br>=
</div>
<div>Note: there is no driver for IPMI BMC KCS yet.</div><div>Check <a href=
=3D"http://www.lm-sensors.org/wiki/Devices">http://www.lm-sensors.org/wiki/=
Devices</a> for updates.</div><div><br></div><div><br></div><div>Do you wan=
t to generate /etc/conf.d/lm_sensors? Enter s to specify other file name?</=
div>
<div>=A0 (YES/no/s): y</div><div>Sorry, can&#39;t create /etc/conf.d/lm_sen=
sors (No such file or directory). at /usr/sbin/sensors-detect-new line 6502=
, &lt;STDIN&gt; line 13.</div></div><div><br></div><div><br></div><div>This=
 seems to generate an error at the end, see above.</div>
<div><br></div><div>The threads I&#39;ve read seem to mention patching an i=
2c driver, which I can&#39;t find on my system.</div><div><br></div><div>Ca=
n anyone tell me exactly what process I need to follow? =A0Or where I shoul=
d ask if this list is the wrong place?<br>
<br>Thank you</div><div><br></div><div><br></div><div>Simon</div>

--bcaec517a9d432e61404c8670ac6--


--===============3680664074773275991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3680664074773275991==--
