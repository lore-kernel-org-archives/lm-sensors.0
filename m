From: mattze@t-online.de (Matthias Mohr)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: beep alert
Message-Id: <200504161025.02004.mattze@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200504122102.01732.mattze@t-online.de>
In-Reply-To: <200504122102.01732.mattze@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok, 

Thanks a lot. It was easier than I have thought. :-)

I corrected the minimum rate of fan2 and fan3 and now it works without the 
beep alert.

Regards
Matthias Mohr


Am Freitag, 15. April 2005 19:03 schrieb Jean Delvare:
> Hi Matthias,
>
> > This is the message I got after running sensors. So you can see which
> > chip is  used.
> >
> > it87-isa-0290
> > Adapter: ISA adapter
> > VCore 1:   +1.69 V  (min =  +1.20 V, max =  +1.80 V)
> > VCore 2:   +1.79 V  (min =  +1.69 V, max =  +2.60 V)
> > +3.3V:     +3.34 V  (min =  +2.96 V, max =  +3.63 V)
> > +5V:       +4.99 V  (min =  +4.49 V, max =  +5.48 V)
> > +12V:     +11.76 V  (min = +10.80 V, max = +13.16 V)
> > -12V:     -19.38 V  (min = -21.61 V, max = -10.95 V)
> > -5V:       -8.44 V  (min =  -9.01 V, max =  -4.50 V)
> > Stdby:     +5.07 V  (min =  +4.49 V, max =  +5.48 V)
> > VBat:      +2.03 V
> > fan1:     4218 RPM  (min =    0 RPM, div = 8)
> > M/B Temp:    +25?C  (low  =   +15?C, high =   +40?C)   sensor > > thermistor CPU Temp:    +25?C  (low  =   +15?C, high =   +45?C)   sensor
> > = thermistor Temp3:       +46?C  (low  =   +15?C, high =   +65?C)  
> > sensor = diode
>
> Try removing the "ignore fan2" and "ignore fan3" lines in the it87-*
> section of /etc/sensors.conf. Maybe these inputs are out of range,
> causing alarms you don't see because the "ignore" statements hide them.
> The "ignore" statements only tell "sensors" not to display the lines, it
> doesn't disable them at driver/device level.
>
> You can also check the file /sys/bus/i2c/devices/0-0290/alarms. It
> should read 0. If it doesn't, please provide its value.

-- 
joining is free and everybody is welcome to join:

? www.hospitalityclub.org

the aim is to bring people together - hosts and guests, travelers and locals
--------------
matthias mohr
icq: 156971883
