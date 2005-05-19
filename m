From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Intel Desktop Board D875PBZ (news of hardware support)
Message-Id: <41589126.30400@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040926191456.GB18647@meep>
In-Reply-To: <20040926191456.GB18647@meep>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

What kernel and lm_sensors version are you using?

Support for the EMC6D100/101 was added to lm85 in the newer versions of 
the 2.4 drivers.

Are you running a 2.6 kernel?

:v)

Dave Cunningham wrote:

>Intel Desktop Board D875PBZ
>
>I have this board, lspci dump:
>0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
>0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
>0000:00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02)
>0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
>0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
>0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
>0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02)
>0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
>0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
>0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
>0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
>0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02)
>0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
>
>I couldnt find any info on the lm-sensors website about this
>hardware.
>
>
>sensors detect said:
>Bus `SMBus I801 adapter at c800' (Algorithm unavailable)
>Busdriver `i2c-i801', I2C address 0x2e
>Chip `SMSC EMC6D100 or EMC6D101' (confidence: 7)
>
>and also to be written:
>ISA bus address 0x06e0 (Busdriver `i2c-isa')
>Chip `Nat. Semi. PC87372 Super IO Fan Sensors' (confidence 9)
>
>and with these modules and the force (as recommended by ruik from IRC)
>modprobe lm85 force=0,0x2e
>modprobe i2c_i801
>
>sensors will output:
>lm85-i2c-0-2e
>Adapter: SMBus I801 adapter at c800
>V1.5:       +1.50 V  (min =  +0.00 V, max =  +3.32 V)   
>VCore:      +1.32 V  (min =  +0.00 V, max =  +2.99 V)   
>V3.3:       +3.30 V  (min =  +0.00 V, max =  +4.38 V)   
>V5:        +5.10 V  (min =  +0.00 V, max =  +6.64 V)   
>V12:      +12.00 V  (min =  +0.00 V, max = +15.94 V)   
>CPU_Fan:   2928 RPM  (min =    0 RPM)                     
>CPU:         +44?C  (low  =  -128?C, high =  +127?C)       
>Board:       +29?C  (low  =  -127?C, high =  +127?C)      
>Remote:      +29?C  (low  =  -127?C, high =  +127?C)       
>CPU_PWM:   255
>Fan2_PWM:  255
>Fan3_PWM:  255
>vid:      +1.375 V    (VRM Version  9.1)
>
>
>Presumably with the "to be written" bit i should be able to
>alter the fan PWM ratios and ultimately the fan speed, which
>would be very nice as i could put to rest a piece of hardware i
>made which uses the serial port to do PWM!  I can't lend
>hardware but i can help test any new drivers.
>
>Thank you
>
>-Dave Cunningham
>
>  
>

-- 
Philip Pokorny, Director of Engineering
Tel: 415-954-2823   Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
