From: borat Gunter <borat.gunter@googlemail.com>
Date: Thu, 24 Jun 2010 07:10:59 +0000
Subject: Re: [lm-sensors] Starting up sensors failed
Message-Id: <AANLkTimTl564ljs0lljqsQEz0x03Rqaf3QIr1sgKXiiP@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0684890539360657748=="
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTin5YgS58dgFucaJc1byomXnF0m0p5_n-YgezrL-@mail.gmail.com>
In-Reply-To: <AANLkTin5YgS58dgFucaJc1byomXnF0m0p5_n-YgezrL-@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0684890539360657748==
Content-Type: multipart/alternative; boundary=0015174768164533110489c15b7f

--0015174768164533110489c15b7f
Content-Type: text/plain; charset=ISO-8859-1

Hello Jean,

On Wed, Jun 23, 2010 at 2:38 PM, Jean Delvare <khali@linux-fr.org> wrote:

> On Wed, 23 Jun 2010 14:17:38 +0200, borat Gunter wrote:
> > Hello Everyone,
> >
> > i have done the *sensors-detect*, and the summary output looks like:
> >
> >  *Now follows a summary of the probes I have just done.
> >  Just press ENTER to continue:
> >
> > Driver `eeprom' (should be inserted):
> >   Detects correctly:
> >   * Bus `SMBus PIIX4 adapter at 0440'
> >     Busdriver `i2c-piix4', I2C address 0x50
> >     Chip `SPD EEPROM' (confidence: 1)
>
> If you see this, this means you are running a VERY old version of
> sensors-detect. So, try the latest version first [1], and then report
> again if it still doesn't work.
>
> [1] http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>
> >
> > I will now generate the commands needed to load the I2C modules.
> >
> > To make the sensors modules behave correctly, add these lines to
> > /etc/modprobe.conf:
> > #----cut here----
> > # I2C module options
> > alias char-major-89 i2c-dev
> > #----cut here----
> > To load everything that is needed, add this to some /etc/rc* file:
> > #----cut here----
> > # I2C adapter drivers
> > modprobe i2c-piix4
> > # I2C chip drivers
> > modprobe eeprom
> > # sleep 2 # optional
> > /usr/bin/sensors -s # recommended
> > #----cut here----
> >
> > WARNING! If you have some things built into your kernel, the list above
> > will contain too many modules. Skip the appropriate ones! You really
> should
> > try these commands right now to make sure everything is working properly.
> > Monitoring programs won't work until it's done.
> >
> > Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
> > insserv: can not symlink(../arkeia, rc2.d/S06arkeia): File exists
> > insserv: can not symlink(../arkeia, rc3.d/S06arkeia): File exists
> > insserv: can not symlink(../arkeia, rc4.d/S06arkeia): File exists
> > insserv: can not symlink(../arkeia, rc5.d/S06arkeia): File exists
>
> These errors come from your distribution and are unrelated to
> lm-sensors.
>
> >
> > *and then i tried to ignore these error message to start the sensors,
> > unfortunately failed.
> > *:~ # /etc/init.d/lm_sensors start
> > Starting up sensors:
> failed*
> >
> > Can somebody help me? What does insserv mean? And how to correct it?
>
> "failed" isn't descriptive enough for us to help you. You'll have to
> figure out which command in /etc/init.d/lm_sensors (which again is part
> of your distribution and not lm-sensors) failed.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html




thanks a lot for your answer, I tried with the newest version of
sensors-detect that you suggested. And the output are:
# sensors-detect revision 5842 (2010-06-19 21:47:45 +0200)
# System: IBM eserver xSeries 345 -[867011X]-
# Board: IBM Not Specified

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
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
*Trying family `National Semiconductor'...                   Yes
Found `Nat. Semi. PC8741x Super IO'
    (no hardware monitoring capabilities)*
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
Using driver `i2c-piix4' for device 0000:00:0f.0: ServerWorks CSB5 South
Bridge

Next adapter: SMBus PIIX4 adapter at 0440 (i2c-0)
Do you want to scan it? (YES/no/selectively):

*Sorry, no sensors were detected.
*Either your system has no sensors, or they are not supported, or
they are connected to an I2C or SMBus adapter that is not
supported. If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.

It has different check result comparing to the old version, which should I
believe? And what else kann I do?

Best regards
Borat.

--0015174768164533110489c15b7f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Jean,<br><br><div class=3D"gmail_quote">On Wed, Jun 23, 2010 at 2:38 =
PM, Jean Delvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org=
">khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 20=
4, 204); padding-left: 1ex;">
<div class=3D"im">On Wed, 23 Jun 2010 14:17:38 +0200, borat Gunter wrote:<b=
r>
&gt; Hello Everyone,<br>
&gt;<br>
&gt; i have done the *sensors-detect*, and the summary output looks like:<b=
r>
&gt;<br>
&gt; =A0*Now follows a summary of the probes I have just done.<br>
&gt; =A0Just press ENTER to continue:<br>
&gt;<br>
&gt; Driver `eeprom&#39; (should be inserted):<br>
&gt; =A0 Detects correctly:<br>
&gt; =A0 * Bus `SMBus PIIX4 adapter at 0440&#39;<br>
&gt; =A0 =A0 Busdriver `i2c-piix4&#39;, I2C address 0x50<br>
&gt; =A0 =A0 Chip `SPD EEPROM&#39; (confidence: 1)<br>
<br>
</div>If you see this, this means you are running a VERY old version of<br>
sensors-detect. So, try the latest version first [1], and then report<br>
again if it still doesn&#39;t work.<br>
<br>
[1] <a href=3D"http://dl.lm-sensors.org/lm-sensors/files/sensors-detect" ta=
rget=3D"_blank">http://dl.lm-sensors.org/lm-sensors/files/sensors-detect</a=
><br>
<div><div></div><div class=3D"h5"><br>
&gt;<br>
&gt; I will now generate the commands needed to load the I2C modules.<br>
&gt;<br>
&gt; To make the sensors modules behave correctly, add these lines to<br>
&gt; /etc/modprobe.conf:<br>
&gt; #----cut here----<br>
&gt; # I2C module options<br>
&gt; alias char-major-89 i2c-dev<br>
&gt; #----cut here----<br>
&gt; To load everything that is needed, add this to some /etc/rc* file:<br>
&gt; #----cut here----<br>
&gt; # I2C adapter drivers<br>
&gt; modprobe i2c-piix4<br>
&gt; # I2C chip drivers<br>
&gt; modprobe eeprom<br>
&gt; # sleep 2 # optional<br>
&gt; /usr/bin/sensors -s # recommended<br>
&gt; #----cut here----<br>
&gt;<br>
&gt; WARNING! If you have some things built into your kernel, the list abov=
e<br>
&gt; will contain too many modules. Skip the appropriate ones! You really s=
hould<br>
&gt; try these commands right now to make sure everything is working proper=
ly.<br>
&gt; Monitoring programs won&#39;t work until it&#39;s done.<br>
&gt;<br>
&gt; Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):<br>
&gt; insserv: can not symlink(../arkeia, rc2.d/S06arkeia): File exists<br>
&gt; insserv: can not symlink(../arkeia, rc3.d/S06arkeia): File exists<br>
&gt; insserv: can not symlink(../arkeia, rc4.d/S06arkeia): File exists<br>
&gt; insserv: can not symlink(../arkeia, rc5.d/S06arkeia): File exists<br>
<br>
</div></div>These errors come from your distribution and are unrelated to<b=
r>
lm-sensors.<br>
<br>
&gt;<br>
&gt; *and then i tried to ignore these error message to start the sensors,<=
br>
<div class=3D"im">&gt; unfortunately failed.<br>
&gt; *:~ # /etc/init.d/lm_sensors start<br>
&gt; Starting up sensors: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 failed*<br>
&gt;<br>
&gt; Can somebody help me? What does insserv mean? And how to correct it?<b=
r>
<br>
</div>&quot;failed&quot; isn&#39;t descriptive enough for us to help you. Y=
ou&#39;ll have to<br>
figure out which command in /etc/init.d/lm_sensors (which again is part<br>
of your distribution and not lm-sensors) failed.<br>
<font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
<a href=3D"http://khali.linux-fr.org/wishlist.html" target=3D"_blank">http:=
//khali.linux-fr.org/wishlist.html</a></font></blockquote><div><br><br>
<br>
thanks a lot for your answer, I tried with the newest version of=20
sensors-detect that you suggested. And the output are:<br>
# sensors-detect revision 5842 (2010-06-19 21:47:45 +0200)<br>
# System: IBM eserver xSeries 345 -[867011X]-<br>
# Board: IBM Not Specified<br>
<br>
This program will help you determine which kernel modules you need<br>
to load to use lm_sensors most effectively. It is generally safe<br>
and recommended to accept the default answers to all questions,<br>
unless you know what you&#39;re doing.<br>
<br>
Some south bridges, CPUs or memory controllers contain embedded sensors.<br=
>
Do you want to scan for them? This is totally safe. (YES/no):<br>
Silicon Integrated Systems SIS5595...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
VIA VT82C686 Integrated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
VIA VT8231 Integrated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
AMD K8 thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
AMD Family 10h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
AMD Family 11h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Intel Core family thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Intel Atom thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Intel AMB FB-DIMM thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
VIA C7 thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
VIA Nano thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
<br>
Some Super I/O chips contain embedded sensors. We have to write to<br>
standard I/O ports to probe them. This is usually safe.<br>
Do you want to scan for Super I/O sensors? (YES/no):<br>
Probing for Super-I/O at 0x2e/0x2f<br>
<b>Trying family `National Semiconductor&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes<br>
Found `Nat. Semi. PC8741x Super IO&#39;<br>
=A0=A0=A0 (no hardware monitoring capabilities)</b><br>
Probing for Super-I/O at 0x4e/0x4f<br>
Trying family `National Semiconductor&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Trying family `SMSC&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Trying family `VIA/Winbond/Nuvoton/Fintek&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No<br>
Trying family `ITE&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
<br>
Some systems (mainly servers) implement IPMI, a set of common interfaces<br=
>
through which system health data may be retrieved, amongst other things.<br=
>
We first try to get the information from SMBIOS. If we don&#39;t find it<br=
>
there, we have to read from arbitrary I/O ports to probe for such<br>
interfaces. This is normally safe. Do you want to scan for IPMI<br>
interfaces? (YES/no):<br>
Probing for `IPMI BMC KCS&#39; at 0xca0...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Probing for `IPMI BMC SMIC&#39; at 0xca8...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
<br>
Some hardware monitoring chips are accessible through the ISA I/O ports.<br=
>
We have to write to arbitrary I/O ports to probe them. This is usually<br>
safe though. Yes, you do have ISA I/O ports even if you do not have any<br>
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):<br>
Probing for `National Semiconductor LM78&#39; at 0x290...=A0=A0=A0=A0=A0=A0=
 No<br>
Probing for `National Semiconductor LM79&#39; at 0x290...=A0=A0=A0=A0=A0=A0=
 No<br>
Probing for `Winbond W83781D&#39; at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Probing for `Winbond W83782D&#39; at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
<br>
Lastly, we can probe the I2C/SMBus adapters for connected hardware<br>
monitoring devices. This is the most risky part, and while it works<br>
reasonably well on most systems, it has been reported to cause trouble<br>
on some systems.<br>
Do you want to probe the I2C/SMBus adapters now? (YES/no):<br>
Using driver `i2c-piix4&#39; for device 0000:00:0f.0: ServerWorks CSB5 Sout=
h
 Bridge<br>
<br>
Next adapter: SMBus PIIX4 adapter at 0440 (i2c-0)<br>
Do you want to scan it? (YES/no/selectively):<br>
<br>
<b>Sorry, no sensors were detected.<br>
</b>Either your system has no sensors, or they are not supported, or<br>
they are connected to an I2C or SMBus adapter that is not<br>
supported. If you find out what chips are on your board, check<br>
<a href=3D"http://www.lm-sensors.org/wiki/Devices">http://www.lm-sensors.or=
g/wiki/Devices</a> for driver status.<br>
=A0<br>It has different check result comparing to the old version, which=20
should I believe? And what else kann I do?<br>
<br>
Best regards<br>
Borat. <br></div></div><br>

--0015174768164533110489c15b7f--


--===============0684890539360657748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0684890539360657748==--
