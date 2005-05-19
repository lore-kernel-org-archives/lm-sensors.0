From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: RFC adm9240 and libsensors: fan_div
Message-Id: <g13p51psjut1f36ek09a3p96e9jl9tl6aa@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Recently I wrote about needing a patch to libsensors for it to 
work with new adm9240 driver.  

On testing with lm_sensors 2.9.1 I added read-only accessors to 
adm9240 fan_div, as this will break less user-space scripts and 
stuff.

sensors vs my test direct sysfs access, with all alarms set:

peetoo:0-002d$ sensors
adm9240-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 7000
2.5V:      +1.51 V  (min =  +1.37 V, max =  +0.00 V)   ALARM
Vccp1:     +2.01 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
3.3V:      +3.35 V  (min =  +3.13 V, max =  +0.00 V)   ALARM
5V:        +5.18 V  (min =  +4.74 V, max =  +0.00 V)   ALARM
12V:      +12.25 V  (min = +11.38 V, max =  +0.00 V)   ALARM
Vccp2:     +2.59 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
fan1:     4116 RPM  (min = 5973 RPM, div = 2)          ALARM
fan2:        0 RPM  (min = 5973 RPM, div = 2)          ALARM
temp:      +35.5?C  (high =    +0?C, hyst =    +0?C)   ALARM
alarms:   Chassis intrusion detection                  ALARM

peetoo:0-002d$ ww_adm9240

    in0_min         in0_input     in0_max         alarm
0     1367            1510          0               ON
1     0               2025          0               ON
2     3128            3352          0               ON
3     4740            5182          0               ON
4     11375           12250         0               ON
5     0               2588          0               ON

    temp1_input     temp1_max     temp1_max_hyst  alarm
1     35500           0             0               ON

    fan1_input      fan1_min      alarm
1     4091            5973          ON
2     0               5973          ON

      cpu0_vid:       2000
      analog_out:     1235
      alarms:         0x13df
      ci_alarm:       ON


normal operation:

peetoo:0-002d$ sensors
adm9240-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 7000
2.5V:      +1.51 V  (min =  +1.37 V, max =  +1.64 V)
Vccp1:     +2.02 V  (min =  +0.00 V, max =  +3.59 V)
3.3V:      +3.35 V  (min =  +3.13 V, max =  +3.47 V)
5V:        +5.18 V  (min =  +4.74 V, max =  +5.26 V)
12V:      +12.25 V  (min = +11.38 V, max = +12.62 V)
Vccp2:     +2.57 V  (min =  +0.00 V, max =  +3.59 V)
fan1:     4116 RPM  (min = 2987 RPM, div = 4)
fan2:     1815 RPM  (min = 1197 RPM, div = 8)
temp:      +35.5?C  (high =   +60?C, hyst =   +55?C)
alarms:

peetoo:0-002d$ ww_adm9240

    in0_min         in0_input     in0_max         alarm
0     1367            1510          1641            --
1     0               2011          3586            --
2     3128            3352          3472            --
3     4740            5182          5260            --
4     11375           12250         12625           --
5     0               2588          3586            --

    temp1_input     temp1_max     temp1_max_hyst  alarm
1     35500           60000         55000           --

    fan1_input      fan1_min      alarm
1     4116            2987          --
2     1815            1197          --

      cpu0_vid:       2000
      analog_out:     1235
      alarms:         0x0000
      ci_alarm:       --

Please let me know if you want a patch for libsensors or if you feel 
leaving in a read accessor for fan_div is better.

Cheers,
Grant.
