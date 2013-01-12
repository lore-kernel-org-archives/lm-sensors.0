From: Andreas Mohr <andi@lisas.de>
Date: Sat, 12 Jan 2013 11:55:03 +0000
Subject: [lm-sensors] [Configurations] EPoX 8K5A2+ , my current sensors3.conf
Message-Id: <20130112115503.GA21719@rhlx01.hs-esslingen.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

see my current initial config for this mainboard attached
(usage: simply place this file into /etc/sensors.d/ directory,
and read its content for further steps).

Awaiting addition into lm-sensors.org's
Configurations database and/or further suggestions.

Thanks!

Andreas Mohr

-- 
GNU/Linux. It's not the software that's free, it's you.

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="epox_8k5a2plus.conf"

# lm_sensors configuration file for the EPoX 8K5A2+ motherboard
# 2013-01-11, Andreas Mohr <andim2@users.sf.net>
# Comments welcome!
#
# First version -
# not yet fully confident about scaling factors,
# slight remaining possibility of a labeling error,
# mild testing only.


# User ga.rp on "KT333 board Kaufempfehlung"
#   http://www.forum-3dcenter.org/vbulletin/archive/index.php/t-101395.html
# says that according to EPoX, 8K5A2+ uses internal Athlon diode
# for *internal monitoring* by overheating protection circuit only,
# i.e. only the external socket diode is readable by sensors.
# sensors-detect tries to detect an LM84, but it is not successful,
# discards this sensor due to negative temperature values.
# Manually loading adm1021 module and then running "sensors"
# will display this negative output.


# Due to ACPI occupying the resource range of the W83697HF,
# in newer kernels enabling loading of w83627hf module requires the
# acpi_enforce_resources=lax kernel parameter (warning, dangerous -
# however I haven't observed any problems yet).
# Not doing so will fail with following dmesg log:
#   ACPI Warning: 0x00000295-0x00000296 SystemIO conflicts with Region \IP__ 1 (20121018/utaddress-251)
#   ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver


chip "w83697hf-isa-*"

# Labels used by (sorting temp/RPM/others):
# BIOS Health screen:
#   System|CPU|CPU|CHASSIS|Vcore|Vagp|+ 5 V|+12 # V|Vio|VDIMM|VBAT(V)|VSB(V)
# Bootup screen:
#   Chassis|CPU|Vio|Vcore|Vdimm|Vagp|Vbat|12V|5VSB
# Since they are different, decide to use the common EE convention of
# lower-case attributes.


# Temperature
    # external socket diode (not the Athlon XP internal diode)
    label temp1       "CPU"
    label temp2       "System"

# Fans
    label fan1        "CPU"
    label fan2        "Chassis"
    ignore fan2 # TODO_USER comment this if you have a chassis fan

# Voltage
    label in0         "Vcore"
    label in1         "_in1" # WTH is this?? Not shown in output...
    label in2         "Vagp"
    label in3         "+5V" # 5V (verified via USB-side load test)
    label in4         "+12V" # 12V (verified via internal-fed TFT supply)
    label in5         "5VSB"
    label in6         "Vdimm"
    label in7         "Vio"
    label in8         "Vbat"

# Some known 8K5A2+ voltage values (important for ADC scaling, see
# http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling ):
# Vcore 1.64/1.97; Vagp 1.53/1.55; Vio 3.23/3.31; Vbat 3.08/3.10
# Vdimm 2.59; 5Vsb 5.40/5.48
# +5V 4.94/4.97/4.99/5.02; +12V 11.67/12.09/12.16 (--> step granularity ~70mV or lower)

# measured voltage (vs. value): 12.24 (3.17)
# measured voltage (vs. value): 5.19 (3.01)

# lm-sensors.org says W83697HF has 16mV per LSB.
# Not ultimately sure about these experimentally determined
# scaling factors, but so far they seem probable.
# Let's assume scaling of +5V and 5Vsb is identical
# (after all why would they choose a different factor
# for same source voltage values and same ADC target range?),
# despite 5Vsb then ending up at questionably high levels
# in my case.
compute in3 @ * (80/48), @ / (80/48) # 3 steps
compute in4 @ * (800/208), @ / (800/208) # 13 steps
compute in5 @ * (80/48), @ / (80/48) # 3 steps

set temp1_max 70

# Vbat ranges/values not adopted from Debian sensors3.conf,
# since e.g. http://de.wikipedia.org/wiki/PC-Netzteil says
# that tolerance is 5% rather than 10%.

# Vcore (obviously CPU-specific --> TODO_USER ADJUST THIS
# for better monitoring precision)
# 1.4 is minimum Vcore setting as supported by unmodded 8K5A2+
# 2.2 is maximum Vcore setting as supported by 8K5A2+
set in0_min 1.4
set in0_max 2.2

# Vagp
set in2_min  1.5 * 0.90
set in2_max  1.7 # some recommend to use 1.7V?

# +5V
set in3_min  5.0 * 0.95
set in3_max  5.0 * 1.05

# +12V
set in4_min 12.0 * 0.95
set in4_max 12.0 * 1.05

# 5Vsb
set in5_min  5.0 * 0.95
# My 5Vsb is at 5.48V BIOS and 5.55V lm-sensors.
# Thus override the standard 5% tolerance to remain ALARM-free in
# "normal" operation. Still rather troubling issue, needs review.
# TODO_USER disable this improper tweak as needed.
#set in5_max  5.0 * 1.05
set in5_max  5.0 * 1.15

# Vdimm. Let's assume 10% tolerance (DDR 2.5V).
set in6_min  2.5 * 0.9
set in6_max  2.5 * 1.1
# Vio (3.3V). Standard says 5% tolerance.
set in7_min  3.3 * 0.95
set in7_max  3.3 * 1.05

# Vbat. CR2032 (3.0V). Let's assume 10% tolerance.
set in8_min  3.0 * 0.9
set in8_max  3.0 * 1.1

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--jI8keyz6grp/JLjh--
