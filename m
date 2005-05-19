From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: lm78 needs vrm 9.0
Message-Id: <20031124215343.3038234c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069701990.540.3.camel@agaliaretph>
In-Reply-To: <1069701990.540.3.camel@agaliaretph>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Yes, it told me to use it87.
> 
> This is the output I get from sensors:
> 
> eeprom-i2c-0-50
> Adapter: SMBus Via Pro adapter at 0500
> Algorithm: Non-I2C SMBus adapter
>  
> it87-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore 1:   +1.47 V  (min =  +1.53 V, max =  +1.87 V)   ALARM
> VCore 2:   +3.10 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
> +3.3V:     +6.24 V  (min =  +2.96 V, max =  +3.60 V)   ALARM
> +5V:       +5.51 V  (min =  +4.50 V, max =  +5.48 V)   ALARM
> +12V:      +5.92 V  (min = +11.36 V, max = +13.80 V)   ALARM
> -12V:      -2.82 V  (min = -15.86 V, max = -13.40 V)   ALARM
> -5V:       -9.44 V  (min = -10.13 V, max =  -9.44 V)   ALARM
> Stdby:     +0.00 V  (min =  +4.50 V, max =  +5.48 V)   ALARM
> VBat:      +3.20 V
> fan1:     4856 RPM  (min = 3000 RPM, div = 2)
> fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> Temp1/MB:    +34?C  (min =  +20?C, max =  +60?C)
> Temp2/CPU:   -78?C  (min =  +20?C, max =  +60?C)
> Temp3:       +49?C  (min =  +20?C, max =  +60?C)
> 
> I'll take a look at sensors.conf to see if I can get something better.

Didn't you simply forgot to run "sensors -s" after loading the module?

Also, you might consider using a newer version. 2.6.5 is old and we have
been improving almost everything in newer versions.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
