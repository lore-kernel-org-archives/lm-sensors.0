From: DarkEmperor@gmx.net (Emperor)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: flex scanner jammed problem
Message-Id: <1064483932.3994.14.camel@nils>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Mit, 2003-09-24 um 20.11 schrieb Jean Delvare:

> I admit I could have guess that (syn-apt-ic after all). But since I
> don't use apt anyway...

hey you should ;) great thing! easy to manage... simply search for
package lm_sensors and click on install, and soon your jammed your flex
scanner ;)

> 
> > w83627hf-isa-0290
> > Adapter: ISA adapter
> > Algorithm: ISA algorithm
> > VCore 1:   +1.50 V  (min =  +1.32 V, max =  +1.47 V)       ALARM
> > (...)
> > vid:      +1.400 V
> 
> Your vid reading could be wrong, try changing vrm in the config file.
> 

I did, now the values are right:

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
VCore 1:   +1.52 V  (min =  +1.44 V, max =  +1.60 V)
VCore 2:   +1.69 V  (min =  +1.44 V, max =  +1.60 V)
+3.3V:     +3.36 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +5.04 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +11.89 V  (min = +10.79 V, max = +13.19 V)
-12V:     -11.62 V  (min = -13.21 V, max = -10.90 V)
-5V:       -4.92 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.53 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.02 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     2045 RPM  (min = 1500 RPM, div = 4)
fan2:     1599 RPM  (min = 1500 RPM, div = 4)
fan3:     1339 RPM  (min = 1500 RPM, div = 4)
temp1:       +47C  (limit =  +60C)                       sensor thermistor
temp2:     +47.5C  (limit =  +60C, hysteresis =  +50C) sensor thermistor
temp3:     +71.0C  (limit =  +60C, hysteresis =  +50C) sensor thermistor   ALARM
vid:      +1.525 V
alarms:
beep_enable:
          Sound alarm disabled



> > Adapter: saa7134[0]
> > Algorithm: saa7134
> 
> What's that thing?
> 

it's my Terratec Cinergy 400 TV tuner card. I kicked it from the
lm_sensors file. didn't change anything.

> > > This is a known problem, which has two possible solutions:
> > > 
> > > 1* Fix your /etc/sensors.conf file. Copy the default
> > > etc/sensors.conf.eg file that match the version you're using, and it
> > > should be OK.
> > 
> > I tried... and runned sensors -s. Didn't help.
> 
> What if you plain delete the config file?

Then ksensors and ksysguard work! So they use the same config file...

> 
> > > 2* If it doesn't work, update to 2.8.0 or CVS, we fixed a bug in the
> > > parser some weeks ago.
> > 
> > I'm using 2.8.0
> 
> Try CVS then <grin> (just kidding, although it may actually give
> results).
> 
> > 
> > Ok, in the meantime, I'm running varyfan very succesfully... PWM works
> > nice.
> 
> I did not know about that program, thanks for the information. I am
> going to add a link on our useful addresses page. I wonder if it offers
> something the programs included in our package don't.

I didn't try them out, you can specify temperatures, fan speed, slowdown
speed... it was right what I needed.
