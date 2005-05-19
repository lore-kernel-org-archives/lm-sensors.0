From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: ADM9240 sensors.conf details -- it works :o)
Message-Id: <97p781pi7edric6ej29sn2kpo6kb3670vc@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

After all the fuss I created learning lm_sensors I'm really pleased
to provide this example, 'cos last couple months I didn't think it 
could be described in sensors.conf :o)

ADM9240 and negative voltage measurement
`````````````````````````````````````````
Negative voltage readings are an offset positive value created by 
use of a resistor divider from 5V to Vminus:

#    -------o----------------o------> + 5V
#           |                |
#           -                |
#          | | R1        ---------------
#          | |          |   Vref
#           -           |
#           |     Vread |
#           o-----------| Vccp1
#           |           |
#           -           |      ADM9240
#          | | R2       |
#          | |           ---------------
#           -
#           |
#    -------0---> Vminus

The ADM9240 does not provide a reference voltage to drive the top 
of the resistor divider, so the 'compute' line for negative voltages 
needs to reference the 5V reading in order to correct for drift in 
+5V supply.  I have a preference for traceable transforms, thus the 
compute lines detail the transform rather than simplify the math 
required for a valid transform (besides, I've forgotten most of my 
math :)  Resistor ratio discovery is detailed in prior posts.

# /etc/sensors.conf
#
# For Intel SE440BX-2 with ADM9240 by Grant Coady 2005-05-13

chip "adm9240-*" "ds1780-*" "lm81-*"

        label "2.5V"    "   1.5V"
        label "3.3V"    "   3.3V"
        label "5V"      "     5V"
        label "12V"     "    12V"
        label "Vccp1"   "    -5V"
        label "Vccp2"   "   -12V"
        label fan1      "PSU Fan"
        ignore fan2
        label temp      "Ambient"

        # + internally scaled
        compute "2.5V"  @, @
        compute "3.3V"  @, @
        compute "5V"    @, @
        compute "12V"   @, @
        # -5V
        compute "Vccp1" "5V"+((@-"5V")*(1+(27/12))), "5V"-(("5V"-@)/(1+(27/12)))
        # -12V
        compute "Vccp2" "5V"+((@-"5V")*(1+(82/15))), "5V"-(("5V"-@)/(1+(82/15)))

        set "2.5V_min"  1.5 * 0.91
        set "2.5V_max"  1.5 * 1.09
        set "3.3V_min"  3.3 * 0.95
        set "3.3V_max"  3.3 * 1.05
        set "5V_min"      5 * 0.95
        set "5V_max"      5 * 1.05
        set "12V_min"    12 * 0.95
        set "12V_max"    12 * 1.05
        set "Vccp1_max"  -5 * 0.90
        set "Vccp1_min"  -5 * 1.10
        set "Vccp2_max" -12 * 0.90
        set "Vccp2_min" -12 * 1.10

#       set fan1_div    8       # auto fan_div, throws error on write attempt
        set fan1_min    1200
#       set fan2_min    1234

        set temp_over   50
        set temp_hyst   45

# end ADM9240

peetoo:~$ uname -a
Linux peetoo 2.6.11.9a #2 Thu May 12 14:20:41 EST 2005 i686 unknown unknown GNU/Linux

peetoo:~$ sensors
adm9240-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 7000
   1.5V:   +1.51 V  (min =  +1.37 V, max =  +1.64 V)
    -5V:   -5.08 V  (min =  -5.49 V, max =  -4.48 V)
   3.3V:   +3.35 V  (min =  +3.13 V, max =  +3.47 V)
     5V:   +5.18 V  (min =  +4.74 V, max =  +5.26 V)
    12V:  +12.31 V  (min = +11.38 V, max = +12.62 V)
   -12V:  -11.59 V  (min = -13.24 V, max = -10.78 V)
PSU Fan:  1493 RPM  (min = 1205 RPM, div = 8)
Ambient:   +33.5?C  (high =   +50?C, hyst =   +45?C)
alarms:

Me happy, thank you very much to those patient people here who 
helped me understand lm_sensors, drivers, and completing the 
port of adm9240 to 2.6.  My first l-k project.

Patches for adm9240 driver suit 2.6.11.8, 2.6.11.9 are available 
from http://scatter.mine.nu/hwmon/adm9240/ plus some documentation.

--Grant.
