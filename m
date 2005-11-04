From: davidhaertig@earthlink.net (David Haertig)
Date: Fri, 04 Nov 2005 02:23:53 +0000
Subject: [lm-sensors] lm-sensors install changed/corrupted
Message-Id: <436AB866.1040205@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <43699477.5000809@earthlink.net>
In-Reply-To: <43699477.5000809@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK.  Back from work now (what a day!) and did a little
more testing.

Good news is (for me), I cannot make this "BIOS error", or
whatever it was, reappear.  Bad news is (for you developers),
I cannot make the problem reappear for further debugging.
I now get clean boots every time.  The "unplug" did it.
I have NOT uninstalled lm-sensors to see if I can reproduce
the problem by starting back at the very beginning.  I may
attempt this at some time.  I would still like to know what
actually caused my problem, but I have a feeling that I'll
never know.

Now the sensors program is reporting good data, more or less.
Below are the results from sensors and the results that BIOS
reports during boot.  Looks like the it8712 section gets the two
fan speeds correct, and some of the voltages.  Notable is that
the it8712 reports the +3.3 as +6.5 whereas BIOS reads the +3.3
as +3.23  If you ignore the it8712 bad readings on -5 and -12
(these seem totally bogus), the rest of the it8712 voltage
readings look good.  The it8712 gets all the temperatures wrong
however.

Scroll down to the lm90 section and you'll see good readings
for both the CPU and system temps.

The eeprom section looks pretty useless to me, but the data
it reports is correct.  I didn't know you needed a "sensor"
to tell you how much memory you have!  ;-)

The modules I currently have loaded related to lm-sensors are:
   it87
   eeprom
   lm90
   i2c_sensor
   i2c_isa
   i2c_nforce2
   i2c_core

Thanks!

> #######################################
> What BIOS reports during POST (reboot):
> ---------------------------------------
> CPU Temp: 39 celcius
> Sys Temp: 40 celcius
> CPU Fan:  2721 rpm
> Sys Fan:  4017 rpm
> Vcore:    1.48v
> CPU +5:   4.97v
> CPU +3.3: 3.23v
> CPU +12:  11.71v
> 5V(SB):   4.86v
> Battery:  3.02v
> #######################################
> 
> david@familyroom:~$ sensors
> it8712-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.49 V  (min =  +1.42 V, max =  +1.57 V)
> VCore 2:   +1.49 V  (min =  +2.40 V, max =  +2.61 V)   ALARM
> +3.3V:     +6.50 V  (min =  +3.14 V, max =  +3.46 V)   ALARM
> +5V:       +4.95 V  (min =  +4.76 V, max =  +5.24 V)
> +12V:     +11.71 V  (min = +11.39 V, max = +12.61 V)
> -12V:      +1.60 V  (min = -12.63 V, max = -11.41 V)   ALARM
> -5V:       +3.96 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
> Stdby:     +4.84 V  (min =  +4.76 V, max =  +5.24 V)
> VBat:      +3.02 V
> fan1:     2636 RPM  (min =    0 RPM, div = 8)
> fan2:     3924 RPM  (min =  664 RPM, div = 8)
> fan3:       -1 RPM  (min =  664 RPM, div = 8)
> M/B Temp:    +13?C  (low  =   +15?C, high =   +40?C)   sensor = thermistor   ALARM
> CPU Temp:   +127?C  (low  =   +15?C, high =   +45?C)   sensor = thermistor
> Temp3:       +98?C  (low  =   +15?C, high =   +45?C)   sensor = diode   ALARM
> 
> eeprom-i2c-0-50
> Adapter: SMBus nForce2 adapter at 4c00
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       1024
> 
> lm90-i2c-1-4c
> Adapter: SMBus nForce2 adapter at 4c40
> M/B Temp:    +39?C  (low  =    +0?C, high =  +127?C)
> CPU Temp:  +38.9?C  (low  =  +0.0?C, high = +127.0?C)
> M/B Crit:   +127?C  (hyst =  +117?C)
> CPU Crit:   +127?C  (hyst =  +117?C)

===================================
Jean Delvare wrote:
> Hi David,
> 
> 
>>>How come that you use the lm90 driver while sensors-detect did not
>>>suggest you should do so?
>>
>>sensors-detect >> did << suggest that I use lm90 on the first run.
>>On the second run it apparently did not (possibly because the lm90
>>module was already loaded from the first run?)  I did not notice
>>the inconsistancy in the sensors-detect output from the first and
>>second runs until you pointed it out here.
> 
> 
> This is really strange. Not only it did not suggest that you load the
> lm90 driver (which would be expected as the driver was already loaded)
> but it did not even see a device at a supported address on the SMBus.
> 
> 
>>I then ran "lsmod | grep it87" to see if they had been loaded.
>>Evidently not, since lsmod did not know of them.  So that's
>>when I rebooted ... to give everything a chance to get
>>settled down and loaded.
> 
> 
> Actually you could have loaded them manually at this point. But on
> second thought it's great you didn't, because it seems to demonstrate
> that the problem was caused by sensors-detect itself rather than any
> hardware monitoring drivers.
> 
> The lm90 and it87 drivers are fairly reliable by now, so I would have
> been surprised that they could trigger the problem you described by
> just loading them. Please let us know if they will now work properly.
> 
> That being said, I also don't quite see how sensors-detect could have
> done that either. You don't seem to have any exotic hardware in there.
> 
