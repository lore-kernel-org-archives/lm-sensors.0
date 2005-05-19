From: joerg@dorchain.net (Joerg Dorchain)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Installation report/Feedback
Message-Id: <20031207183312.GA855@GreenHouse.dorchain.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just installed lm_sensors on my box and it went fine.
The machine is a 4MBO OEM machine sold in Germany as "Plus VolksPC
2600". It contains an OEM Asus A7N8X MB version with an nvidia nforce2
chipset. It is supported by the i2c-nforce2 driver out of the box.
I used the "patch-kernel" approach for i2c and "compile separately" for
lm_sensors.  Kernel is 2.4.23, lm_sensors 2.8.1

Here is the output of sensors:

eeprom-i2c-0-50
Adapter: SMBus nForce2 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Unknown EEPROM type (0)

eeprom-i2c-0-51
Adapter: SMBus nForce2 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Unknown EEPROM type (32)

as99127f-i2c-1-2d
Adapter: SMBus nForce2 adapter at 5500
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.70 V  (min =  +1.49 V, max =  +1.81 V)              
VCore 2:   +1.70 V  (min =  +1.49 V, max =  +1.81 V)              
+3.3V:     +3.34 V  (min =  +2.98 V, max =  +3.63 V)              
+5V:       +4.89 V  (min =  +4.52 V, max =  +5.48 V)              
+12V:     +11.48 V  (min = +10.83 V, max = +13.15 V)              
-12V:     -12.00 V  (min =  -0.00 V, max =  -0.00 V)              
-5V:       -4.54 V  (min =  -0.00 V, max =  -0.00 V)              
fan1:     6683 RPM  (min = 3000 RPM, div = 2)                     
fan2:        0 RPM  (min = 3000 RPM, div = 2)                     
fan3:        0 RPM  (min = 3000 RPM, div = 2)                     
M/B Temp:    +28?C  (limit =  +60?C)                              
CPU Temp:  +43.4?C  (limit = +120?C, hysteresis = +100?C)        
temp3:    +255.4?C  (limit = +120?C, hysteresis = +100?C)        
vid:      +1.650 V
alarms:   
beep_enable:
          Sound alarm enabled

eeprom-i2c-2-50
Adapter: bt848 #0
Algorithm: Bit-shift algorithm
Unknown EEPROM type (0)

I have some random notes about it.
- On the first try, sensors-detect segfaulted. I tried to reboot, which
  failed because hda had write errors. Only a complete unplug from mains
  for the usual 30s made it boot again. As I used this machine for some
  time before witha wild mix of stock kernel, nvidia and lm_sensors
  modules, I'm not too sure what caused this. After the reboot (which
  definitivly brought kernel sources and running kernel in sync) is just
  works now, so IMHO having sources, config and running kernel the same
  seems to be important.
- My bttv card run fine as ever.
- On the sensors output, the fan1 is reported at 3307RPM by the BIOS,
  CPU Temp as 47 degrees.
- sensors-detect produced a line # no driver for Winbond W83L785TS yet,
  ask us for one! and so I do ;-)

I can help with applying patches and retrying, or if you need more info,
I will provide it.

Bye,

Joerg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031207/5c677dc6/attachment.bin
