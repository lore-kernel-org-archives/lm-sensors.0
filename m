From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Apr 2007 09:44:45 +0000
Subject: Re: [lm-sensors] lmsensors in 2.6.16 on a Tyan 2882-D motherboard,
Message-Id: <20070419114445.0daa82ad@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <44325498.8060805@corky.net>
In-Reply-To: <44325498.8060805@corky.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 18 Apr 2007 13:46:26 +0100, Just Marc wrote:
> I'm still getting these weird reading with the latest versions: 
> lmsensors 2.10.3  kernel: 2.6.20.7
> 
> Hopefully someone can shed some light.   Current output below.
> 
> Thanks!
> 
> 
> box:~/lm_sensors-2.10.3# /usr/local/bin/sensors -v
> sensors version 2.10.3 with libsensors version 2.10.3
> box:~/lm_sensors-2.10.3# /usr/local/bin/sensors  
> w83627hf-isa-0290
> Adapter: ISA adapter
> CPU2 Volt: +1.42 V  (min =  +1.33 V, max =  +1.47 V)             
> CPU1 Volt: +1.44 V  (min =  +1.33 V, max =  +1.47 V)             
> 3.3V:      +3.30 V  (min =  +3.14 V, max =  +3.47 V)             
> DDR VTT:   +1.30 V  (min =  +2.85 V, max =  +3.47 V)       ALARM 
> DDR 2.5V:  +2.56 V  (min =  +0.34 V, max =  +0.80 V)       ALARM 
> CPU2 Fan: 3924 RPM  (min = 7670 RPM, div = 8)              ALARM 
> CPU1 Fan: 3443 RPM  (min = 1430 RPM, div = 8)                    
> Fan5:        0 RPM  (min =  730 RPM, div = 8)              ALARM 
> vid:      +1.400 V  (VRM Version 2.4)
> alarms:  
> beep_enable:
>           Sound alarm enabled

I don't see anything weird here. Just the limits of the two DDR
voltages and fans 1 and 3 need to be set to sensible values, and you're
done.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
