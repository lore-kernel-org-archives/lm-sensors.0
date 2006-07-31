From: j2fuentes@gmail.com (JF)
Date: Mon, 31 Jul 2006 15:03:54 +0000
Subject: [lm-sensors] i810 adm1021
Message-Id: <1154358234.8040.42.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1154355042.8040.29.camel@localhost>
In-Reply-To: <1154355042.8040.29.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

dear JD,

thanks for your quick reply...

i didn't know i could've fried my machine doing these things. thanks for
the warning.

well, i was really hoping my notebook had hardware monitoring sensors.

> Hi JF,
> 
> > i have spent several hours trying to figure out how to
> > setup lm-sensors. i have slowly made progress, and was
> > almost able to achieve complete success. i am not sure
> > though if i made the correct steps. let me share my
> > experience in the hope that you could help me sort this
> > one out.
> > 
> > a) system
> > 
> >    - Ubuntu Dapper
> >      2.6.15-26-386
> > 
> >    - compiled lm-sensors.2.10.0
> > 
> >    - pertinent output of lspci
> >      -------------------------
> > 
> > 	0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 04)
> > 
> > b) pertinent output of sensors-detect
> >    ----------------------------------
> > 
> > Probing for PCI bus adapters...
> > Use driver `i2c-i801' for device 00:1f.3: Intel 82801FB ICH6
> > Probe succesfully concluded.
> 
> First of all, please not that this is the SMBus, i2c-i801, and NOT
> i2c-i810, the graphics adapter, as your mail subject has.
> 
thanks... i got this wrong.

> > Next adapter: SMBus I801 adapter at 1400
> > Do you want to scan it? (YES/no/selectively):
> > Client found at address 0x08
> > Client found at address 0x44
> > Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
> > Client found at address 0x50
> > Probing for `SPD EEPROM'... Success!
> >     (confidence 8, driver `eeprom')
> > Probing for `DDC monitor'... Failed!
> > Probing for `Maxim MAX6900'... Failed!
> > Client found at address 0x52
> > Probing for `SPD EEPROM'... Success!
> >     (confidence 8, driver `eeprom')
> > Client found at address 0x69
> 
> 
> What this means is that you have no hardware monitoring chips on this
> bus. Hardware monitoring chips live at 0x28-0x2f or 0x48-0x4f most of
> the time.

valuable information. might be able to use this when i try this on other
machines...

> 
> > $ lsmod |grep i2c
> > 
> > i2c_dev                 9984  0
> > i2c_i801                9100  0
> > i2c_core               21904  2 eeprom, i2c_dev,i2c_i801
> > 
> > problem started when i used "sensors". the results came out as 
> > 
> > Can't access procfs/sysfs file
> > Unable to find i2c bus information;
> > For 2.6 kernels, make sure you have mounted sysfs and libsensors
> > was compiled with sysfs support!
> > For older kernels, make sure you have done 'modprobe i2c-proc'!
> 
> This is a misleading error message, which (I believe) has been fixed
> since. What it really means is: no sensors found.
> 

noted....

> > c) i tried playing around with i2cdump using the addresses of devices i got with "sensors-detect"
> > 
> > c1) results of "i2cdump 0x08"
> > (...)
> > c2) "i2cdump 0x44"
> 
> These are SMBus 2.0 special addresses, not real chips.
> 
> > c3) "i2cdump 0x50"
> >     --------------
> > 
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 80 08 07 0d 0b 01 40 00 04 60 70 00 82 08 00 01    ??????@.?`p.??.?
> > 10: 0e 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 80    ????? ?up..H0H*?
> > 20: 75 75 45 45 00 00 00 00 00 3c 48 30 2d 55 00 00    uuEE.....<H0-U..
> > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 41    ...............A
> > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 60: 00 00 00 00 60 00 00 00 28 12 05 01 0a 00 00 00    ....`...(????...
> > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 
> > c4) "i2cdump 0x52"
> >     --------------
> > 
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 80 08 07 0d 0b 01 40 00 04 60 70 00 82 08 00 01    ??????@.?`p.??.?
> > 10: 0e 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 80    ????? ?up..H0H*?
> > 20: 75 75 45 45 00 00 00 00 00 3c 48 30 2d 55 00 00    uuEE.....<H0-U..
> > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 41    ...............A
> > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 60: 00 00 00 00 60 00 00 00 28 12 05 01 0a 00 00 00    ....`...(????...
> > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 
> These are your memory module EEPROMS. Use "decode-dimms.pl" for decoded
> data.
> 
> > 
> > c5) "i2cdump 0x69"
> > 
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
> > 10: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
> > 20: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
> > 30: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
> > 40: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
> > 50: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
> > 60: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
> > 70: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
> > 80: 39 7f f7 c6 e5 01 75 01 0f 07 00 cd 3c eb 2f 88    9?????u???.?<?/?
> > 90: 00 53 b8 f5 1c 00 XX d3 d3 d3 d3 d3 d3 d3 d3 d3    .S???.X?????????
> > a0: 39 7f f7 c6 e5 01 75 01 0f 07 00 cd 3c eb 2f 88    9?????u???.?<?/?
> > b0: 00 53 b8 f5 1c 00 XX d3 d3 d3 d3 d3 d3 d3 d3 d3    .S???.X?????????
> > c0: 39 7f f7 c6 e5 01 75 01 0f 07 00 cd 3c eb 2f 88    9?????u???.?<?/?
> > d0: 00 53 b8 f5 1c 00 XX d3 d3 d3 d3 d3 d3 d3 d3 d3    .S???.X?????????
> > e0: 39 7f f7 c6 e5 01 75 01 0f 07 00 cd 3c eb 2f 88    9?????u???.?<?/?
> > f0: 00 53 b8 f5 1c 00 XX d3 d3 d3 d3 d3 d3 d3 d3 d3    .S???.X?????????
> 
> This is some clock chip which you better don't touch.
> 
> > d) i tried to guess what chip/device to use. i experimented with adm1021:
> > 
> > d1) modprobe adm1021 force=0,0x08
> > 
> > "sensors" give:
> > 
> > max1617-i2c-0-08
> > Adapter: SMBus I801 adapter at 1400
> > 
> > Board:        -1?C  (low  =    -1?C, high =    -1?C)  ALARM (LOW,HIGH)
> > CPU:          -1?C  (low  =    -1?C, high =    -1?C)  ALARM (N/A,LOW,HIGH)
> > 
> > d2) modprobe adm1021 force=0,0x44; "sensors" give
> > 
> > lm84-i2c-0-44
> > Adapter: SMBus I801 adapter at 1400
> > 
> > Board:        +0?C  (low  =    +0?C, high =    +0?C)
> > CPU:          +0?C  (low  =    +0?C, high =    +0?C)
> > 
> > d3) modprobe adm1021 force=0,0x50; "sensors" give
> 
> Naaaah! DON'T EVER DO THIS AGAIN.
> 
> If some of our documentation gave you the idea to try that, please
> point me to it, so that I can fix it.
> 

None of the documentation told me to do this... It was out of
desperation to install lm-sensors. Arrgh... only to find out i had no
hardware sensors.

> This chip (and the one at 0x52) are memory module EEPROMs. They contain
> data relative to the type, size, speed etc. of your memory. Forcing a
> hardware monitoring chip to use this address would corrupt the data if
> the EEPROM isn't write-protected. And I've seen memory modules
> unprotected already (Kingston.)
> 
> Let's just hope it's not too late. You can i2cdump 0x50 and 0x52 again
> and make sure they return exactly the same data as before.
> decode-dimms.pl will complain too if the checksums are no more correct.
> If so, don't power down your computer, tell me, and I'll give you
> detailed instructions to save your memory modules.
> 
the information i posted above was AFTER i forced the use of the
address. i have since unloaded the modules and i2cdump shows the same
information. i am attaching herewith the output of decode-dimms.pl.
seems nothing anomalous. what do you think?

> > d5) modprobe adm1021 force=0,0x69
> > 
> > max1617-i2c-0-69
> > Adapter: SMBus I801 adapter at 1400
> > 
> > Board:       +15?C  (low  =   +15?C, high =   +15?C)
> > CPU:         +15?C  (low  =   +15?C, high =   +15?C)  ALARM (N/A,LOW)
> > 
> > This last seem to be the closest. But for sure, it gives me incorrect
> > information (15?C for CPU!)...
> 
> This is definitely wrong AND dangerous, you could lock up your system.
> 
> > Am I doing the right thing?
> 
> No, not at all. The sensors-detect output is very clear that you have
> no hardware monitoring chip on your SMBus. All chips you see on the
> SMBus are NOT hardware monitoring chips, don't even try.
> 
> You may have hardware monitoring features integrated into a Super-I/O
> chip, although sensors-detect seemingly didn't find any. You may
> provide the Super-I/O part of the output of sensors-detect for further
> analysis.
> 
> Which system is this? If this is a laptop, I'm not surprised, most
> laptops don't have (accessible) hardware monitoring chips.
> 
i thought this SHOULD be a basic feature of laptops. oh well... do you
think there is any other option for me to get CPU temperature (and fan
control?)

thanks again!
-------------- next part --------------

PC DIMM Serial Presence Detect Tester/Decoder
By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner,
Jean Delvare and others
Version 2.10.0


Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/0-0050
Guessing DIMM is in                             bank 1                          

---== The Following is Required Data and is Applicable to all DIMM Types ==---
EEPROM Checksum of bytes 0-62                   OK (0x41)                       
# of bytes written to SDRAM EEPROM              128                             
Total number of bytes in EEPROM                 256                             
Fundamental Memory type                         DDR SDRAM                       
Number of Row Address Bits (SDRAM only)         13                              
Number of Col Address Bits (SDRAM only)         11                              
Number of Module Rows                           1                               
Data Width (SDRAM only)                         64                              
Module Interface Signal Levels                  SSTL 2.5                        
Cycle Time (SDRAM) highest CAS latency          6ns                             
Maximum module speed                            DDR 333MHz (PC2700)             
Access Time (SDRAM)                             7ns                             
Module Configuration Type                       No Parity                       
Refresh Type                                    Self Refreshing                 
Refresh Rate                                    Reduced (7.8uS)                 
Primary SDRAM Component Bank Config             No Bank2 OR Bank2 = Bank1 width 
Primary SDRAM Component Widths                  8                               
Error Checking SDRAM Component Bank Config      No Bank2 OR Bank2 = Bank1 width 
Error Checking SDRAM Component Widths           Undefined!                      
Min Clock Delay for Back to Back Random Access  1                               

---== The Following Apply to SDRAM DIMMs ONLY ==---
Burst lengths supported                         Burst Length = 2                
                                                Burst Length = 4                
                                                Burst Length = 8                
Number of Device Banks                          4                               
Supported CAS Latencies                         CAS Latency = 3                 
                                                CAS Latency = 4                 
Supported CS Latencies                          CS Latency = 0                  
Supported WE Latencies                          WE Latency = 1                  
SDRAM Module Attributes                         Differential Clock Input        
SDRAM Device Attributes (General)               Lower VCC Tolerance: 10%        
                                                Upper VCC Tolerance: 10%        
                                                Undefined (bit 6)               
                                                Undefined (bit 7)               
SDRAM Cycle Time (2nd highest CAS)              7.5nS                           
SDRAM Access from Clock Time (2nd highest CAS)  7nS                             

---== The Following are Optional (may be Bogus) ==---
SDRAM Cycle Time (3rd highest CAS)              Undefined!                      
SDRAM Access from Clock Time (3rd highest CAS)  Undefined!                      

---== The Following are Required (for SDRAMs) ==---
Minimum Row Precharge Time                      72nS                            
Row Active to Row Active Min                    48nS                            
RAS to CAS Delay                                72nS                            
Min RAS Pulse Width                             42nS                            

---== The Following are Required and Apply to ALL DIMMs ==---
Row Densities                                   512 MByte                       

---== The Following are Proposed and Apply to SDRAM DIMMs ==---
Command and Address Signal Setup Time           7.5nS                           
Command and Address Signal Hold Time            7.5nS                           
Data Signal Setup Time                          4.5nS                           
Data Signal Hold Time                           4.5nS                           
SPD Revision code                               0                               
Manufacturer                                    Level One Communication         
Manufacturing Location Code                     0x00                            
Part Number                                     Undefined                       
Revision Code                                   0x0000                          
Manufacturing Date                              0x0000                          
Assembly Serial Number                          0x00000000                      
Intel Specification for Frequency               Undefined!                      
Intel Spec Details for 100MHz Support           Junction Temp B (100 degrees C) 
                                                Single Sided DIMM               


Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/0-0052
Guessing DIMM is in                             bank 3                          

---== The Following is Required Data and is Applicable to all DIMM Types ==---
EEPROM Checksum of bytes 0-62                   OK (0x41)                       
# of bytes written to SDRAM EEPROM              128                             
Total number of bytes in EEPROM                 256                             
Fundamental Memory type                         DDR SDRAM                       
Number of Row Address Bits (SDRAM only)         13                              
Number of Col Address Bits (SDRAM only)         11                              
Number of Module Rows                           1                               
Data Width (SDRAM only)                         64                              
Module Interface Signal Levels                  SSTL 2.5                        
Cycle Time (SDRAM) highest CAS latency          6ns                             
Maximum module speed                            DDR 333MHz (PC2700)             
Access Time (SDRAM)                             7ns                             
Module Configuration Type                       No Parity                       
Refresh Type                                    Self Refreshing                 
Refresh Rate                                    Reduced (7.8uS)                 
Primary SDRAM Component Bank Config             No Bank2 OR Bank2 = Bank1 width 
Primary SDRAM Component Widths                  8                               
Error Checking SDRAM Component Bank Config      No Bank2 OR Bank2 = Bank1 width 
Error Checking SDRAM Component Widths           Undefined!                      
Min Clock Delay for Back to Back Random Access  1                               

---== The Following Apply to SDRAM DIMMs ONLY ==---
Burst lengths supported                         Burst Length = 2                
                                                Burst Length = 4                
                                                Burst Length = 8                
Number of Device Banks                          4                               
Supported CAS Latencies                         CAS Latency = 3                 
                                                CAS Latency = 4                 
Supported CS Latencies                          CS Latency = 0                  
Supported WE Latencies                          WE Latency = 1                  
SDRAM Module Attributes                         Differential Clock Input        
SDRAM Device Attributes (General)               Lower VCC Tolerance: 10%        
                                                Upper VCC Tolerance: 10%        
                                                Undefined (bit 6)               
                                                Undefined (bit 7)               
SDRAM Cycle Time (2nd highest CAS)              7.5nS                           
SDRAM Access from Clock Time (2nd highest CAS)  7nS                             

---== The Following are Optional (may be Bogus) ==---
SDRAM Cycle Time (3rd highest CAS)              Undefined!                      
SDRAM Access from Clock Time (3rd highest CAS)  Undefined!                      

---== The Following are Required (for SDRAMs) ==---
Minimum Row Precharge Time                      72nS                            
Row Active to Row Active Min                    48nS                            
RAS to CAS Delay                                72nS                            
Min RAS Pulse Width                             42nS                            

---== The Following are Required and Apply to ALL DIMMs ==---
Row Densities                                   512 MByte                       

---== The Following are Proposed and Apply to SDRAM DIMMs ==---
Command and Address Signal Setup Time           7.5nS                           
Command and Address Signal Hold Time            7.5nS                           
Data Signal Setup Time                          4.5nS                           
Data Signal Hold Time                           4.5nS                           
SPD Revision code                               0                               
Manufacturer                                    Level One Communication         
Manufacturing Location Code                     0x00                            
Part Number                                     Undefined                       
Revision Code                                   0x0000                          
Manufacturing Date                              0x0000                          
Assembly Serial Number                          0x00000000                      
Intel Specification for Frequency               Undefined!                      
Intel Spec Details for 100MHz Support           Junction Temp B (100 degrees C) 
                                                Single Sided DIMM               


Number of SDRAM DIMMs detected and decoded: 2
