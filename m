From: pavenis@latnet.lv (Andris Pavenis)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: lm_sensors-2.6.[23] and gcc-3.1
Message-Id: <200205281911.35942.pavenis@latnet.lv>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Tried to upgrade lm_sensors-2.6.2 which works Ok now for me (compiled with 
with gcc-3.1 release, kernel version 2.4.19-pre9-ac5) to 2.6.3. Both kernel 
and lm_sensors were built with gcc-3.1

Here is what I'm getting from 2.6.2

bash-2.05a$ sensors
as99127f-i2c-2-2d
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.63 V  (min =  +1.56 V, max =  +1.72 V)
+3.3V:     +3.45 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +5.02 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +11.36 V  (min = +10.79 V, max = +13.19 V)
-12V:     -11.56 V  (min = -10.73 V, max = -13.19 V)
-5V:       -4.98 V  (min =  -4.74 V, max =  -5.24 V)
fan1:     4115 RPM  (min = 1500 RPM, div = 4)
temp1:       +33?C  (limit =  +60?C, hysteresis =  +50?C)
temp2:     +35.8?C  (limit =  +67?C, hysteresis =  +60?C)
vid:      +1.65 V
alarms:   Chassis intrusion detection

bash-2.05a$

After upgrade w83781d modules takes about 100 seconds to load. I had one time
similar problem with gcc-3.0.4 and one earlier kernel version. Compiling 
lm_sensors-2.6.3 with gcc-2.95.3 fixes long loading time, but sensors 
incorrectly signals alarm for -5V and -12V. This trouble goes away when I 
reverted to 2.6.2 (compiled with gcc-3.1).

I also didn't saw a section for aa99127f in new configuration file in 2.6.3 
source archive.

Andris
