From: grant_lkml@dodo.com.au (Grant Coady)
Date: Fri, 27 May 2005 06:44:55 +0000
Subject: [lm-sensors] Surprise: lm_sensors on 2.4...
Message-Id: <h69d91l9mq8ff027laiolk3frrvo4r99h6@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gang,

New territory for me, took a few tries though it reads 
/etc/sensors.conf I made in 2.6 land.

--Grant.

root@sempro:/usr/local/src/cvs/lm_sensors2# uname -a
Linux sempro 2.4.30-hf2 #3 Fri May 27 14:03:51 EST 2005 i686 unknown unknown GNU/Linux
root@sempro:/usr/local/src/cvs/lm_sensors2# sensors
w83697hf-isa-0290
Adapter: ISA adapter
  VCore:   +1.55 V  (min =  +1.52 V, max =  +1.68 V)
   3.3V:   +3.30 V  (min =  +3.14 V, max =  +3.46 V)
     5V:   +5.11 V  (min =  +4.74 V, max =  +5.24 V)
    12V:  +11.97 V  (min = +11.36 V, max = +12.58 V)
   -12V:  -11.80 V  (min = -12.62 V, max = -11.44 V)
    -5V:   -5.04 V  (min =  -5.26 V, max =  -4.76 V)
   V5SB:   +4.97 V  (min =  +4.76 V, max =  +5.24 V)
  VBatt:   +3.38 V  (min =  +2.90 V, max =  +3.41 V)
CPU Fan:  3154 RPM  (min = 1500 RPM, div = 4)
CaseFan:  1520 RPM  (min = 1196 RPM, div = 8)
Ambient:     +32?C  (high =   +50?C, hyst =   +45?C)   sensor = thermistor
    CPU:   +50.0?C  (high =   +66?C, hyst =   +61?C)   sensor = diode           (beep)
alarms:
beep_enable:
          Sound alarm enabled

root@sempro:/usr/local/src/cvs/lm_sensors2# lsmod
Module                  Size  Used by    Not tainted
w83627hf               13464   0  (unused)
i2c-proc                6116   0  [w83627hf]
i2c-isa                  772   0  (unused)
i2c-core               15012   0  [w83627hf i2c-proc i2c-isa]
mousedev                3988   1


