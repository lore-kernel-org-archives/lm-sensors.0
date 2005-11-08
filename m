From: paul.aviles@palei.com (Paul Aviles)
Date: Tue, 08 Nov 2005 13:40:16 +0000
Subject: [lm-sensors] adm1027 on 2.6.9-5.EL
Message-Id: <000601c5e461$75be17c0$3224050a@avilespaxp>
List-Id: <lm-sensors.vger.kernel.org>
References: <XVkq04oM.1131444138.7357880.khali@localhost>
In-Reply-To: <XVkq04oM.1131444138.7357880.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In a previous 2.4 kernel install I had stuff under /proc/sys/dev/sensors and 
I cannot see it in 2.6.9-5. I have nothing under/sys/bus/i2c or 
/sys/class/hwmon though I do get sensors to work as the report below.

When I compared to my 2.4 working machine i2c-proc which I "guess" is normal 
when reading the doc from i2c-2.8.8 as i2c-core is supposed to provide 
this??. What I am missing is the fan stuff it used to be in the procs dir.

What am I missing?

I used the sensors.init script to load the modules and this is the result of 
my lsmod.

i2c_dev                11329  0
eeprom                  8545  0
lm85                   19433  0
i2c_sensor              3521  2 eeprom,lm85
i2c_i801                7757  0
i2c_core               22081  5 i2c_dev,eeprom,lm85,i2c_sensor,i2c_i801

and sensors

adm1027-i2c-0-2e
Adapter: SMBus I801 adapter at 1480
+2.6V:     +2.591 V  (min =  +2.47 V, max =  +2.73 V)
CPU Volt:  +1.359 V  (min =  +1.25 V, max =  +1.52 V)
+3.3V:     +3.386 V  (min =  +3.13 V, max =  +3.47 V)
+5V:      +5.104 V  (min =  +4.74 V, max =  +5.26 V)
Fan2:      8083 RPM  (min = 4800 RPM)
Fan3:      6129 RPM  (min = 2200 RPM)
Fan1:      8095 RPM  (min = 4800 RPM)
CPU Temp: +40.00?C  (low  =    +5?C, high =   +68?C)
Loc Temp: +34.00?C  (low  =    +5?C, high =   +40?C)
Sys Temp: +36.00?C  (low  =    +5?C, high =   +50?C)
pwm2:       64
pwm3:       64
pwm1:       64
vid:      -3.425 V  (VRM Version 9.1)

Thanks guys, particularly to Jean.

Paul 


