From: Kenneth Almquist <kalmquist1@hotmail.com>
Date: Wed, 03 Sep 2014 22:27:32 +0000
Subject: [lm-sensors] ASUS Vanguard B85 motherboard
Message-Id: <BAY173-W5229949B8EF8EE027B698E9FC40@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

# This is an incomplete configuration file for the ASUS Vanguard B85
# motherboard.=A0 The remainder of this comment explains what I've done
# so far.=A0 Linux kernel version 3.13.0, lm-sensors version 3.3.4.
#
#
# 1.=A0 Available sensors
#
# 1.1.=A0 Nuvoton NCT 6791D Super IO chip
#
#=A0 This chip requires the nct6775 driver, which may be loaded into the
#=A0 kernel with the command:
#=A0=A0=A0=A0=A0=A0 modprobe -v nct6775
#
#=A0 This configuration file is currently limited to identifying some (but
#=A0 not all) of the sensor information available from the Nuvoton chip.
#
# 1.2.=A0 Intel thermal sensors
#
#=A0 The Intel CPU's contain thermal sensors.
#
# 1.3.=A0 Other sensors
#
#=A0 There are several voltage values that the BIOS reports, but which I
#=A0 haven't identified the sensor for.=A0 In particular, the BIOS reports
#=A0 the memory voltage and the PCH voltage.=A0 I've tried varying both of
#=A0 these, and none of the voltage readings from the Nuvoton chip changed.
#
#=A0 Here is a list of all of the chips on the board which have more than
#=A0 eight pins:
#=A0=A0=A0=A0=A0=A0 ASMedia ASM1074 - USB 3.0 hub
#=A0=A0=A0=A0=A0=A0 ASMedia ASM1803 - PCIe to PCI bridge
#=A0=A0=A0=A0=A0=A0 ASMedia ASM1442K - HDMI/DVI output (level shifting)
#=A0=A0=A0=A0=A0=A0 Asus TPU KR37290 - Asus TurboV Processing Unit
#=A0=A0=A0=A0=A0=A0 Intel B85 - Intel platform controller hub
#=A0=A0=A0=A0=A0=A0 Intel WG1217V - Gigabit ethernet
#=A0=A0=A0=A0=A0=A0 Nuvoton NCT 6791D - Super IO
#=A0=A0=A0=A0=A0=A0 Realtek ALC887 - Audio
#
#=A0 Looking over this list, I can see two possibilities:
#
#=A0=A0 1)=A0 The NCT 6791D is an updated version of the NCT 6775.=A0 Perha=
ps it
#=A0=A0=A0=A0=A0=A0 has the ability to measure more voltage values than the=
 NCT 6775
#=A0=A0=A0=A0=A0=A0 but the Linux driver hasn't been updated to display the=
 additional
#=A0=A0=A0=A0=A0=A0 voltages.
#
#=A0=A0 2)=A0 The ASUS TPU chip might contains some voltage sensors.
#
#=A0 Until someone figures this out, we won't be able to display complete
#=A0 voltage information for this board.
#
#
# 2.=A0 Voltages
#
# 2.1=A0 Power supply voltages
#
#=A0 The entries for the three main power supply voltages (+12V, +5V, and +=
3.3V)
#=A0 are based on the ASUS H87-Pro configuration file.=A0 The +5V and +12V =
are
#=A0 a good match for the values I see in BIOS (in particular I've verified
#=A0 that these have not been reversed).=A0 I normally get identical readin=
gs
#=A0 for in2 and in3, so I have no way to verify that the +3.3V line is in3
#=A0 rather than in2.
#
# 2.2=A0 CPU Vcc
#
#=A0 Vcc is the voltage going into the processor's integrated voltage regul=
ator.
#=A0 I verified this by lowering the value in BIOS.
#
# 2.3=A0 Integrated voltage regulator output
#
#=A0 I must confess that I have no idea how the Nuvoton chip gets these val=
ues.
#=A0 I initially assumed that the CPU pinout must include sense pins for th=
ese
#=A0 voltages, but I looked at the Intel data sheet and couldn't find any s=
uch
#=A0 pins.=A0 Never the less, the values seem correct.
#
#=A0 Each core, as well as the integrated GPU, has a separate voltage rail.
#=A0 These values will read zero when the corresponding part is idle.=A0 You
#=A0 may see small non-zero values; my assumption is that these result from
#=A0 the measurement being taken just as the rail is being turned on or off.
#
#=A0 The system agent connects the memory controller and the PCIe controller
#=A0 to the L3 cache and the CPU cores.=A0 I've labeled its voltage rail
#=A0 "sys agent".
#
#=A0 The voltage used for digital input/output pins (except for the memory)
#=A0 has been labeled "digital I/O"
#
# 2.4=A0 Unidentified voltages
#
#=A0 for in2 see section 2.1 above
#=A0 in5 reads 1.992 or occassionally 1.984
#=A0 in7 reads 3.456
#=A0 in8 reads 3.376
#
# 3. Fans
#
#=A0 The board supports a CPU fan and four chassis fans.=A0 The Nuvoton chip
#=A0 reports the speed of all of them (assuming that the fans provide a
#=A0 tachometer signal).
#
#=A0 The connectors for two of the chassis fans are along the bottom of the
#=A0 board; the left hand one is fan 4 and the right hand one is fan 1.=A0 =
The
#=A0 connectors for the remaining two chassis fans are on the right hand
#=A0 side of the board above the 24 pin power connector; the upper one is
#=A0 fan 3 and the lower one is fan 2.
#
# 4.=A0 Temperatures
#
# 4.1.=A0 acpitz driver
#
#=A0 This uses ACPI to print out two temperature values.=A0 On my system the
#=A0 values are always 27.8 and 29.8 degrees C, respectively, so I doubt
#=A0 they are measuring anything at all.
#
# 4.2.=A0 coretemp driver
#
#=A0 This reports temperatures from the CPU internal temperature sensors.
#=A0 This may require loading the coretemp module.=A0 It appears to work
#=A0 fine without the need for any configuration file entries.
#
# 4.3.=A0 Temperature values from Nuvoton chip
#
#=A0 These are assigned names by the device driver.=A0=20
#
#=A0 SYSTIN reports the value of a temperature sensor located near the B85
#=A0 PCH chip.=A0 The BIOS labels this value "MB temperature."=A0 Resolutio=
n is
#=A0 1 degree C.
#
#=A0 CPUTIN presumably reports a temperature measurement underneath the CPU
#=A0 socket.=A0 It thus reflects CPU temperatures, but with a lot of lag.
#=A0 Resolution is 0.5 degrees C.
#
#=A0 "PECI Agent 0" is presumably the CPU temperature as reported by the via
#=A0 the PECI bus.=A0 This value increases or decreases temporarily when th=
e CPU
#=A0 temperatures changes, but as long as the CPU temperature is relatively
#=A0 constant this value is close to CPUTIN.
#
#=A0 The remaining temperature=20
#
#=A0 AUXTIN0, AUXTIN1, and AUXTIN3 vary widely, suggesting that if they are
#=A0 measuring temperature values, the values require scaling.=A0 AUXTIN2 h=
as
#=A0 been fixed at 36 degrees C on my system.
#
#=A0 PCH_CHIP_TEMP, PCH_CPU_TEMP, and PCH_CHIP_CPU_MAX_TEMP are all fixed at
#=A0 zero on my system.
#
# 4.4.=A0 Sample temperature values
#
#=A0 To illustrate the behavior of the PECI and CPUTIN temperature values,
#=A0 I've included an excerpt from my temperature readings.=A0 The first co=
lumn
#=A0 in the table below shows the temperature of the CPU (the "Physical id =
0"
#=A0 value).=A0 The remaining columns show the "PECI Agent 0," CPUTIN, and =
SYSTIN
#=A0 values.=A0 Readings were taken at three second intervals, with an ambi=
ent
#=A0 temperature of 23 degrees C.
#
#=A0=A0=A0=A0=A0=A0 CPU=A0=A0=A0 PECI=A0 CPUTIN SYSTIN
#=A0=A0=A0=A0=A0=A0 27.0=A0=A0 28.0=A0=A0 28.0=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 27.0=A0=A0 28.0=A0=A0 28.0=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 35.0=A0=A0 37.5=A0=A0 28.0=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 37.0=A0=A0 36.0=A0=A0 28.0=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 37.0=A0=A0 34.0=A0=A0 28.0=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 36.0=A0=A0 32.0=A0=A0 28.5=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 37.0=A0=A0 28.5=A0=A0 28.5=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 37.0=A0=A0 27.5=A0=A0 28.5=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 37.0=A0=A0 29.0=A0=A0 28.5=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 40.0=A0=A0 30.0=A0=A0 29.0=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 40.0=A0=A0 29.5=A0=A0 29.0=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 39.0=A0=A0 29.5=A0=A0 29.0=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 39.0=A0=A0 29.5=A0=A0 29.5=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 38.0=A0=A0 29.5=A0=A0 29.5=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 29.0=A0=A0 19.5=A0=A0 29.5=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 28.0=A0=A0 21.5=A0=A0 29.5=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 29.0=A0=A0 23.5=A0=A0 29.5=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 28.0=A0=A0 26.0=A0=A0 29.5=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 28.0=A0=A0 28.0=A0=A0 29.0=A0=A0 36.0
#=A0=A0=A0=A0=A0=A0 28.0=A0=A0 29.0=A0=A0 29.0=A0=A0 36.0



chip "nct6791-*"

label in4 "+12V"
=A0 compute=A0 in4=A0 @ * 12, @ / 12
=A0 set in4_min 12 * 0.95
=A0 set in4_max 12 * 1.05

label in1 "+5V"
=A0 compute in1 @ * 5, @ / 5
=A0 set in1_min 5 * 0.95
=A0 set in1_max 5 * 1.05

label in3 "+3.3V"
=A0 set in3_min 3.3 * 0.95
=A0 set in3_max 3.3 * 1.05

label in0 "CPU Vcc"
=A0 compute in0=A0 @ * 2, @ / 2

label in14 "core 0"
=A0 compute in14 @ * 2, @ / 2

label in13 "core 1"
=A0 compute in13 @ * 2, @ / 2

label in12 "core 2"
=A0 compute in12 @ * 2, @ / 2

label in6 "core 3"
=A0 compute in6 @ * 2, @ / 2

label in10 "GPU"

label in11 "sys agent"

label in9 "digital I/O"

label fan2 "CPU fan"
label fan1 "Fan 1"
label fan3 "Fan 2"
label fan4 "Fan 3"
label fan5 "Fan 4"


 		 	   		 =20
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
