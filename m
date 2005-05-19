From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: lm_sensors 2.8.3
Message-Id: <20040130193851.546343eb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401291139.58838.jumpyboy@infinito.it>
In-Reply-To: <200401291139.58838.jumpyboy@infinito.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> it87-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore 1:   +1.76 V  (min =  +1.53 V, max =  +1.87 V)
> VCore 2:   +0.00 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
> +3.3V:     +6.46 V  (min =  +2.96 V, max =  +3.60 V)   ALARM
> +5V:       +4.86 V  (min =  +4.50 V, max =  +5.48 V)
> +12V:     +12.52 V  (min = +11.36 V, max = +13.80 V)
> -12V:     -27.36 V  (min = -15.86 V, max = -13.40 V)   ALARM
> -5V:      -13.64 V  (min = -10.13 V, max =  -9.44 V)   ALARM
> Stdby:     +4.97 V  (min =  +4.50 V, max =  +5.48 V)
> VBat:      +4.08 V
> fan1:     3729 RPM  (min = 3000 RPM, div = 2)
> fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> ERROR: Can't get TEMP1 data!
> ERROR: Can't get TEMP2 data!
> ERROR: Can't get TEMP3 data!
> (...)
> Why I cannot get temperature?

This is a FAQ. Support for the it87 is broken in the Linux 2.6.1 +
lm_sensors 2.8.3 combination, which is the one you are using. Either
downgrade to lm_sensors 2.8.2 or upgrade to lm_sensors CVS.

> All those ALARM depend on /etc/sensors.conf? I have to change that file?

First of all, make sure you did not forget to run "sensors -s". This
configures the chipset.

Then, yes you have to edit /etc/sensors.conf. Look for the "it87-*"
section and edit to fit your hardware. You obviously can add "ignore"
statements for in1 (VCore 2) and probably fan2 and fan3 (I guess you
don't have these fans).

For +3.3V, there's a line to change in the configuration file. It's
commented inside, you should find it easily.

Your values for negative voltages are really strange. If they don't get
any better after you running "sensors -s", it may simply mean that these
inputs are not wired to the monitoring chipset and you can ignore them
too. If your BIOS setup screen shows some hardware monitoring values but
there's nothing for negative voltages, it's probably the case.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
