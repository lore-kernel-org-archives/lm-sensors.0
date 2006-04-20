From: roger@planbit.co.uk (Roger Lucas)
Date: Thu, 20 Apr 2006 23:53:58 +0000
Subject: [lm-sensors] Kernel fault from ACPI when using W83627EHG on 2.6.15
Message-Id: <20060420235351.9D72212ED4@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have just been setting up a new system using the Abit LG81 motherboard.
This is a fairly recent mobo with the Intel ICH7 chipset and the w83627ehg
sensor chip (...no uGuru, thank goodness...)

I got everything installed OK using a Debian ISO image I downloaded from the
web which is based around what I believe to be the stock 2.6.15 kernel.

The w83627ehf module was not loaded by default, so I modprobe'd the
"w83627ehf" module and it went in without error.  I installed "lm-sensors"
from the Debian packages (v2.9.1). When I ran "sensors", I got back the
correct speeds for the 3 fans fitted and the system temperatures.
Everything matched the BIOS. =20

When I ran "sensors -s", however, I immediately got a kernel dump.  I
haven't managed to get a proper capture of this, but the errors at the top
were:
	acpi_ps_parse_aml
	acpi_ps_execute_pass
	acpi_ps_execute_method
	acpi_ps_execute_control_method
	acpi_ps_evaluate_by_handle
	acpi_ps_evaluate_relative
	acpi_evaluate_object
	acpi_evalute_integer
	acpi_thermal_get_temperature =09
	acpi_thermal_check
	acpi_acquire_mutex
	...

When I checked the sensors configuration, I found that the high temperature
thresholds were just below what my board was reading (CPU is at about 50
degrees and the PWM at about 45 degrees - not too high, but above the
original thresholds).  When I changed them to much higher values so that
they wouldn't trigger (high=95 deg, hyst=85 deg), the kernel dumps stopped.

I did a bit of a search through the lm-sensors mailing list archives and
found the suggestion to boot with "acpi=3Doff", so I tried it.

Booting with "acpi=3Doff", if I have temperature thresholds that are lower
than the sensors temperatures, and run "sensors -s", I get no kernel faults
but I do get a high-low beeping from the motherboard!  When I change the
sensors.conf file to have higher temperature thresholds so that the alarms
don't trigger, then the beeping from the motherboard stops (and still no
kernel fault).

Although booting with "acpi=3Doff" is a workaround, I would _really_ like to
have ACPI running as it means that the power button on the front of the box
does a controlled shutdown (rather than a hard power-off) if pressed briefly
as well as a few other nice features.

I appreciate that this looks like an ACPI problem, but it seems to be
triggered by the over-temperature from the w83627ehf module, so I thought
that it would be best to check this out first.  Googling for the problem
seems to suggest some kind of device conflict may be occurring, but this was
on a kernel mailing list thread dating back to the 2.6.8.1 kernel in 2004.

Can anyone offer any help on this...
 - Has anyone seen anything similar?
 - Does anyone have a solution that allows me to keep ACPI active?

All help on this is appreciated.

Thanks,

Roger


