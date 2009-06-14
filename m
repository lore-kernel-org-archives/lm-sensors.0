From: Maneki Neko <manekineko@gmail.com>
Date: Sun, 14 Jun 2009 04:36:11 +0000
Subject: [lm-sensors] VID on Intel Core Duo
Message-Id: <a0bfe2b50906132136s31d71fa5le2bd739245d51c8f@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6893404088589072219=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6893404088589072219==
Content-Type: multipart/alternative; boundary=0016e647f026231ceb046c477b3c

--0016e647f026231ceb046c477b3c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I'm trying to obtain the VID on an HP notebook with a Core Duo CPU.  Under
Windows, I could see the voltage, speed, temperature, etc. but with
lm-sensors all I'm able to see is the temperature.

I have run sensors-detect to no avail.  Can anyone provide any advice to me
on how to get this working?  Thanks for your time and help!

Here is the output from sensors-detect:

# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no): yes
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
>
> We will now try to load each adapter module in turn.
> Load `i2c-i801' (say NO if built into your kernel)? (YES/no): yes
> Module loaded successfully.
> If you have undetectable or unsupported I2C/SMBus adapters, you can have
> them scanned by manually loading the modules before running this script.
>
> To continue, we need module `i2c-dev' to be loaded.
> Do you want to load `i2c-dev' now? (YES/no): yes
> Module loaded successfully.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
>
> Next adapter: SMBus I801 adapter at 18e0 (i2c-0)
> Do you want to scan it? (YES/no/selectively): yes
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
>
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no): yes
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): yes
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
>
> Some south bridges, CPUs or memory controllers may also contain
> embedded sensors. Do you want to scan for them? (YES/no): yes
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD K10 thermal sensors...                                  No
> Intel Core family thermal sensor...                         Success!
>     (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...                         No
>
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>
> Driver `coretemp' (should be inserted):
>   Detects correctly:
>   * Chip `Intel Core family thermal sensor' (confidence: 9)
>
> I will now generate the commands needed to load the required modules.
> Just press ENTER to continue:
>
> To load everything that is needed, add this to /etc/modules:
>
> #----cut here----
> # Chip drivers
> coretemp
> #----cut here----
>

--0016e647f026231ceb046c477b3c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;m trying to obtain the VID on an HP notebook with a Core Duo CPU.=A0 =
Under Windows, I could see the voltage, speed, temperature, etc. but with l=
m-sensors all I&#39;m able to see is the temperature.<br><br>I have run sen=
sors-detect to no avail.=A0 Can anyone provide any advice to me on how to g=
et this working?=A0 Thanks for your time and help!<br>
<br>Here is the output from sensors-detect:<br><br><blockquote style=3D"bor=
der-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-=
left: 1ex;" class=3D"gmail_quote"># sensors-detect revision 5249 (2008-05-1=
1 22:56:25 +0200)<br>
<br>This program will help you determine which kernel modules you need<br>t=
o load to use lm_sensors most effectively. It is generally safe<br>and reco=
mmended to accept the default answers to all questions,<br>unless you know =
what you&#39;re doing.<br>
<br>We can start with probing for (PCI) I2C or SMBus adapters.<br>Do you wa=
nt to probe now? (YES/no): yes<br>Probing for PCI bus adapters...<br>Use dr=
iver `i2c-i801&#39; for device 0000:00:1f.3: Intel 82801G ICH7<br><br>We wi=
ll now try to load each adapter module in turn.<br>
Load `i2c-i801&#39; (say NO if built into your kernel)? (YES/no): yes<br>Mo=
dule loaded successfully.<br>If you have undetectable or unsupported I2C/SM=
Bus adapters, you can have<br>them scanned by manually loading the modules =
before running this script.<br>
<br>To continue, we need module `i2c-dev&#39; to be loaded.<br>Do you want =
to load `i2c-dev&#39; now? (YES/no): yes<br>Module loaded successfully.<br>=
<br>We are now going to do the I2C/SMBus adapter probings. Some chips may<b=
r>
be double detected; we choose the one with the highest confidence<br>value =
in that case.<br>If you found that the adapter hung after probing a certain=
 address,<br>you can specify that address to remain unprobed.<br><br>Next a=
dapter: SMBus I801 adapter at 18e0 (i2c-0)<br>
Do you want to scan it? (YES/no/selectively): yes<br>Client found at addres=
s 0x50<br>Probing for `Analog Devices ADM1033&#39;...=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `Analog Devices A=
DM1034&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
No<br>
Probing for `SPD EEPROM&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes<br>=A0=A0=A0 (co=
nfidence 8, not a hardware monitoring chip)<br>Probing for `EDID EEPROM&#39=
;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br><br>Some chips are also accessible through t=
he ISA I/O ports. We have to<br>
write to arbitrary I/O ports to probe them. This is usually safe though.<br=
>Yes, you do have ISA I/O ports even if you do not have any ISA slots!<br>D=
o you want to scan the ISA I/O ports? (YES/no): yes<br>Probing for `Nationa=
l Semiconductor LM78&#39; at 0x290...=A0=A0=A0=A0=A0=A0 No<br>
Probing for `National Semiconductor LM78-J&#39; at 0x290...=A0=A0=A0=A0 No<=
br>Probing for `National Semiconductor LM79&#39; at 0x290...=A0=A0=A0=A0=A0=
=A0 No<br>Probing for `Winbond W83781D&#39; at 0x290...=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `Winbond W83782D&#39=
; at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Probing for `IPMI BMC KCS&#39; at 0xca0...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `IPMI BMC SMIC&#39; at 0xc=
a8...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br><br=
>Some Super I/O chips may also contain sensors. We have to write to<br>stan=
dard I/O ports to probe them. This is usually safe.<br>
Do you want to scan for Super I/O sensors? (YES/no): yes<br>Probing for Sup=
er-I/O at 0x2e/0x2f<br>Trying family `National Semiconductor&#39;...=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying family `SMSC&=
#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Trying family `VIA/Winbond/Fintek&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying family `ITE&#39;...=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for Super-I/O at 0x4e/0x4f<br>Try=
ing family `National Semiconductor&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 No<br>
Trying family `SMSC&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying f=
amily `VIA/Winbond/Fintek&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying family `ITE&#39;...=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No<br><br>Some south bridges, CPUs or memory controllers=
 may also contain<br>
embedded sensors. Do you want to scan for them? (YES/no): yes<br>Silicon In=
tegrated Systems SIS5595...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No<br>VIA VT82C686 Integrated Sensors...=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>VIA VT82=
31 Integrated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
AMD K8 thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>AMD K10 therma=
l sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Intel Core family thermal sensor=
...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Success!<br>=A0=A0=A0 (driver `coretemp&#39;)<br>
Intel AMB FB-DIMM thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br><br>Now follows a summary of the pr=
obes I have just done.<br>Just press ENTER to continue: <br><br>Driver `cor=
etemp&#39; (should be inserted):<br>=A0 Detects correctly:<br>
=A0 * Chip `Intel Core family thermal sensor&#39; (confidence: 9)<br><br>I =
will now generate the commands needed to load the required modules.<br>Just=
 press ENTER to continue: <br><br>To load everything that is needed, add th=
is to /etc/modules:<br>
<br>#----cut here----<br># Chip drivers<br>coretemp<br>#----cut here----<br=
></blockquote><br>

--0016e647f026231ceb046c477b3c--


--===============6893404088589072219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6893404088589072219==--
