From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Feb 2014 02:00:38 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <53041046.3030207@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 02/18/2014 05:23 PM, ianp wrote:
> Hi,
>
> I'm running Xubuntu 12.04.4 on an Asrock G41C-GS board.
>
>
> $ uname -a
>
> Linux box 3.12-11.dmz.1-liquorix-amd64 #1 ZEN SMP PREEMPT Sat Feb 15 21:4=
8:42 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
>
> $ apt-show-versions |grep sensors
> libsensors4/precise uptodate 1:3.3.1-2ubuntu1
> lm-sensors/precise uptodate 1:3.3.1-2ubuntu1
>
> I found out that this sensor, W83627DHG-P, shows a single voltage monitor=
 for +5V and +12V on in4, at least on this board, using this configuration:
>
> chip "w83627dhg-*"
> ### Voltages
>     label  in0  "Vcore"
>     ignore in1
>     label  in2  "AVcc"
>     #ignore in3  # "+3.3V"
>     #label  in4  "+5V" # uncomment for +5V monitoring
>     label  in4  "+12V" # uncomment for +12V monitoring
>     ignore in5
>     label  in6  "Vram"
>     label  in7  "3Vsb"
>     #ignore in8  # "Vbat"
>     ignore cpu0_vid
>
>     #compute  in4  @*((20/10)+1), @/((20/10)+1) # uncomment for +5V monit=
oring
>     compute  in4  @*((60/10)+1), @/((60/10)+1) # uncomment for +12V monit=
oring
>
>     set in0_min 1.125 * 0.95
>     set in0_max 1.125 * 1.05
>     set in2_min 3.3 * 0.95
>     set in2_max 3.3 * 1.05
>     #set in4_min   5 * 0.95 # uncomment for +5V monitoring
>     #set in4_max   5 * 1.05 # uncomment for +5V monitoring
>     set in4_min  12 * 0.95 # uncomment for +12V monitoring
>     set in4_max  12 * 1.05 # uncomment for +12V monitoring
>     set in6_min 1.8
>     set in6_max 1.9
> ### Temperatures
>     label  temp1  "N/B Temp"
>     label  temp2  "CPU Temp"
>     ignore temp3
>
>     set temp1_max 60
>     set temp1_max_hyst 55
>     set temp2_max 60
>     set temp2_max_hyst 55
> ### Fans
>     label  fan1  "CHA Fan"
>     label  fan2  "CPU Fan"
>     label  fan3  "PSU Fan"
>     ignore fan4
>     ignore fan5
>
>     set fan1_min 0
>     set fan2_min 900
>     set fan3_min 0
>
> $ sensors
> w83627dhg-isa-0290
> Adapter: ISA adapter
> Vcore:        +1.11 V  (min =3D  +1.07 V, max =3D  +1.18 V)
> AVcc:         +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:        +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +12V:        +11.59 V  (min =3D +11.42 V, max =3D +12.60 V)
> Vram:         +1.90 V  (min =3D  +1.80 V, max =3D  +1.90 V)
> 3Vsb:         +3.50 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:         +3.33 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> CHA Fan:        0 RPM  (min =3D    0 RPM, div =3D 128)
> CPU Fan:     1704 RPM  (min =3D  902 RPM, div =3D 8)
> PSU Fan:        0 RPM  (min =3D    0 RPM, div =3D 128)
> N/B Temp:     +41.0=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor=
 =3D thermistor
> CPU Temp:     +37.5=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor=
 =3D thermistor
>
>
> Uncommenting and commenting the relevant lines for +5V monitoring, I get:
>
> $ sensors
> w83627dhg-isa-0290
> Adapter: ISA adapter
> Vcore:        +1.11 V  (min =3D  +1.07 V, max =3D  +1.18 V)
> AVcc:         +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:        +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +5V:          +4.97 V  (min =3D  +6.12 V, max =3D  +6.12 V)  ALARM
> Vram:         +1.90 V  (min =3D  +1.80 V, max =3D  +1.90 V)
> 3Vsb:         +3.50 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:         +3.33 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> CHA Fan:        0 RPM  (min =3D    0 RPM, div =3D 128)
> CPU Fan:     1654 RPM  (min =3D  902 RPM, div =3D 8)
> PSU Fan:        0 RPM  (min =3D    0 RPM, div =3D 128)
> N/B Temp:     +41.0=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor=
 =3D thermistor
> CPU Temp:     +37.5=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor=
 =3D thermistor
> intrusion0:  ALARM
>
>
> To corroborate this behavior, I dumped the monitoring data in Windows usi=
ng hwmonitor v1.24
>
> CPUID HWMonitor Report
> -------------------------------------------------------------------------
>
> Binaries
> -------------------------------------------------------------------------
>
> HWMonitor version    1.2.4.0
>
> Monitoring
> -------------------------------------------------------------------------
>
> Mainboard Model        G41C-GS (0x000001B6 - 0x004E5333)
>
> LPCIO
> -------------------------------------------------------------------------
>
> LPCIO Vendor        Winbond
> LPCIO Model        W83627DHG-P
> LPCIO Vendor ID        0x5CA3
> LPCIO Chip ID        0xB0
> LPCIO Revision ID    0x73
> Config Mode I/O address    0x2E
> Config Mode LDN        0xB
> Config Mode registers
>          00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
>      00    FF FF FF FF FF FF FF 0B FF FF FF FF FF FF FF FF
>      10    FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
>      20    B0 73 FF 00 44 00 00 FF 70 00 00 00 D2 21 00 FF
>      30    01 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
>      40    FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
>      50    FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
>      60    02 90 FF FF FF FF FF FF FF FF FF FF FF FF FF FF
>      70    00 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
> Register space        LPC, base address =3D 0x0290
>
>
> Hardware Monitors
> -------------------------------------------------------------------------
>
> Hardware monitor    Winbond W83627DHG
>      Voltage 0    1.11 Volts [0x8B] (CPU VCORE)
>      Voltage 1    0.69 Volts [0x56] (VIN1)
>      Voltage 2    3.30 Volts [0xCE] (+3.3V)
>      Voltage 3    4.97 Volts [0xCF] (+5V)
>      Voltage 4    11.54 Volts [0xCF] (+12V)
>      Voltage 5    1.69 Volts [0xD3] (VIN5)
>      Voltage 6    1.90 Volts [0xED] (VIN6)
>      Temperature 0    40=B0C (104=B0F) [0x28] (SYSTIN)
>      Temperature 1    39=B0C (101=B0F) [0x4D] (CPUTIN)
>      Temperature 2    46=B0C (113=B0F) [0x5B] (AUXTIN)
>      Fan 1        2250 RPM [0x4B] (CPUFANIN0)
> Hardware registers
> Register space        LPC, base address =3D 0x0290
> bank 0
>          00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
>      00    04 FF 04 B3 11 00 37 20 01 B3 01 FF 3C 3C 0A 0A
>      10    04 FF 10 00 00 01 01 3C 43 07 00 00 2D FF FF DA
>      20    8B 56 CE CF CF D3 ED 28 FF 4B FF DA 00 B4 72 E3
>      30    BA E3 BA EA 50 2B 0B EF D8 37 32 FF BB FF 05 FF
>      40    03 02 14 FF FF 00 3F F5 2D 00 00 C4 90 95 00 A3
>      50    FF FF 00 FF FF FF 00 80 C1 7F FF FF 19 A0 00 05
>      60    04 7F 40 00 01 01 3C FF 01 FF 01 FF FF FF FF 00
>      70    00 00 00 00 00 0E 7F 7F 7F 7F 7F 7F 00 28 FF FF
>      80    04 FF 04 B3 11 00 37 20 01 B3 01 FF 3C 3C 0A 0A
>      90    04 FF 10 00 00 01 01 3C 43 07 00 00 2D FF FF DA
>      A0    8B 56 CE CF CF D3 ED 28 FF 4B FF DA 00 B4 72 E3
>      B0    BA E3 BA EA 50 2B 0B EF D8 37 32 FF BB FF 05 FF
>      C0    03 00 10 FF FF 00 3F F5 2D 00 00 C4 90 95 00 A3
>      D0    FF FF 00 FF FF FF 00 80 C1 7F FF FF 19 A0 00 05
>      E0    04 7F 40 00 01 01 3C FF 01 FF 01 FF FF FF FF 00
>      F0    00 00 00 00 00 0E 7F 7F 7F 7F 7F 7F 00 28 FF FF
> bank 1
>      50    26 80 00 32 00 37 01 20 00 00 00 00 00 00 0E FF
> bank 2
>      50    2D 80 00 4B 00 50 1E 02 FF FF FF FF FF FF FF FF
> bank 3
>      50    06 07 07 00 04 02 02 01 06 00 00 00 7C 00 00 00
> bank 4
>      50    3A 13 FF 00 00 00 00 08 2A 02 14 AA 09 60 20 7F
>
>
>
> As you can see from above, +5V and +12V share the same address (0xCF).
>

That is not the same address, it is the same raw value.
The voltage registers are at address 0x20 .. 0x26 in above table.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
