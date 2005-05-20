From: sensors@xanthein.net (Jon Still)
Date: Fri, 20 May 2005 17:25:37 +0000
Subject: [lm-sensors] No temperature/fan values with 83627THF chip
Message-Id: <Pine.LNX.4.56.0505201624000.1858@io.tertial.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've been having problems with h/w sensors on a Supermicro P8SCi that 
came as a barebones 1U server (Supermicro 5014C-T).

See http://www.supermicro.com/products/system/1U/5014/SYS-5014C-T.cfm
which claims the board has a 83627THF chip.  I can now detect and load the 
module for this chip, but my temperatures and fan speeds are reported 
erroneously.

This is using: sensors version 2.9.0 with libsensors version 2.9.0
on: Linux 2.6.11-gentoo-r8 #1 SMP Thu May 19 19:00:00 BST 2005 i686 

'sensors' gives this output:
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.94 V  (min =  +1.94 V, max =  +1.94 V)       ALARM  (beep)
+12V:     +15.50 V  (min = +15.50 V, max = +15.50 V)       ALARM  (beep)
+3.3V:     +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
+5V:       +6.80 V  (min =  +6.80 V, max =  +6.80 V)       ALARM  (beep)
-12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)       ALARM  (beep)
V5SB:      +6.85 V  (min =  +6.85 V, max =  +6.85 V)       ALARM  (beep)
VBat:      +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
fan1:        0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
CPU Fan:     0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
fan3:        0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
M/B Temp:     -1 C  (high =    -1 C, hyst =    -1 C)   sensor = diode   
ALARM   (beep)
CPU Temp:   +0.0 C  (high =    +0 C, hyst =    +0 C)   sensor = diode   
ALARM   (beep)
vid:      +0.275 V  (VRM Version 9.0)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       1024

'lsmod' reports:
w83627hf               29480  0 
eeprom                  6800  0 
i2c_sensor              3968  2 w83627hf,eeprom
i2c_isa                 2816  0 
i2c_i801                8716  0 
i2c_core               19200  5 w83627hf,eeprom,i2c_sensor,i2c_isa,i2c_i801

The output of 'sensors-detect' is attached.  The sensor hardware is 
definitely working correctly as I get both fan and CPU readings in the 
BIOS.  Also, when I start lm_sensors using Gentoo's init script, it fails 
trying to load smbus-arp, as the module does not exist.  However from 
googling, I'm unsure if this is important or not!

If anyone can help, I'd be most grateful as I'm drawing blanks at the 
moment!

Thanks,
Jon.

-- 
Jon Still                               E-mail: jon@tertial.org
tertial.org                             Web:    http://www.tertial.org/
GPG Key: http://xanthein.net/key.asc    Key ID: 0x00493D2B
