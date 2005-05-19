From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: as99127f bug?
Message-Id: <20031130134504.142f7cde.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> as99127f-i2c-1-2d
> Adapter: SMBus nForce2 adapter at 5500
> Algorithm: Unavailable from sysfs
> VCore 1:   +1.70 V  (min =  +1.49 V, max =  +1.81 V)              
> VCore 2:   +1.70 V  (min =  +1.49 V, max =  +1.81 V)              
> +3.3V:     +3.39 V  (min =  +2.98 V, max =  +3.63 V)              
> +5V:       +4.95 V  (min =  +4.52 V, max =  +5.48 V)              
> +12V:     +11.55 V  (min = +10.82 V, max = +13.13 V)              
> -12V:     -12.14 V  (min =  -0.00 V, max =  -0.00 V)              
> -5V:       -4.60 V  (min =  -0.00 V, max =  -0.00 V)              
> fan1:     4927 RPM  (min = 3000 RPM, div = 2)              ALARM  
> fan2:        0 RPM  (min = 3000 RPM, div = 2)              ALARM  
> fan3:        0 RPM  (min = 3000 RPM, div = 2)              ALARM  
> M/B Temp:    +39?C  (high =  +127?C, hyst =   +60?C)          
> CPU Temp:  +28.0?C  (high =  +120?C, hyst =  +100?C)          
> temp3:    +255.4?C  (high =  +100?C, hyst =  +100?C)          
> vid:      +1.650 V
> alarms:   
> beep_enable:
>           Sound alarm enabled
> 
> M/B and CPU temp are swapped. CPU is 39 and MB 28

I doubt it. It would be physically difficult to do this, unless the
monitoring chip is hardly tied to the CPU. This was never seen. temp1
(here displayed as "M/B Temp") is the monitoring chipset internal
temperature. 39 degrees is exactly what I have for a similar chip here.

CPU Temp (temp2) is probably wrong. Take a look at the configuration
file, there are three different formulae for temp2. Maybe you're using
one that doesn't work for your motherboard. Try the other two.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
