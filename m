From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: Xeon II motherboard and CPU temp readings
Message-Id: <20040630012103.GE3064@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.GSU.4.58.0406181602240.12794@adore.lightlink.com>
In-Reply-To: <Pine.GSU.4.58.0406181602240.12794@adore.lightlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Homer Wilson Smith <homer@lightlink.com> [2004-06-19 00:52:12 -0400]:
>     You may have whatever accounts, e-mail web page space
> you need to help support the i2c or lm packages.

That's very generous!  I may contact you later if I have a need.
I was really just half-joking...

>     I have installed the newest of both on a machine that
> is locking up every couple of hours which is why this is
> driving me nuts.

Ah, have you tried memtest86?  http://www.memtest86.com/
Let it run for a week if you have the time - seriously.

Just for the record, what mainboard is it?

>     The bios shows the cpu temps to be normal, but the sensors
> is still only showing one temp.

I assume the BIOS shows two CPU temps and a system temp, right?

>     Fans show up in the MAX driver, examples mailed separately.

I assume these match the BIOS and you're satisfied with them, right?

BTW: You emailed the rest directly to me, but I've been traveling.
Please continue to reply to the mailing list... you could get
the experience of more people that way (and leave a trail for
others to follow).

* Homer <root@ej0.lightlink.com> [2004-06-19 00:46:40 -0400]:
> 
>     Compiled and installed latest, and nuked oldest :)
> 
>     Fans work on MAX, but temp1 only works on w83.
> 
>     The w83627hf module does not work at all, although it loads, it
> returns nothing.
> 
>     The w83781d module loads but returns the below.

If the w83781d is already loaded, it will prevent the w83627hf from
attaching to the sensor chip.  See if it works when you *only* load
the latter.

> Script started on Sat Jun 19 00:45:07 2004
> superoot ej0/root: sensors 
> adm1023-i2c-0-18
> Adapter: SMBus I801 adapter at 7020
> Board:       +25 C  (low  =   +20 C, high =   +60 C)  
> CPU:         +28 C  (low  =   +20 C, high =   +60 C)  

How do these match up with your BIOS readings?  The easiest way to
determine which are CPU temps is to run something CPU intensive for 
several minutes and watch for the temps to jump.  A kernel compile
(with 'make -j4' for your dual Xeons) should do this for you.

The system temp may rise as well, but not as much and more slowly.

> w83627hf-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.49 V  (min =  +1.28 V, max =  +1.41 V)              
> VCore 2:   +1.79 V  (min =  +1.28 V, max =  +1.41 V)              
> +3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.46 V)              
> +5V:       +5.01 V  (min =  +4.74 V, max =  +5.24 V)              
> +12V:     +12.58 V  (min = +10.83 V, max = +13.19 V)              
> -12V:      +1.69 V  (min = -13.16 V, max = -10.90 V)              
> -5V:       +0.17 V  (min =  -5.26 V, max =  -4.76 V)              
> V5SB:      +5.61 V  (min =  +4.74 V, max =  +5.24 V)              
> VBat:      +2.98 V  (min =  +2.40 V, max =  +3.60 V)              
> fan1:        0 RPM  (min = 3000 RPM, div = 2)                     
> fan2:        0 RPM  (min = 3000 RPM, div = 2)                     
> fan3:        0 RPM  (min = 3000 RPM, div = 2)                     
> temp1:       +54 C  (high =   +60 C)                     sensor = PII/Celeron diode           
> temp2:    +127.5 C  (high =   +60 C, hyst =   +50 C)   sensor = PII/Celeron diode   ALARM   
> temp3:    +127.5 C  (high =   +60 C, hyst =   +50 C)   sensor = PII/Celeron diode   ALARM   
> vid:      +1.350 V
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm disabled
> 
> max6650-i2c-0-1b
> Adapter: SMBus I801 adapter at 7020
> fan1:     configured 238125 RPM, actual    0 RPM.
> fan2:        0 RPM  
> fan3:     6150 RPM  
> fan4:     6270 RPM  
> 
> superoot ej0/root: ^Dexit
> 
> Script done on Sat Jun 19 00:45:16 2004
> 

I think you're pretty close, really.  Just try the couple things I
mentioned and let us know how it works out.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

