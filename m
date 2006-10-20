From: paul.aviles@nickelnetworks.com (Paul Aviles)
Date: Fri, 20 Oct 2006 16:31:55 +0000
Subject: [lm-sensors] Determine where the thermal sensors are?
Message-Id: <200610241632.k9OGW4uX017494@srv1.nickelnetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200610192118.k9JLINDa006525@et-mia-7.site.stayonline.net>
In-Reply-To: <200610192118.k9JLINDa006525@et-mia-7.site.stayonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Nice server....
[root at srv1 /]# sensors
eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 1480
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

adt7463-i2c-0-2e
Adapter: SMBus I801 adapter at 1480
ERROR: Can't get alarm mask data!
+2.6V:     +2.617 V  (min =  +2.47 V, max =  +2.73 V)
CPU Volt:  +1.365 V  (min =  +1.25 V, max =  +1.52 V)
+3.3V:     +3.425 V  (min =  +3.13 V, max =  +3.47 V)
+5V:      +5.072 V  (min =  +4.74 V, max =  +5.26 V)
ERROR: Can't get IN4 data!
Fan2:      5769 RPM  (min = 4800 RPM)
Fan3:      4144 RPM  (min = 2200 RPM)
Fan1:      5769 RPM  (min = 4800 RPM)
CPU Temp: +47.75?C  (low  =    +5?C, high =   +68?C)
Loc Temp: +38.00?C  (low  =    +5?C, high =   +40?C)
Sys Temp: +40.75?C  (low  =    +5?C, high =   +50?C)
ERROR: Can't get PWM1 data!
ERROR: Can't get PWM2 data!
ERROR: Can't get PWM3 data!

[root at srv1 /]# sensors -version
sensors version 2.8.7 with libsensors version 2.8.7

Loud one..
[root at andeya1 /]# sensors
eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 1480
Memory type:            DDR SDRAM DIMM
Memory size (MB):       1024

adt7463-i2c-0-2e
Adapter: SMBus I801 adapter at 1480
ERROR: Can't get alarm mask data!
+2.6V:     +2.604 V  (min =  +2.47 V, max =  +2.73 V)
CPU Volt:  +1.362 V  (min =  +1.25 V, max =  +1.52 V)
+3.3V:     +3.403 V  (min =  +3.13 V, max =  +3.47 V)
+5V:      +5.072 V  (min =  +4.74 V, max =  +5.26 V)
ERROR: Can't get IN4 data!
Fan2:     11157 RPM  (min = 4800 RPM)
Fan3:     10671 RPM  (min = 2200 RPM)
Fan1:     11180 RPM  (min = 4800 RPM)
CPU Temp: +42.75?C  (low  =    +5?C, high =   +68?C)
Loc Temp: +40.00?C  (low  =    +5?C, high =   +40?C)
Sys Temp: +44.50?C  (low  =    +5?C, high =   +50?C)
ERROR: Can't get PWM1 data!
ERROR: Can't get PWM2 data!
ERROR: Can't get PWM3 data!

[root at andeya1 /]# sensors -version
sensors version 2.8.7 with libsensors version 2.8.7

I am sure the issue is not really related to sensors and more likely
something weird in the hardware.

Regards,

Paul Aviles 

-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Friday, October 20, 2006 10:14 AM
To: Paul Aviles
Cc: lm-sensors at lm-sensors.org
Subject: Re: [lm-sensors] Determine where the thermal sensors are?

Hi Paul,

On Thu, 19 Oct 2006 17:18:21 -0400, Paul Aviles wrote:
> I have a weird question. The system I use are all the same, and one of 
> them is really quiet and the others are somewhat louder in regards to 
> the fans. I have all of them in the same rack and with the same 
> hardware (memory, hard d, etc) and the same BIOS config, revision and OS
level and sensors version.
> Still, only one unit works smoothly and the other are loud. I called 
> the manufacturer (Tyan) and they don't know why they will be different 
> or where the sensors are located on the motherboard. So, is there a 
> way to find out by looking at the chips? My theory is that somehow 
> some of them are getting a bit more air flow to certain areas thus making
the fans rpm a bit lower.
> The chip is an lm85 or similar/compatible. 

You can usually find the chip itself on the board, but you can't see the
sensors, as they are very small and not really distinguishable. The only way
I know of to physically locate the thermal sensors is to probe the board
with a air dryer while watching the output of "watch -n 1 sensors". Your
hardware may or may not like it ;)

If you have sensors working on all systems you should be able to check
whether there are actual differences in the reported temperature and fan
speeds. Care to share the data with us, comparing the silent system with a
loud one?

--
Jean Delvare



