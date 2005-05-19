From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: fan out of control (lm-sensors 2.6.2-1)
Message-Id: <20011222162850.A4163@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E16HU06-0006Nj-00@ernie.physik.uni-marburg.de>
In-Reply-To: <E16HU06-0006Nj-00@ernie.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Boy, that is odd.  It's like the Bios or something else is trying to
set the limits as well.  Or perhaps the chip is power-cycled during
the event, which causes it to reset to defaults?  Or, another idea is
that your distibution has a daemon or something running which might be
setting values?  I'm at a loss. :'(

At the end you note that a sensors -s only partially fixes the
situation.  What if you remove the module, re-insmod it, and then do a
'sensors -s'.  Does it return to the state that you show after the
first 'sensors -s'?  If so, then it's likely that the chip is
power-cycled during a suspend which loses it's config/limits settings. 
Removing the driver and reinstalling it causes it to be reinitialized. 


Phil


On Sat, Dec 22, 2001 at 08:05:58PM +0100, Marcus Eger wrote:
> On Friday 21 December 2001 19:31, phil@netroedge.com wrote:
> > Are you doing a 'sensors -s' (as root) to set those values?  Otherwise
> > they will never be set.  Fans usually have different high and low
> > thresholds for turning on and turning off.  I.e., it might need to get
> > to 60 degrees to turn the fan on, but might need to go down to 50
> > before it shuts off.
> >
> >
> > Phil
> 
> Directly after booting I get 
> ##############################################
> dimbel:~# sensors
> lm80-i2c-0-2c
> Adapter: SMBus PIIX4 adapter at 0440
> Algorithm: Non-I2C SMBus adapter
> +5V:       +6.71 V  (min =  +6.71 V, max =  +6.71 V)
> VTT:       +2.55 V  (min =  +2.55 V, max =  +2.55 V)
> +3.3V:     +4.43 V  (min =  +4.43 V, max =  +4.43 V)
> +Vcore:    +3.76 V  (min =  +3.76 V, max =  +3.76 V)
> +12V:     +16.10 V  (min = +16.10 V, max = +16.10 V)
> -12V:     -16.11 V  (min = -16.11 V, max = -16.11 V)
> -5V:       -6.70 V  (min =  -6.70 V, max =  -6.70 V)
> fan1:        0 RPM  (min =    0 RPM, div = 8)
> fan2:        0 RPM  (min =    0 RPM, div = 8)
> temp:     -0.06 ?C (hot:limit =  -1?C,  hysteresis =  -1?C) ALARM
>          (os: limit =  -1?C,  hysteresis =  -1?C) ALARM
> 
> max1617-i2c-0-4e
> Adapter: SMBus PIIX4 adapter at 0440
> Algorithm: Non-I2C SMBus adapter
> temp:        +62?C  (min =  +20?C, max =  +60?C)ALARM (HIGH)
> remote_temp:
>              +47?C  (min =  -65?C, max = +127?C)
> 
> 
> if I do this, everything seems ok....
> ##############################################
> dimbel:~# sensors -s
> dimbel:~# sensors
> lm80-i2c-0-2c
> Adapter: SMBus PIIX4 adapter at 0440
> Algorithm: Non-I2C SMBus adapter
> +5V:       +6.71 V  (min =  +6.71 V, max =  +6.71 V)
> VTT:       +2.55 V  (min =  +2.55 V, max =  +2.55 V)
> +3.3V:     +4.43 V  (min =  +4.43 V, max =  +4.43 V)
> +Vcore:    +3.76 V  (min =  +3.76 V, max =  +3.76 V)
> +12V:     +16.10 V  (min = +16.10 V, max = +16.10 V)
> -12V:     -16.11 V  (min = -16.11 V, max = -16.11 V)
> -5V:       -6.70 V  (min =  -6.70 V, max =  -6.70 V)
> fan1:        0 RPM  (min =    0 RPM, div = 8)
> fan2:        0 RPM  (min =    0 RPM, div = 8)
> temp:     -0.06 ?C (hot:limit =  -1?C,  hysteresis =  -1?C) ALARM
>          (os: limit =  -1?C,  hysteresis =  -1?C) ALARM
> 
> max1617-i2c-0-4e
> Adapter: SMBus PIIX4 adapter at 0440
> Algorithm: Non-I2C SMBus adapter
> temp:        +61?C  (min =  +57?C, max =  +60?C)ALARM (HIGH)
> remote_temp:
>              +46?C  (min =  +47?C, max =  +50?C)ALARM (LOW)
> 
> 
> 
> after a suspend (brief hit on the power button) the min/max values for
> max1617 are gone...
> ##############################################
> dimbel:~# sensors
> lm80-i2c-0-2c
> Adapter: SMBus PIIX4 adapter at 0440
> Algorithm: Non-I2C SMBus adapter
> +5V:       +6.71 V  (min =  +6.71 V, max =  +6.71 V)
> VTT:       +2.55 V  (min =  +2.55 V, max =  +2.55 V)
> +3.3V:     +4.43 V  (min =  +4.43 V, max =  +4.43 V)
> +Vcore:    +3.76 V  (min =  +3.76 V, max =  +3.76 V)
> +12V:     +16.10 V  (min = +16.10 V, max = +16.10 V)
> -12V:     -16.11 V  (min = -16.11 V, max = -16.11 V)
> -5V:       -6.70 V  (min =  -6.70 V, max =  -6.70 V)
> fan1:        0 RPM  (min =    0 RPM, div = 8)
> fan2:        0 RPM  (min =    0 RPM, div = 8)
> temp:     -0.06 ?C (hot:limit =  -1?C,  hysteresis =  -1?C) ALARM
>          (os: limit =  -1?C,  hysteresis =  -1?C) ALARM
> 
> max1617-i2c-0-4e
> Adapter: SMBus PIIX4 adapter at 0440
> Algorithm: Non-I2C SMBus adapter
> temp:        +60?C  (min =  -65?C, max = +127?C)
> remote_temp:
>              +46?C  (min =  -65?C, max = +127?C)
> 
> 
> this now only partly corrects the values... (the remote min/max
> are still wrong)
> ##############################################
> dimbel:~# sensors -s
> dimbel:~# sensors
> lm80-i2c-0-2c
> Adapter: SMBus PIIX4 adapter at 0440
> Algorithm: Non-I2C SMBus adapter
> +5V:       +6.71 V  (min =  +6.71 V, max =  +6.71 V)
> VTT:       +2.55 V  (min =  +2.55 V, max =  +2.55 V)
> +3.3V:     +4.43 V  (min =  +4.43 V, max =  +4.43 V)
> +Vcore:    +3.76 V  (min =  +3.76 V, max =  +3.76 V)
> +12V:     +16.10 V  (min = +16.10 V, max = +16.10 V)
> -12V:     -16.11 V  (min = -16.11 V, max = -16.11 V)
> -5V:       -6.70 V  (min =  -6.70 V, max =  -6.70 V)
> fan1:        0 RPM  (min =    0 RPM, div = 8)
> fan2:        0 RPM  (min =    0 RPM, div = 8)
> temp:     -0.06 ?C (hot:limit =  -1?C,  hysteresis =  -1?C) ALARM
>          (os: limit =  -1?C,  hysteresis =  -1?C) ALARM
> 
> max1617-i2c-0-4e
> Adapter: SMBus PIIX4 adapter at 0440
> Algorithm: Non-I2C SMBus adapter
> temp:        +58?C  (min =  +57?C, max =  +60?C)
> remote_temp:
>              +44?C  (min =  -65?C, max = +127?C)
> 
> 
> ##############################################
> - thanks for your rapid answer, Phil,
>     Marcus
> 
> 
> 

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
