From: warp-9.9@usa.net (Leif W)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <002201c49858$32b2f730$0a01a8c0@enterprise>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> ----- Original Message -----=20
> From: "Jean Delvare" <khali@linux-fr.org>
> To: "Leif W" <warp-9.9@usa.net>
> Cc: <sensors@Stimpy.netroedge.com>
> Sent: Saturday, September 11, 2004 15:37
> Subject: Re: Support DB Entry 1770
>

> > <defiant> [2004-09-11@13:54:07] ~ -> modprobe w83781d
> >
> > =3D> /var/log/syslog <=3D
> > Sep 11 13:54:10 defiant kernel: i2c-core: driver w83781d registered.
> > Sep 11 13:54:10 defiant kernel: i2c_adapter i2c-0: found normal isa
> > entry for adapter 9191, addr 0290
> > Sep 11 13:54:10 defiant kernel: i2c_adapter i2c-0: Detection of
> > w83781d chip failed at step 2 (0x61 !=3D 0x60)
>
> Odd. I wonder how this is even possible. What's more, I made the error
> on-fatal so I would have expected some more messages after that. No
> extra message means that either a critical failure occured (out of
> memory or similar), or the end of the detection was fine - but then
why
> would sensors not show the chip?

Shouldn't be out of physical memory.  :-)

<SHELL>

<defiant> [2004-09-11@15:54:55] ~ -> free
             total       used       free     shared    buffers
cached
Mem:        776560      98508     678052          0       5660
54232
-/+ buffers/cache:      38616     737944
Swap:       124980          0     124980
<defiant> [2004-09-11@15:55:06] ~ -> df /dev/shm
Filesystem           1K-blocks      Used Available Use% Mounted on
tmpfs                   131072        12    131060   1% /dev/shm
<defiant> [2004-09-11@15:55:10] ~ ->

</SHELL>

> An even more verbose patch is attached, please try.

I'll try this momentarily.  Results below.

<SHELL>

<defiant> [2004-09-11@19:27:38] ~ -> modprobe w83781d

=3D> /var/log/syslog <=3D
Sep 11 19:27:45 defiant kernel: i2c-core: driver w83781d registered.
Sep 11 19:27:45 defiant kernel: i2c_adapter i2c-0: found normal isa
entry for adapter 9191, addr 0290
Sep 11 19:27:45 defiant kernel: i2c_adapter i2c-0: Detection of w83781d
chip failed at step 2 (0x61 !=3D 0x60 at 0x295)

</SHELL>

> Please double-check. The second line should read "found force
parameter"
> instead of "found normal isa entry". If it doesn't, this would mean
that
> the driver didn't understand your request. Either you didn't formulate
> it correctly, or this has to be another bug in the i2c subsystem.

The rest of these tests were done with patch "2" not "3", but the
results are exactly the same.  Ok, I see the "found force" in
"/var/log/syslog" and "/var/log/debug".  But there's "Ignoring 'force'"
in  "/var/log/syslog" and "/var/log/messages".  It is looking on adapter
0 not 9191 as I specified.  And "sensors" reports "No sensors found!".

<SHELL>

<defiant> [2004-09-11@15:45:02] ~ -> modprobe w83781d force=9191,0x290

=3D> /var/log/syslog <=3D
Sep 11 15:45:30 defiant kernel: i2c-core: driver w83781d registered.
Sep 11 15:45:30 defiant kernel: i2c_adapter i2c-0: found force parameter
for adapter 9191, addr 0290
Sep 11 15:45:30 defiant kernel:  : Ignoring 'force' parameter for
unknown chip atadapter 0, address 0x290

=3D> /var/log/messages <=3D
Sep 11 15:45:30 defiant kernel:  : Ignoring 'force' parameter for
unknown chip atadapter 0, address 0x290

=3D> /var/log/debug <=3D
Sep 11 15:45:30 defiant kernel: i2c-core: driver w83781d registered.
Sep 11 15:45:30 defiant kernel: i2c_adapter i2c-0: found force parameter
for adapter 9191, addr 0290

</SHELL>

The option below is the only one that seems to get this to work, and it
appears to work fine when forced (i.e. "sensors" reports correct data).

<SHELL>

<defiant> [2004-09-11@15:50:42] ~ -> modprobe w83781d
force_w83781d=9191,0x290
<defiant> [2004-09-11@15:50:48] ~ ->
=3D> /var/log/syslog <=3D
Sep 11 15:50:48 defiant kernel: i2c-core: driver w83781d registered.
Sep 11 15:50:48 defiant kernel: i2c_adapter i2c-0: found force parameter
for adapter 9191, addr 0290
Sep 11 15:50:48 defiant kernel: i2c_adapter i2c-0: client [w83781d]
registered to adapter
Sep 11 15:50:48 defiant kernel: registering 0-0290

=3D> /var/log/debug <=3D
Sep 11 15:50:48 defiant kernel: i2c-core: driver w83781d registered.
Sep 11 15:50:48 defiant kernel: i2c_adapter i2c-0: found force parameter
for adapter 9191, addr 0290
Sep 11 15:50:48 defiant kernel: i2c_adapter i2c-0: client [w83781d]
registered to adapter
Sep 11 15:50:48 defiant kernel: registering 0-0290

<defiant> [2004-09-11@15:50:52] ~ -> sensors
w83781d-isa-0290
Adapter: ISA adapter
VCore 1:   +2.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)       ALARM
VCore 2:   +2.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)       ALARM
+3.3V:     +3.57 V  (min =3D  +2.82 V, max =3D  +3.79 V)       ALARM
+5V:       +4.87 V  (min =3D  +0.97 V, max =3D  +3.44 V)       ALARM
+12V:     +12.10 V  (min =3D +11.80 V, max =3D  +0.00 V)
-12V:     -12.02 V  (min =3D  -0.45 V, max =3D  -2.00 V)
-5V:       -4.89 V  (min =3D  -0.00 V, max =3D  -0.00 V)
CPU Fan:  3708 RPM  (min =3D 21093 RPM, div =3D 2)
M/B Temp:    +29 C  (high =3D   -64 C, hyst =3D   -95 C)
CPU Temp:   +0.0 C  (high =3D    +0 C, hyst =3D    +0 C)
vid:      +3.500 V
alarms:
beep_enable:
          Sound alarm disabled

<defiant> [2004-09-11@15:50:54] ~ ->
=3D> /var/log/syslog <=3D
Sep 11 15:50:54 defiant kernel: Starting device update

=3D> /var/log/debug <=3D
Sep 11 15:50:54 defiant kernel: Starting device update

</SHELL>


