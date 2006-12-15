From: support@ocg.ca (Michelle Dupuis)
Date: Fri, 15 Dec 2006 02:52:20 +0000
Subject: [lm-sensors] Can't decode dimms
Message-Id: <000101c71ff4$0a5a9ba0$32fe1fac@ocg.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Decode of my DIMMs fails - despite a successful sensors-detect and module
install.  Can anyone help?  Here are the details:
 
Memory: 
	Four SDRAM-DDR2 dimms
	Description:	 4GB 667MHz DDR2 ECC Fully Buffered CL5 DIMM Dual
Rank, x4 	
	Detailed Specifications:	 Standard 512M X 72 ECC 667MHz
240-pin Fully Buffered DIMM (SDRAM-DDR2, 1.8V, CL5, FBGA, Gold) 	
	Mfgr's System P/N's:	 Kingston KVR667D2D4F5/4G
		
Result of decode-dimm.pl:
	Version 2.10.1
	Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/0-0054
	Guessing DIMM is in                             bank 5

	---== SPD EEPROM Information ==---
	EEPROM Checksum of bytes 0-62                   Bad

                                                (found 0xFF, calculated
0xC1)   
	Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/0-0055
	Guessing DIMM is in                             bank 6

	---== SPD EEPROM Information ==---
	EEPROM Checksum of bytes 0-62                   Bad

                                                (found 0xFF, calculated
0xC1)   
	Number of SDRAM DIMMs detected and decoded: 0
		
 
Sensors-detect (relevant pieces) are:
	Driver `eeprom' (should be inserted):
	  Detects correctly:
	  * Bus `SMBus I801 adapter at 1100'
	    Busdriver `i2c-i801', I2C address 0x54
	    Chip `eeprom' (confidence: 6)
	  * Bus `SMBus I801 adapter at 1100'
	    Busdriver `i2c-i801', I2C address 0x55
	    Chip `eeprom' (confidence: 6)

	#----cut here----
	# I2C module options
	alias char-major-89 i2c-dev
	#----cut here----

	#----cut here----
	# I2C adapter drivers
	modprobe i2c-i801
	# Chip drivers
	modprobe w83793
	modprobe eeprom
	# sleep 2 # optional
	/usr/local/bin/sensors -s # recommended
	#----cut here----

I ensured that all of these modules are installed.  Can anyone offer help?

Thanks,
MD



