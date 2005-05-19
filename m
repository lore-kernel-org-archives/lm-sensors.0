From: tmccoy@datafast.net.au (Tim McCoy)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: 2.4.22 + lm-2.8.1
Message-Id: <3FB8B798.6020107@datafast.net.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Evenin' all...

I've patched and installed i2c and lm_sensors 2.8.1 today - sucessfully 
for the first time. Nice work guys... To this point, I've had all sorts 
of make issues with lm, but today was pretty straight forward, and now 
GKrellm finally has my temps and RPMs for me! Working hardware: ASUS 
A7V333, with ViaPro and a couple of other modules in.

tmccoy@hackbox:~$ sensors
as99127f-i2c-0-2d
Adapter: SMBus Via Pro adapter at e800
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.52 V  (min =  +1.22 V, max =  +1.49 V)             
VCore 2:   +1.52 V  (min =  +1.22 V, max =  +1.49 V)             
+3.3V:     +3.26 V  (min =  +2.98 V, max =  +3.63 V)             
+5V:       +4.97 V  (min =  +4.52 V, max =  +5.48 V)             
+12V:     +12.39 V  (min = +10.83 V, max = +13.15 V)             
-12V:     -12.95 V  (min =  -0.00 V, max =  -0.00 V)             
-5V:       -4.91 V  (min =  -0.00 V, max =  -0.00 V)             
fan1:     3497 RPM  (min = 3000 RPM, div = 2)                    
fan2:     3443 RPM  (min = 3000 RPM, div = 2)                    
fan3:        0 RPM  (min = 3000 RPM, div = 2)                    
temp1:       +27?C  (limit =  +60?C)                             
temp2:     +35.4?C  (limit = +120?C, hysteresis = +100?C)       
temp3:     +14.4?C  (limit = +120?C, hysteresis = +100?C)       
vid:      +1.350 V
alarms:  
beep_enable:
          Sound alarm enabled

But a problem - my mate was also over and I was helping him to have a go 
at getting it running. His system is a slightly newer nForce2 based 
mobo, which has had not good results with the same install method.

Build and install goes fine, but I'm getting nothing interesting out of 
the sensors themselves... Any suggestions? I'll include the 
sensors-detect data, but for now, we're wondering what to do. Maybe you 
can shed some light - is the support ready for this chipset?

Install method:
1. Patch new 2.4.22 kernel with supplied patch for i2c 2.8.1
2. Kernel compiled and installed
3. Compile and install of lm_sensors-2.8.1 (make, make install, depmod 
-a, ldconfig)
4. sensors-detect ran, and some results recovered.

Problem system: ASUS A7N8X-X (nForce2 based).

------------------------------
sensors-detect results:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `UNKNOWN', I2C address 0x51
    Chip `Serial EEPROM' (confidence: 8)

Driver `w83781d' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
    Busdriver `UNKNOWN', I2C address 0x2d (and 0x48 0x49)
    Chip `Asus AS99127F' (confidence: 8)

Driver `pcf8591' (may not be inserted):
  Misdetects:
  * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
    Busdriver `UNKNOWN', I2C address 0x48
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
    Busdriver `UNKNOWN', I2C address 0x49
    Chip `Philips Semiconductors PCF8591' (confidence: 1)

Driver `lm75' (may not be inserted):
  Misdetects:
  * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
    Busdriver `UNKNOWN', I2C address 0x49
    Chip `National Semiconductor LM75' (confidence: 3)

Driver `ds1621' (may not be inserted):
  Misdetects:
  * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
    Busdriver `UNKNOWN', I2C address 0x49
    Chip `Dallas Semiconductor DS1621' (confidence: 6)

------------------------------
sensors results:

pcf8591-i2c-1-48
Adapter: SMBus nForce2 adapter at 5500
Algorithm: Non-I2C SMBus adapter
Chan. 0:  255
Chan. 1:  255
Chan. 2:  255
Chan. 3:  255
Output:   0 (enabled)

pcf8591-i2c-1-49
Adapter: SMBus nForce2 adapter at 5500
Algorithm: Non-I2C SMBus adapter
Chan. 0:  24
Chan. 1:  24
Chan. 2:  24
Chan. 3:  24
Output:   0 (enabled)

eeprom-i2c-0-51
Adapter: SMBus nForce2 adapter at 5000
Algorithm: Non-I2C SMBus adapter

-- 
http://members.datafast.net.au/tmccoy
MSN: timsy_01@hotmail.com
ICQ: 160341067

