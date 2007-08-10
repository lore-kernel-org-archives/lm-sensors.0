From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Fri, 10 Aug 2007 22:29:36 +0000
Subject: Re: [lm-sensors] 2.6.23-rc1 regression: hwmon/w83627ehf: wrong fan
Message-Id: <46BCE6D0.7060300@s5r6.in-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B5B290.4040907@s5r6.in-berlin.de>	<20070805162141.GI6221@jupiter.solarsys.private>	<46B6053E.2050708@s5r6.in-berlin.de> <20070810230831.59cbc50f@hyperion.delvare>
In-Reply-To: <20070810230831.59cbc50f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Jean Delvare wrote:
> I just tried 2.6.23-rc2 on a system where I use the w83627ehf hardware
> monitoring driver, and was not able to reproduce the problem you
> described. Fan speeds are reported properly for me. Which I kind of
> expected, as I tested all my w83627ehf patches on this system before
> submitting them.

Thanks that you are still after it.  I was busy with other stuff the
whole week, hence no git bisect result from me yet.

> Please try using sensors instead of ksensors, and confirm that the
> behavior is the same. I'd like to rule out a problem in ksensors
> itself. sensors will also report the fan divs, this is a useful
> information given the problem you have.

# sensors
w83627ehf-isa-0290
Adapter: ISA adapter
VCore:     +0.95 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:      +12.30 V  (min =3D  +1.64 V, max =3D  +3.22 V) ALARM
AVCC:      +3.28 V  (min =3D  +1.89 V, max =3D  +1.94 V) ALARM
3VCC:      +3.26 V  (min =3D  +0.18 V, max =3D  +0.72 V) ALARM
in4:       +1.58 V  (min =3D  +0.57 V, max =3D  +0.90 V) ALARM
in5:       +1.70 V  (min =3D  +0.41 V, max =3D  +1.19 V) ALARM
in6:       +3.43 V  (min =3D  +0.31 V, max =3D  +3.05 V) ALARM
VSB:       +3.25 V  (min =3D  +0.37 V, max =3D  +3.01 V) ALARM
VBAT:      +3.18 V  (min =3D  +3.94 V, max =3D  +0.74 V) ALARM
in9:       +1.88 V  (min =3D  +0.79 V, max =3D  +1.40 V) ALARM
Case Fan:    0 RPM  (min =3D  753 RPM, div =3D 128) ALARM
CPU Fan:    88 RPM  (min =3D  659 RPM, div =3D 64) ALARM
Aux Fan:     0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
fan5:        0 RPM  (min =3D  753 RPM, div =3D 128) ALARM
Sys Temp:    +44 C  (high =3D    -5 C, hyst =3D   -34 C)   ALARM
CPU Temp:  +38.0 C  (high =3D +80.0 C, hyst =3D +75.0 C)
AUX Temp:  +43.5 C  (high =3D +80.0 C, hyst =3D +75.0 C)

coretemp-isa-0000
Adapter: ISA adapter

coretemp-isa-0001
Adapter: ISA adapter

(The aux fan and fan5 are not connected.)

> Your original post suggests that the fan speed is supposed to change
> depending on the system load? Or temperature? Please describe the
> mechanism used to achieve this. Could it be that this mechanism isn't
> working properly, and the reported (low) speeds are actually true?

The motherboard controls the CPU fan and I believe also the case fan,
probably based on temperatures.  (The manual is buried somewhere and
MSI's download site is down right in this moment.)

The low speeds or the dividers incorrect.  I'll reboot in a minute into
2.6.22(-rc5)  and post the "sensors" output.

> What fan inputs are used by your CPU and system fans? "sensors
> -c /dev/null" will tell.

...
fan1:      484 RPM  (min =3D 12053 RPM, div =3D 16) ALARM
fan2:       89 RPM  (min =3D  659 RPM, div =3D 64) ALARM
fan3:        0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
fan5:        0 RPM  (min =3D 1506 RPM, div =3D 128) ALARM
...

Hmm, interesting.  When I now re-run sensors I get
...
Case Fan:  484 RPM  (min =3D 12053 RPM, div =3D 16) ALARM
CPU Fan:    89 RPM  (min =3D  659 RPM, div =3D 64) ALARM
Aux Fan:     0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
fan5:        0 RPM  (min =3D 1506 RPM, div =3D 128) ALARM
...

(I'm still in 2.6.23-rc2.  Ksensors picked the 484 RPM of the case fan
up too, and that's most certainly the correct speed.  Just the CPU fan's
speed is still wrong; or rather its divider should be 16 rather than 64.)

> Other than that, I can only ask for the same things Mark already
> suggested: compile with HWMON debugging and provide the logs (this will
> show what fan div the driver is trying to select), and try bisecting
> using git to find out which patch exactly caused the problem.

How comes the divider of one of the fans changed from one minute to the
other?

FWIW, the ``chip "w83627ehf-*"=B4=B4 section in Gentoo's /etc/sensors.conf
provides only labels for fan{1,2,3}. It is titled
# Winbond W83627EHF configuration originally contributed by Leon Moonen
# This is for an Asus P5P800, voltages for A8V-E SE.

Should I hardwire correct dividers or pulse per rev in sensors.conf or
is the driver supposed to work the correct dividers out --- like it did
before 2.6.23-rc?
--=20
Stefan Richter
-=3D=3D=3D-=3D-=3D=3D =3D--- -=3D-=3D
http://arcgraph.de/sr/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
