From: nromer@arcmailtech.com (Noah Romer)
Date: Sat, 06 Jan 2007 02:14:30 +0000
Subject: [lm-sensors] sensors.conf for supermicro x7dbe+
Message-Id: <200701051814.30640.nromer@arcmailtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701031701.08165.nromer@arcmailtech.com>
In-Reply-To: <200701031701.08165.nromer@arcmailtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 05 January 2007 14:19, Rudolf Marek <r.marek at assembler.cz> wrote:
> You may use the 2.6.19. Or a patch for earlier versions. Maybe it will apply
> to previus recent kernels too. Can you use 2.6.19 or need any earlier
> kernels? 

Had to go with 2.6.20-rc3. 2.6.19 doesn't have the w83793 driver in it. The 
output of sensors looks good for the w83793, just need to add a few "ignores" 
to sensors.conf for the bits of hardware that don't exist in this chasis. The 
output for the w83627hf that sensors-detect finds looks off, though (see 
below). SuperMicro didn't mention anything about it.

[offset values snipped] 

> > Windbond W83792D, Slave Address=0x2e (0x5C in 8-Bit format)
> > ==============================> > Chassis Intrusion, Offset 0xaa, BitMask 0x20
> 
> Wow I dont believe this. I think it must be wrong... Why to put there the 
> other chip just for this... Please can you run there a sensors-detect and
> post it here? 
 
Here we are. No W83792D found.

	Probing for `Winbond W83792D'...                            No
[snip]
	Now follows a summary of the probes I have just done.
	Just press ENTER to continue: 
	
	Driver `w83781d' (should be inserted):
	  Detects correctly:
	  * Bus `SMBus I801 adapter at 1100'
	    Busdriver `i2c-i801', I2C address 0x2d
	    Chip `w83627hf' (confidence: 6)
	  * Bus `SMBus I801 adapter at 1100'
	    Busdriver `i2c-i801', I2C address 0x48
	    Chip `w83627hf subclient' (confidence: 6)
	  * Bus `SMBus I801 adapter at 1100'
	    Busdriver `i2c-i801', I2C address 0x49
	    Chip `w83627hf subclient' (confidence: 6)
	  * ISA bus address 0x0290 (Busdriver `i2c-isa')
	    Chip `Winbond W83627HF' (confidence: 8)
	
	Driver `w83793' (should be inserted):
	  Detects correctly:
	  * Bus `SMBus I801 adapter at 1100'
	    Busdriver `i2c-i801', I2C address 0x2f
	    Chip `Winbond W83793R/G' (confidence: 8)
	
	Driver `w83627hf' (should be inserted):
	  Detects correctly:
	  * ISA bus address 0x0295 (Busdriver `i2c-isa')
	    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)


`sensors` says:

w83627hf-i2c-0-2d
Adapter: SMBus I801 adapter at 1100
in0:       +4.08 V  (min =  +0.00 V, max =  +4.08 V)              
in1:       +4.08 V  (min =  +0.00 V, max =  +4.08 V)              
in2:       +4.08 V  (min =  +2.82 V, max =  +3.79 V)       ALARM  
in3:       +3.09 V  (min =  +2.82 V, max =  +3.12 V)              
in4:       +3.04 V  (min =  +2.85 V, max =  +3.47 V)              
in5:       +3.09 V  (min =  +0.34 V, max =  +0.78 V)       ALARM  
in6:       +3.09 V  (min =  +0.78 V, max =  +0.94 V)       ALARM  
in7:       +3.38 V  (min =  +2.82 V, max =  +3.12 V)       ALARM  
in8:       +0.06 V  (min =  +2.40 V, max =  +3.60 V)       ALARM  
fan1:        0 RPM  (min =    0 RPM, div = 2)                     
fan2:        0 RPM  (min =    0 RPM, div = 2)                     
fan3:        0 RPM  (min =    0 RPM, div = 2)                     
temp1:       -48?C  (high =    -1?C, hyst =    -3?C)   sensor = thermistor           
temp2:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor           
temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor           
vid:      +0.000 V  (VRM Version 10.0)
alarms:   
beep_enable:
          Sound alarm enabled

w83627hf-isa-0290
Adapter: ISA adapter
in0:       +4.08 V  (min =  +0.00 V, max =  +4.08 V)              
in1:       +4.08 V  (min =  +0.00 V, max =  +4.08 V)              
in2:       +4.08 V  (min =  +2.82 V, max =  +3.79 V)       ALARM  
in3:       +3.04 V  (min =  +2.82 V, max =  +3.12 V)              
in4:       +3.04 V  (min =  +2.85 V, max =  +3.47 V)              
in5:       +3.09 V  (min =  +0.34 V, max =  +0.78 V)       ALARM  
in6:       +3.07 V  (min =  +0.78 V, max =  +0.94 V)       ALARM  
in7:       +3.39 V  (min =  +2.82 V, max =  +3.12 V)       ALARM  
in8:       +0.06 V  (min =  +2.40 V, max =  +3.60 V)       ALARM  
fan1:        0 RPM  (min =    0 RPM, div = 2)                     
fan2:        0 RPM  (min =    0 RPM, div = 2)                     
fan3:        0 RPM  (min =    0 RPM, div = 2)                     
temp1:       -48?C  (high =    -1?C, hyst =    -3?C)   sensor = thermistor           
temp2:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor           
temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor           
vid:      +0.000 V  (VRM Version 10.0)
alarms:   
beep_enable:
          Sound alarm enabled

w83793-i2c-0-2f
Adapter: SMBus I801 adapter at 1100
VCoreA:    +1.22 V  (min =  +0.92 V, max =  +1.49 V)   
VCoreB:    +1.26 V  (min =  +0.92 V, max =  +1.49 V)   
-12V:      +1.49 V  (min =  +1.34 V, max =  +1.65 V)   
+1.5V:     +3.30 V  (min =  +2.96 V, max =  +3.63 V)   
+3.3V:    +11.90 V  (min = +10.75 V, max = +13.25 V)   
+12V:      +4.97 V  (min =  +4.49 V, max =  +5.50 V)   
+5V:       +4.92 V  (min =  +4.49 V, max =  +5.50 V)   
5VSB:      +3.25 V  (min =  +2.99 V, max =  +3.66 V)   
fan1:        0 RPM  (min =  712 RPM)                   ALARM
fan2:     4981 RPM  (min =  712 RPM)                   
fan3:     5192 RPM  (min =  712 RPM)                   
fan4:     4821 RPM  (min =  712 RPM)                   
fan5:        0 RPM  (min =  712 RPM)                   ALARM
fan6:        0 RPM  (min =  712 RPM)                   ALARM
fan7:        0 RPM  (min =  712 RPM)                   ALARM
fan8:        0 RPM  (min =  712 RPM)                   ALARM
fan9:        0 RPM  (min =  712 RPM)                   ALARM
fan10:       0 RPM  (min =  712 RPM)                   ALARM
CPU1 Temp: +24.8?C  (high = +80.0?C, hyst = +75.0?C)   
CPU2 Temp: +23.8?C  (high = +80.0?C, hyst = +75.0?C)   
temp3:     +24.8?C  (high = +80.0?C, hyst = +75.0?C)   
temp4:     +24.8?C  (high = +80.0?C, hyst = +75.0?C)   
temp5:       +28?C  (high =   +50?C, hyst =   +45?C)   
temp6:       +92?C  (high =  +100?C, hyst =   +95?C)   
cpu0_vid: +1.075 V  (VRM Version 10.0)
cpu1_vid: +0.000 V  (VRM Version 10.0)

Thanks,
Noah
-- 
Noah Romer <nromer at arcmailtech.com>
GPG Key Fingerprint: 944E C2F8 EBEC BCC7 EEA9  9381 1B21 0098 CC8D 45BA

