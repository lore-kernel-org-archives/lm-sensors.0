From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 May 2011 16:44:10 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110513184410.1b60d368@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 13 May 2011 09:42:28 -0600, Harry G McGavran Jr wrote:
> This new i8k seems to work on my system. 
> 
> ====================> 
> XX% /usr/bin/sensors
> i8k-virtual-0
> Adapter: Virtual device
> Left Fan:   64650 RPM
> Right Fan:  48390 RPM

As said before, you'd need option fan_mult=1 to get proper readings.
But well, in the long run I guess you'll stop using i8k anyway, as it
provides fewer values than the emc6w201 driver.

> emc6w201-i2c-0-2e
> Adapter: SMBus I801 adapter at e8a0
> Aux:            +1.82 V  (min =  +1.64 V, max =  +1.98 V)
> CPU VCore:      +1.26 V  (min =  +0.78 V, max =  +1.70 V)
> +3.3V:          +3.33 V  (min =  +3.08 V, max =  +3.52 V)
> +5V:            +5.10 V  (min =  +4.66 V, max =  +5.34 V)
> +12V:          +12.06 V  (min =  +0.81 V, max = +12.81 V)
> Chassis:       1613 RPM  (min =  300 RPM)
> CPU:           2153 RPM  (min =  200 RPM)
> CPU:            +54.0 C  (low  = -127.0 C, high = +88.0 C)  
> Remote Diode 5: +48.0 C  (low  = -127.0 C, high = +75.0 C)  
> Mainboard:      +44.0 C  (low  = -127.0 C, high = +80.0 C)  
> 
> =======================> 
> The only entry in syslog as a result of the above is:
> 
> May 13 09:37:40 kahu kernel: [167232.194108] i8k: unable to get SMM BIOS 
> version
> 
> but that has occurred with all the i8k's I've tried.

Looks very promising. Now let's wait for Jeff's report.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
