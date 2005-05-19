From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Intel D845GEBV2 with lm85: config is locked
Message-Id: <3F7E60C4.5050106@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000501c38918$5f227520$fe0aa8c0@freeman>
In-Reply-To: <000501c38918$5f227520$fe0aa8c0@freeman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

By the way, I wrote the lm85 driver...

I must have this confused with one of the other chips I've written 
drivers for.  You're right it doesn't look like there is a way to reset 
the chip.

Here's a patch to fix the documentation regarding recommended version...

Index: lm_sensors2/doc/chips/lm85
=================================RCS file: /home/cvs/lm_sensors2/doc/chips/lm85,v
retrieving revision 1.2
diff -u -r1.2 lm85
--- lm_sensors2/doc/chips/lm85  31 May 2003 00:24:07 -0000      1.2
+++ lm_sensors2/doc/chips/lm85  4 Oct 2003 06:15:32 -0000
@@ -168,7 +168,7 @@
 The lm85 driver detects both LM85B and LM85C revisions of the chip.
 See the datasheet for a complete description of the differences.
 Other than identifying the chip, the driver behaves no differently
-with regard to these two chips.  The LM85C is recommended for new
+with regard to these two chips.  The LM85B is recommended for new
 designs.
 
 The ADM1027 and ADT7463 chips have an optional SMBALERT output that


Dimitri Puzin wrote:

>Hi,
>
>I've gone through the datasheet. There seem to be no "undo" function
>after setting the LOCK bit at 0x40h. There would be a possibility to
>have a working state if intel wouldn't set that LOCK bit at 0x40h
>during POST. The settings in the BIOS have only influence on the
>config written into the chip before locking. Even disabling the fan
>control feature in the BIOS doesn't change this behavior.
>
>According to the data the other bits at the register 0x40h are without
>an assigned function.
>
>I had a look at the lm85.c. The lm85 itself doesn't have other bits
>set/defined. In the init function there is a code part which initializes
>the chip (setting the START bit).
>
>I have the datasheet from http://www.national.com/ds/LM/LM85.pdf
>
>I had setup another OS on that board, but neither Intel's own tool
>(Active monitor) or a third-party tool (Fanspeed, MBM5) did allow
>me any settings.
>
>I'd talk to intel, maybe they will change their BIOS and stop the
>setup of the chip after setting the START bit at 0x40h. At least in
>conjunction with the [DISABLED] setting in the BIOS. I think
>there is too much setup - they should allow other tools to set
>user-defined limits, at least when the intel's setup is in disabled
>state.
>
>
>  
>
>>I think one of the other bits in LM85_REG_CONFIG is the reset bit.  If
>>set, the chip resets to it's power-on defaults and clears the LOCK bit.
>>
>>I don't have my documentation handy right now so I can't tell you for
>>sure which bit it is.  I suppose I should have created #defines for each
>>of the bits in REG_CONFIG.  Oops...
>>
>>:v)
>>
>>Dimitri Puzin wrote:
>>    
>>
>>>Hello,
>>>
>>>thank you for the fast reply. I have read the source code and also
>>>the docs for the chip. Unfortunately I couldn't find a reset function
>>>on the lm85 chip. National mentioned that only power-cycling
>>>can clear the locks set :(. It looks like the BIOS initialize the chip
>>>during the POST. I tried to play with the settings in the BIOS but
>>>even disabling the fan control function completely didn't prevent
>>>the LOCK bit at 0x40 being set. I'm not a great specialist, maybe
>>>you know of another way? a function the i2c-i801 or a register which
>>>must be set in the bridge? I tried the original tool which is suggested
>>>by Intel but they also don't allow the setting. Only the alarm
>>>levels for voltage (max/min) and the thresholds for zones can be
>>>adjusted. If there is any way to make it work I would add the needed
>>>code to the sources.
>>>
>>>I think this fact about a possible lock on the chip
>>>should be added to the docs of lm85 driver. In the source I read
>>>that the init function checks for the setting but it's not mentioned
>>>in the docs.
>>>
>>>----- Original Message ----- 
>>>From: "Philip Pokorny" <ppokorny@penguincomputing.com>
>>>To: "Dimitri Puzin" <tristan-777@t-online.de>
>>>Cc: <lm78@Stimpy.netroedge.com>
>>>Sent: Thursday, October 02, 2003 9:56 PM
>>>Subject: Re: Intel D845GEBV2 with lm85: config is locked
>>>
>>>
>>>
>>>      
>>>
>>>>The LM85 driver is telling you that the BIOS has locked the config.
>>>>When the LM85 config is locked, you can't change any of the pwm settings
>>>>or limits.
>>>>
>>>>        
>>>>
>>>>>lm85: Assigning ID 0 to National LM85-B at 0,0x2e
>>>>>lm85(0): Client (0,0x2e) config is locked.
>>>>>          
>>>>>
>>>>You can clear the lock by completely resetting the chip, but then you
>>>>loose whatever limits may have been set and any pin configuration
>>>>options that have been programmed.
>>>>
>>>>We have seen that Intel motherboards implement SMBUS interrupts.  That
>>>>means that if an ALARM is generated by an i2c device, the BIOS can  (and
>>>>will) shutdown your system.  Resetting the chip might trigger the BIOS
>>>>to shutdown your system.
>>>>
>>>>Does the BIOS allow you to control the automatic fan speed control
>>>>features of the lm85?  If so, I would recommend that you set the values
>>>>there and then use lm_sensors to view the values.
>>>>
>>>>If you're interested in working on the driver, you could implement some
>>>>code to reset the chip and then reprogram the configuration to match the
>>>>Intel BIOS setup without locking the config.  Then you would be able to
>>>>change the PWM values.  You can set the limits from user space using
>>>>'sensors -s'  If it doesn't shut your system down, then you've got what
>>>>you want.
>>>>
>>>>
>>>>
>>>>Dimitri Puzin wrote:
>>>>
>>>>        
>>>>
>>>>>Hello,
>>>>>
>>>>>I've got an Intel mainboard D845GEBV2 as replacement for my Asus
>>>>>          
>>>>>
>>>P4B-266SE
>>>
>>>      
>>>
>>>>>(that ASB100 mess). I've mounted it, gone through the configs and
>>>>>sensors-detect said I should use the lm85 driver. With lm85 it seem to
>>>>>          
>>>>>
>>>work
>>>
>>>      
>>>
>>>>>well, except I cannot change anything in the proc interface. The values
>>>>>reported seem correct but all changes (e.g. echoing values to the pwm#
>>>>>registers) are ignored... As far as I can see from the BIOS, that board
>>>>>          
>>>>>
>>>has
>>>
>>>      
>>>
>>>>>settings for fan control and speed. I guess that the BIOS initializes
>>>>>          
>>>>>
>>>the
>>>
>>>      
>>>
>>>>>sensors during POST but as far as I could see, there was no change to
>>>>>          
>>>>>
>>>the
>>>
>>>      
>>>
>>>>>problem even I deactivate the settings from the BIOS. I've took a look
>>>>>          
>>>>>
>>>at
>>>
>>>      
>>>
>>>>>the board and found following devices I could think of being attached
>>>>>          
>>>>>
>to
>  
>
>>>the
>>>
>>>      
>>>
>>>>>bus: LM 85 BIMQ, ICS 950227 AF, FW 82801 DB, PC 87382 IBU/VLA and the
>>>>>          
>>>>>
>>>eeprom
>>>
>>>      
>>>
>>>>>from the RAM. Intel claims there is an SMSC LPC47M172 on board. Here is
>>>>
>>>>        
>>>>
>>>the
>>>
>>>      
>>>
>>>>>output of what I could get from my system.
>>>>>
>>>>>Output of syslog
>>>>>-----------------------
>>>>>Oct  1 20:33:18 elexis kernel: i2c-core.o: i2c core module version
>>>>>          
>>>>>
>2.8.0
>  
>
>>>>>(20030714)
>>>>>Oct  1 20:33:18 elexis kernel: i2c-proc.o version 2.8.0 (20030714)
>>>>>Oct  1 20:33:26 elexis kernel: i2c-dev.o: i2c /dev entries driver
>>>>>          
>>>>>
>module
>  
>
>>>>>version 2.8.0 (20030714)
>>>>>Oct  1 20:33:38 elexis kernel: i2c-i801 version 2.8.0 (20030714)
>>>>>Oct  1 20:33:38 elexis kernel: i2c-dev.o: Registered 'SMBus I801
>>>>>          
>>>>>
>adapter
>  
>
>>>at
>>>
>>>      
>>>
>>>>>e000' as minor 0
>>>>>Oct  1 20:34:24 elexis kernel: lm85: Version 2.8.0 (20030714)
>>>>>Oct  1 20:34:24 elexis kernel: lm85: See
>>>>>http://www.penguincomputing.com/lm_sensors for more info.
>>>>>Oct  1 20:34:24 elexis kernel: lm85: Assigning ID 0 to National LM85-B
>>>>>          
>>>>>
>>>at
>>>
>>>      
>>>
>>>>>0,0x2e
>>>>>Oct  1 20:34:24 elexis kernel: lm85(0): Client (0,0x2e) config is
>>>>>          
>>>>>
>>>locked.
>>>
>>>      
>>>

