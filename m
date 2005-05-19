From: petasis@iit.demokritos.gr (George Petasis)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: lm_sensors and wrong values on MSI MS-6704 (845PE Max2 FIR)
Message-Id: <3F4908A8.3020608@iit.demokritos.gr>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F44B811.5010809@iit.demokritos.gr>
In-Reply-To: <3F44B811.5010809@iit.demokritos.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you very much for your feedback. I also thought
that sensors-detect failed to properly handle
my system (I am using sensors version 2.6.5).

Looking in the manual there was a reference to
w83627hf in one image, but the chip was reported
as not installed by sensors-detect...

The solution I have found was to try the isa bus.
So, I manually loaded i2c-isa, and then
modprobe w83781d force_w83627hf.
And magically everything worked!
sensors gives output like:

w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.48 V  (min =  +1.37 V, max =  +1.52 V)       ALARM
VCore 2:   +1.50 V  (min =  +1.37 V, max =  +1.52 V)
+3.3V:     +3.23 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +5.02 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +11.86 V  (min = +10.79 V, max = +13.19 V)
-12V:     -11.98 V  (min = -13.21 V, max = -10.90 V)
-5V:       -4.95 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.53 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.05 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     2596 RPM  (min =    0 RPM, div = 4)
fan2:     1906 RPM  (min =    0 RPM, div = 4)
fan3:     5357 RPM  (min =    0 RPM, div = 4)
temp1:       +23C  (limit =  +60C)                       sensor = thermistor
temp2:     +59.0C  (limit =  +60C, hysteresis =  +50C) sensor = 
PII/Celeron diode   ALARM
temp3:     +44.5C  (limit =  +60C, hysteresis =  +50C) sensor = thermistor
vid:      +1.450 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

The only problem I had was with the fan speeds, where the two first
fans always reported 0RPM, but I got it working by setting the
divider to 4. I addionally installed ksensors, and everything
is fine...

BTW, is my systems configuration so peculiar that
sensors-detect failed to configure it?

George

Jean Delvare wrote:

>>I am trying to install support for monitoring cpu temp under
>>my redhat 9.0 box, but without much success.
>>I have ran sensors-detect, which identified LM80 in my
>>system. Everything seems to have been installed fine,
>>but the readings I get are:
>>
>>lm80-i2c-0-2f
>>Adapter: SMBus I801 adapter at 0c00
>>Algorithm: Non-I2C SMBus adapter
>>+5V:       +6.71 V  (min =  +6.71 V, max =  +6.71 V)   ALARM
>>VTT:       +2.55 V  (min =  +2.55 V, max =  +2.55 V)   ALARM
>>+3.3V:     +4.43 V  (min =  +4.43 V, max =  +4.43 V)   ALARM
>>+Vcore:    +3.76 V  (min =  +3.76 V, max =  +3.76 V)   ALARM
>>+12V:     +16.10 V  (min = +16.10 V, max = +16.10 V)   ALARM
>>-12V:     -16.11 V  (min = -16.11 V, max = -16.11 V)   ALARM
>>-5V:       -6.70 V  (min =  -6.70 V, max =  -6.70 V)   ALARM
>>fan1:        0 RPM  (min =    0 RPM, div = 8)          ALARM
>>fan2:        0 RPM  (min =    0 RPM, div = 8)          ALARM
>>temp:     -1.00 C (hot:limit =  -1C,  hysteresis =  -1C) ALARM
>>         (os: limit =  -1C,  hysteresis =  -1C) ALARM
>>alarms:   Board temperature input (LM75)               ALARM
>>(...)
>>These values are constant (I have never seen them change) and of
>>course are not in accordance with what I see from my boards
>>monitor. By the way, the manifacturer supplied monitor
>>supports 2 temps (CPU & system), 3 Fan speeds & voltages.
>>Is there a way I can check if sensor_detect has
>>made the right decision?
>>    
>>
>
>The first thing to do is to find which chipset you really have on your
>motherboard. If the values really don't change, I believe to do *not*
>really have a LM80. The output of "i2cdetect 0" and "i2cdump 0 0x2f"
>would help. Reading your motherboard's manual would help a lot too.
>
>BTW, which version of lm_sensors are you using?
>
>  
>
>>Can somebody help me to get the correct values in my system?
>>    
>>
>
>Maybe you forgot to run "sensors -s". Still I think it won't help if
>your chipset isn't a LM80.
>
>  
>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030824/31933227/attachment.html
