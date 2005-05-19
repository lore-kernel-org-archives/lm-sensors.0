From: paul.aviles@palei.com (Paul Aviles)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: gs10
Message-Id: <20041003231641.M43741@palei.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a Tyan GS10 board that I think uses the pc87360 chipset. In the BIOS 
you can see the RPMS of 3 fans, plus the CPU and case temperature. I am 
running FC1 and installed without any issues lmsensors and 2.8.7 and i2c  
2.8.7. When I run sensors-detect it reports the following...see below. 

If I do a modprobe pc87360 it returns

/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/i2c/chips/pc87360.o: 
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including 
invalid IO or IRQ parameters.
     You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/i2c/chips/pc87360.o: 
insmod /lib/modules/2.4.22-1.2115.nptl/kernel/drivers/i2c/chips/pc87360.o 
failed
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/i2c/chips/pc87360.o: insmod 
pc87360 failed

Do you have any ideas what I am doing wrong?

Thanks so much.

Paul

Results of sensors-detect

Driver `eeprom' (should be inserted):
 Detects correctly:
 * Bus `SMBus I801 adapter at 1460' (Non-I2C SMBus adapter)
   Busdriver `i2c-i801', I2C address 0x50
   Chip `SPD EEPROM' (confidence: 
 * Bus `SMBus I801 adapter at 1460' (Non-I2C SMBus adapter)
   Busdriver `i2c-i801', I2C address 0x51
   Chip `SPD EEPROM' (confidence: 

Driver `pc87360' (should be inserted):
 Detects correctly:
 * ISA bus address 0x0820 (Busdriver `i2c-isa')
   Chip `Nat. Semi. PC87366 Super IO Fan Sensors' (confidence: 9)
 * ISA bus address 0x0830      (Busdriver `i2c-isa')
   Chip `Nat. Semi. PC87366 Super IO Voltage Sensors' (confidence: 9)
 * ISA bus address 0x0860 (Busdriver `i2c-isa')
   Chip `Nat. Semi. PC87366 Super IO Thermal Sensors' (confidence: 9)

/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe pc87360
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended


--
Paul Anthony Aviles

-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
