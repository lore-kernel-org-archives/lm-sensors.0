From: craighagerman@gmail.com (Craig Hagerman)
Date: Fri, 06 Oct 2006 16:30:15 +0000
Subject: [lm-sensors] lm-sensors used to work... now doesn't
Message-Id: <80d985600610060930v5e4d2b8fyeff7126415c4be3a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have an Asus A8V Deluxe motherboard with Cool 'n' Quiet. Both the
cool and the quiet bit were working fine until recently. I had
installed lm-sensors, run pwmconfig etc (as per
http://ubuntuguide.org/wiki/Dapper). Sensors would report that the CPU
fan was off most of the time and the machine was pretty quiet. Both of
the (2) case fans were
connected to the power supply and not effected or controled by
pwmconfig.

Last weekend I bought a new (3 pin) case fan and attached it to the
motherboard connector. A while after I restarted I noticed that the
CPU fan was no longer spinning down. sensors reports that is is
spinning slower than full speed (could be, I can't be sure) but it
doesn't shut off. Sometimes sensors says that the CPU fan is off, but
it never is.

I reasoned that maybe the fancontrol or pwm or sensors.conf or
something related had to be reconfigured so I set everything up from
start again.

The problem is that pwmconfig no longer sets things up. It doesn't
spin down the CPU fan (nor the case fan) and doesn't seem to see it. I
shut down, disconnected the new fan from the motherboard, put
everythign back as it was and restarted. But it STILL can't see
or spin down the CPU fan. I am getting very frustrated. I have shutdown and
restarted multiple times, and tried adjusting different settings (div
number on the fan for example) and nothing has any effect. Any advice?

Craig

------------------------------------------------------------------------
% sensors

w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.12 V  (min =  +0.29 V, max =  +0.32 V)       ALARM
+12V:     +11.43 V  (min = +10.82 V, max = +13.19 V)
+3.3V:     +3.25 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.99 V  (min =  +4.75 V, max =  +5.25 V)
-12V:      +6.06 V  (min = -10.80 V, max = -13.18 V)       ALARM
V5SB:      +4.97 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +0.02 V  (min =  +2.40 V, max =  +3.60 V)       ALARM
fan1:        0 RPM  (min = 1350000 RPM, div = 1)              ALARM
CPU Fan:  3835 RPM  (min =   -1 RPM, div = 4)              ALARM
fan3:        0 RPM  (min = 84375 RPM, div = 1)              ALARM
M/B Temp:    +35?C  (high =    +2?C, hyst =    +8?C)   sensor thermistor   ALARM
CPU Temp:  +41.5?C  (high =   +80?C, hyst =   +75?C)   sensor thermistor
temp3:     +15.5?C  (high =   +80?C, hyst =   +75?C)   sensor thermistor
vid:      +0.300 V  (VRM Version 8.2)
alarms:
beep_enable:
         Sound alarm enabled

------------------------------------------------------------------------
% pwmconfig            (edited)

Found the following PWM controls:
  9191-0290/pwm1
  9191-0290/pwm2
  9191-0290/pwm3

Found the following fan sensors:
  9191-0290/fan1_input     current speed: 0 ... skipping!
  9191-0290/fan2_input     current speed: 3879 RPM
  9191-0290/fan3_input     current speed: 0 ... skipping!

...
Testing pwm control 9191-0290/pwm2 ...
 9191-0290/fan2_input ... speed was 3879 now 3835
   no correlation

No correlations were detected.
There is either no fan connected to the output of 9191-0290/pwm2,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors.

------------------------------------------------------------------------
Summary of sensors-detect:

Driver `eeprom' (should be inserted):
 Detects correctly:
 * Bus `NVIDIA I2C Device'
   Busdriver `UNKNOWN', I2C address 0x50 (and 0x51 0x52 0x53 0x54
0x55 0x56 0x57)
   Chip `DDC monitor' (confidence: 8)

Driver `not-a-sensor' (should be inserted):
 Detects correctly:
 * Bus `SMBus Via Pro adapter at 0400'
   Busdriver `i2c-viapro', I2C address 0x2f
   Chip `Winbond W83791SD' (confidence: 3)

Driver `smbus-arp' (should be inserted):
 Detects correctly:
 * Bus `SMBus Via Pro adapter at 0400'
   Busdriver `i2c-viapro', I2C address 0x61
   Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)

Driver `w83627hf' (should be inserted):
 Detects correctly:
 * ISA bus address 0x0290 (Busdriver `i2c-isa')
   Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)

------------------------------------------------------------------------


nb. the modules ARE all loaded.

