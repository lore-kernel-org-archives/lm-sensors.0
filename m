From: P.Glassenbury@cosc.canterbury.ac.nz (Peter Glassenbury)
Date: Fri, 21 Oct 2005 04:50:12 +0000
Subject: [lm-sensors] lm-sensors in a rollout on FC4 - Attempts fail
Message-Id: <435856C6.2010407@cosc.canterbury.ac.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4356F706.20904@cosc.canterbury.ac.nz>
In-Reply-To: <4356F706.20904@cosc.canterbury.ac.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Peter Glassenbury wrote:
>  
>
>>** 1 ** Is there a way to run the sensor-detect without prompts??
>>so I can just put it in the kickstart configuration files.
>>    
>>
>
>No immediate way. There are tricks (see Rudolf's answer) 
>  
>
I had thought of Rudolf's answer with a sensors-detect with input from
"yes yes yes smbus yes yes" style string. It seemed a bit of a hack and 
very dependent
on things not changing. Piping "yes" in does actually work (see below) 
but i am not
sure about the ISA/smbus question... My machines don't have an ISA bus
unless it means some emulation just before the sensors, so saying yes to 
that
I thought was wrong.
Mind you -- it did seem to work(see results below). I hoped to try to 
configure everything
so it didn't depend on chance... The answers on the part 2 confirgure 
attempt at bottom.
=========yes | sensor-detect================== Now follows a summary of the probes I have just done.
 Just press ENTER to continue:
Driver `lm75' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x48
    Chip `National Semiconductor LM75' (confidence: 6)
  * Bus `SMBus Via Pro adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x49
    Chip `National Semiconductor LM75' (confidence: 6)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)

Driver `it87' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)

 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?
To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
modprobe i2c-isa
# I2C chip drivers
modprobe lm75
modprobe smbus-arp
modprobe w83627hf
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----
===========================

>mind that sensors-detect was written with humans as a primary target,
>and in some cases manual tweaking is needed. The actual output of the
>script is also very helpful when investigating issues.
>  
>
I am not sure what tweaking I could do .... I am after the main 
temperatures and
fan speeds and if sensors gives me that on a good machine, I can compare 
with
something else.

>We could implement a non-interactive mode to sensors-detect, which would
>silently probe for all devices and create the configuration file. It
>won't work in all cases, of course, but I guess it would be useful in
>some cases like yours. 
>
Yes.. The case where I have checked that it is not going to break the 
system and
want to roll it out to like minded machines :-)

>
>smbus-arp is an experimental thing, you don't need it. I'm also
>surprised that you would need both w83627hf and lm75 - unless this is an
>Intel Xeon machine, maybe. What does the output of "sensors" look like
>(when it works)?
>Oh, you didn't tell us what version of linux and lm_sensors you were
>using.
>  
>
A number of machines ... I am in the middle of a FC4 rollout which I 
have installed
lmsensors 2.9.2 with libsensors version 2.9.2

The other machines have
Fedora Core 3....This particular output is from FC3 64bit
cosc502:~$ sensors --version
sensors version 2.8.7 with libsensors version 2.8.7
cosc502:~$ uname -a
Linux cosc502 2.6.9-1.667 #1 Tue Nov 2 14:50:10 EST 2004 x86_64 x86_64 
x86_64 GNU/Linux
cosc502:~$ sensors
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.59 V  (min =  +1.93 V, max =  +1.93 V)             
+12V:     +11.55 V  (min = +10.82 V, max = +13.19 V)             
+3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.47 V)             
+5V:       +5.09 V  (min =  +4.75 V, max =  +5.25 V)             
-12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)             
V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)             
VBat:      +0.66 V  (min =  +2.40 V, max =  +3.60 V)             
fan1:        0 RPM  (min = 135000 RPM, div = 2)                    
CPU Fan:  3169 RPM  (min =   -1 RPM, div = 2)                    
fan3:     1985 RPM  (min = 84375 RPM, div = 4)                    
M/B Temp:    +26?C  (high =    +1?C, hyst =    +0?C)   sensor = 
thermistor          
CPU Temp:  +40.0?C  (high =   +80?C, hyst =   +75?C)   sensor = 
thermistor          
temp3:     +21.0?C  (high =   +80?C, hyst =   +75?C)   sensor = 
thermistor          
ERROR: Can't get VID data!
alarms:  
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-51
Adapter: SMBus Via Pro adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512


>>What does the /etc/init.d/lm_sensors script do exactly? Does it come with
>>FC4, or did you install it yourself?
>>    
>>
goes through modprobing all the modules in /etc/sysconfig/lm_sensors
then does a sensors -s
(all wrapped up an supporting shell script)-- it comes with FC4

>>Run sensor-detect then all goes... arghhh what is missing
>>Can anyone suggest something?
>>    
>>
>
>sensors-detect does, in turn:
> * load i2c-dev;
> * load all suitable i2c bus drivers;
> * probe every single chip it knows about (but not load chip drivers).
>Of these, only the second step can change what "sensors' prints. So my
>guess would be that /etc/init.d/lm_sensors does not properly load the
>bus drivers. I don't really understand how this could happen though.
>
>Please check with lsmod which modules are loaded before running
>/etc/init.d/lm_sensors, after running it, and after running
>sensors-detect.
>
>  
>
-- 
-------------------------------------------------------------------
Peter Glassenbury			Computer Science dept.
pete@cosc.canterbury.ac.nz		University of Canterbury
+64 3 3642987 ext 7762			New Zealand


