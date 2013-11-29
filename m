From: Tom Metro <tmetro+lmsensors@gmail.com>
Date: Fri, 29 Nov 2013 23:29:27 +0000
Subject: Re: [lm-sensors] Acer Aspire 8930G laptop and general approach for reverse engineering sensors
Message-Id: <52992357.3040103@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20131118T042931-981@post.gmane.org>
In-Reply-To: <loom.20131118T042931-981@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Guenter Roeck wrote:
> Tom Metro wrote:
>> I did see in the FAQ that there is no database of configurations per
>> motherboard/laptop, but I would expect that with all the temperature
>> monitoring utilities for Windows, one or more of them likely has bundled
>> configuration files that can be used as a reference.
>
> Would be great. Unfortunately, it appears that the creators of the=20
> various Windows utilities are not very enthusiastic about sharing...

While voluntary sharing would be preferable, I was thinking more along
the lines of reverse engineering their configuration files. Then
creating a script to translate them into a collection of sensors.conf
files. (You can't copyright a compilation of factual data, like a phone
book, so there's isn't a legal problem with doing this. Though it might
inspire them to start encrypting the data. Or downloading settings
on-demand from an online service.)

Is anyone aware of a Windows utility that comes with accessible
configuration files covering a wide range of hardware?


>> % sensors
>> acpitz-virtual-0
>> Adapter: Virtual device
>> temp1:        +38.0=B0C
>> temp2:        +48.0=B0C
>> temp3:        +48.0=B0C
>> temp4:        +43.0=B0C
>>[...]
>> I'd like to figure out proper labels for these.
>> I didn't see any guidance in the FAQ on a general approach to reverse
>> engineering the labeling for sensors. There must be a recommended
>> approach for this.
>
> You should be able to find out more by decoding the DSDT.

The Differentiated System Description Table?
https://wiki.archlinux.org/index.php/DSDT

OK, following the procedure here:
https://wiki.archlinux.org/index.php/DSDT#Recompiling_it_yourself

to extract and decompile:

% sudo aptitude install iasl
% sudo su
# cat /sys/firmware/acpi/tables/DSDT > dsdt.dat
# exit
% iasl -d dsdt.dat
Disassembly completed, written to "dsdt.dsl"
% head -22 dsdt.dsl
/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20100528
 *
 * Disassembly of dsdt.dat, Fri Nov 29 16:58:19 2013
 *
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x0000913C (37180)
 *     Revision         0x01 **** ACPI 1.0, no 64-bit math support
 *     Checksum         0x1C
 *     OEM ID           "ACRSYS"
 *     OEM Table ID     "ACRPRDCT"
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "1025"
 *     Compiler Version 0x01000013 (16777235)
 */
DefinitionBlock ("dsdt.aml", "DSDT", 1, "ACRSYS", "ACRPRDCT", 0x00000001)
{
    Name (SP2O, 0x4E)
    Name (SP1O, 0x164E)
[...]


OK, so there is over 9000 lines in that file. Any hints as to what I'm
looking for?

I see some mention of fans and a "ThermalZone":

    Name (DFEC, Zero)
    Scope (_TZ)
    {
        PowerResource (FN00, 0x00, 0x0000)
        {
            Method (_STA, 0, Serialized)
            {
                If (LEqual (DTSF, Zero))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (One)
                }
            }

            Method (_ON, 0, Serialized)
            {
            }

            Method (_OFF, 0, Serialized)
            {
            }
        }

        Device (FAN0)
        {
            Name (_HID, EisaId ("PNP0C0B"))
            Name (_UID, Zero)
            Name (_PR0, Package (0x01)
            {
                FN00
            })
        }

        ThermalZone (TZ00)
        {
            Method (_AC0, 0, Serialized)
            {
                Return (Add (0x0AAC, Multiply (ACTT, 0x0A)))
            }

            Name (_AL0, Package (0x01)
            {
                FAN0
            })
[...]
            Method (_TMP, 0, Serialized)
            {
                Store (CRTP, Local0)
                If (And (Local0, 0x80))
                {
                    Subtract (Local0, 0x0100, Local0)
                }

                Return (Add (0x0AAC, Multiply (Local0, 0x0A)))
            }

            Method (_PSL, 0, Serialized)
            {
                If (CMPE)
                {
                    Return (Package (0x02)
                    {
                        \_PR.CPU0,
                        \_PR.CPU1
                    })
                }

                Return (Package (0x01)
                {
                    \_PR.CPU0
                })
            }

            Method (_TSP, 0, Serialized)
            {
                Return (0x96)
            }
        }

        ThermalZone (TZVR)
        {
            Method (_TMP, 0, Serialized)
            {
                Store (VRTP, Local0)
                If (And (Local0, 0x80))
                {
                    Subtract (Local0, 0x0100, Local0)
                }

                Return (Add (0x0AAC, Multiply (Local0, 0x0A)))
            }

            Method (_CRT, 0, NotSerialized)
            {
                Return (0x0ED0)
            }
        }

        ThermalZone (TZVL)
        {
            Method (_TMP, 0, Serialized)
            {
                Store (VLTP, Local0)
                If (And (Local0, 0x80))
                {
                    Subtract (Local0, 0x0100, Local0)
                }

                Return (Add (0x0AAC, Multiply (Local0, 0x0A)))
            }

            Method (_CRT, 0, NotSerialized)
            {
                Return (0x0ED0)
            }
        }

        ThermalZone (TZ01)
        {
            Method (_CRT, 0, Serialized)
            {
                Return (0x0ED0)
            }

            Method (_TMP, 0, Serialized)
            {
                Store (CLTP, Local0)
                If (And (Local0, 0x80))
                {
                    Subtract (Local0, 0x0100, Local0)
                }

                Return (Add (0x0AAC, Multiply (Local0, 0x0A)))
            }
        }
    }
[...]


Am I supposed to infer what subsystem is being monitored from the
ThermalZone name, like TZVL? And figure out how the correlate that with
one of the 4 sensors returned by the 'acpitz-virtual-0' device?

Any references for how to dig deeper?

According to:
http://acpi.sourceforge.net/documentation/thermal.html

the DSDT declares one or more Thermal Zones, and establishes some rules
for what happens when certain thresholds are reached, like performing a
passive cooling counter measure, such as dropping the CPU clock speed,
or performing an active counter measure, like turning on or speeding up
a fan.

The impression I get is that the DSDT is going to tell me how many zones
I have (which I already know is 4), but not necessarily what each zone
corresponds to. So far I'm not seeing any labels embedded in the code.

So not much more to be found here than what you can learn from poking
around in the /sys representation of the same info:

# find /sys -name 'thermal*'
/sys/devices/system/cpu/cpu0/thermal_throttle
/sys/devices/system/cpu/cpu1/thermal_throttle
/sys/devices/virtual/thermal
/sys/devices/virtual/thermal/thermal_zone0
/sys/devices/virtual/thermal/thermal_zone1
/sys/devices/virtual/thermal/thermal_zone2
/sys/devices/virtual/thermal/thermal_zone3
/sys/devices/LNXSYSTM:00/LNXCPU:00/thermal_cooling
/sys/devices/LNXSYSTM:00/LNXCPU:01/thermal_cooling
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/LNXVIDEO:00/devic=
e:02/thermal_cooling
/sys/devices/LNXSYSTM:00/LNXSYBUS:01/PNP0C0B:00/thermal_cooling
/sys/devices/LNXSYSTM:00/LNXSYBUS:01/LNXTHERM:00/thermal_zone
/sys/devices/LNXSYSTM:00/LNXSYBUS:01/LNXTHERM:01/thermal_zone
/sys/devices/LNXSYSTM:00/LNXSYBUS:01/LNXTHERM:02/thermal_zone
/sys/devices/LNXSYSTM:00/LNXSYBUS:01/LNXTHERM:03/thermal_zone
/sys/bus/acpi/drivers/thermal
/sys/class/thermal
/sys/class/thermal/thermal_zone0
/sys/class/thermal/thermal_zone1
/sys/class/thermal/thermal_zone2
/sys/class/thermal/thermal_zone3
/sys/kernel/debug/ieee80211/phy0/iwlwifi/data/thermal_throttling
/sys/module/thermal

# ls -al /sys/devices/virtual/thermal/thermal_zone0/
total 0
drwxr-xr-x  3 root root    0 Nov 17 19:56 ./
drwxr-xr-x 10 root root    0 Nov 17 19:56 ../
lrwxrwxrwx  1 root root    0 Nov 29 17:28 cdev0 -> ../cooling_device0/
-r--r--r--  1 root root 4096 Nov 29 17:28 cdev0_trip_point
lrwxrwxrwx  1 root root    0 Nov 29 17:28 device ->
  ../../../LNXSYSTM:00/LNXSYBUS:01/LNXTHERM:00/
-rw-r--r--  1 root root 4096 Nov 29 17:28 mode
-rw-r--r--  1 root root 4096 Nov 29 17:28 passive
drwxr-xr-x  2 root root    0 Nov 29 17:26 power/
lrwxrwxrwx  1 root root    0 Nov 17 19:56 subsystem ->
  ../../../../class/thermal/
-r--r--r--  1 root root 4096 Nov 29 17:28 temp
-r--r--r--  1 root root 4096 Nov 29 17:28 trip_point_0_temp
-r--r--r--  1 root root 4096 Nov 29 17:28 trip_point_0_type
-r--r--r--  1 root root 4096 Nov 29 17:28 trip_point_1_temp
-r--r--r--  1 root root 4096 Nov 29 17:28 trip_point_1_type
-r--r--r--  1 root root 4096 Nov 29 17:28 type
-rw-r--r--  1 root root 4096 Nov 28 12:21 uevent


That's not to say nothing can be learned from the DSDT. Hypothetically,
if you had a system with multiple fans, you might be able to infer what
subsystem a Thermal Zone is protecting by which fan gets activated when
thresholds are tripped for that zone. (In combination with an inspection
of the hardware to see which fans are where, and some experimentation
with the ACPI code to manually turn on fans, so you know which physical
fan corresponds to FAN0, etc.) Similarly for passive cooling.

But practically speaking, in a system with only one fan, and the only
passive cooling options being throttling the CPU or GPU, that may not
shed much light.

Still, thanks for the DSDT tip.


One thing I haven't tried yet, is noting the current values of the 4
sensors, then rebooting and going into the BIOS to see if it displays
the current temperatures. If it does, that would be the easiest way to
match them up with labels.

 -Tom


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
