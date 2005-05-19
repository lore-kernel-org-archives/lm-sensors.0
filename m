From: DarkEmperor@gmx.net (Emperor)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: flex scanner jammed problem
Message-Id: <1064351477.3812.3.camel@nils>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Die, 2003-09-23 um 21.14 schrieb Jean Delvare:
> > I just installed lm_sensors via synaptic.
> 
> What is synaptic?

a frontend for apt. very nice. try it and you'll never give it away!

> 
> > I could set up my sensors.
> > But since I did that the KDE process window does not work any more,
> > ksysguardd and ksensors gave me "flex scanner jammed".
> 
> Which means that sensors itself doesn't work. Am I right?

Somehow... But sensors works...

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
Memory size (MB):       512

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
Memory size (MB):       512

w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.50 V  (min =  +1.32 V, max =  +1.47 V)       ALARM
VCore 2:   +1.64 V  (min =  +1.32 V, max =  +1.47 V)
+3.3V:     +3.39 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +5.02 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +11.97 V  (min = +10.79 V, max = +13.19 V)
-12V:     -11.62 V  (min = -13.21 V, max = -10.90 V)
-5V:       -4.85 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.53 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.02 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     1471 RPM  (min = 1500 RPM, div = 4)              ALARM
fan2:     1584 RPM  (min = 1500 RPM, div = 4)
fan3:     1333 RPM  (min = 1500 RPM, div = 4)
temp1:       +43C  (limit =  +60C)                       sensor thermistor
temp2:     +46.5C  (limit =  +60C, hysteresis =  +50C) sensor thermistor
temp3:     +70.5C  (limit =  +60C, hysteresis =  +50C) sensor thermistor   ALARM
vid:      +1.400 V
alarms:
beep_enable:
          Sound alarm disabled

eeprom-i2c-2-50
Adapter: saa7134[0]
Algorithm: saa7134



> 
> This is a known problem, which has two possible solutions:
> 
> 1* Fix your /etc/sensors.conf file. Copy the default etc/sensors.conf.eg
> file that match the version you're using, and it should be OK.

I tried... and runned sensors -s. Didn't help.
> 
> 2* If it doesn't work, update to 2.8.0 or CVS, we fixed a bug in the
> parser some weeks ago.
> 

I'm using 2.8.0

> 
> > And I got another question! is there plan in lm_sensors to support
> > writing to fan values, too? the w83627hf chip I have supports that.
> 
> "Writing to fan values" makes no sense ;) You already should be able to
> write to the min settings. As for the speed control, it is known as PWM.
> It *is* supported by our w83781d and w83627hf drivers (one of which you
> must be using), although it is known not to work properly for everyone.
> See the prog/pwm in our package, where you'll find the fancontrol and
> pwmprogram. These are the ones you need in order to have PWM working.
> Give it a try and let us know how it works for you.

Ok, in the meantime, I'm running varyfan very succesfully... PWM works
nice.

thx,

Nils
