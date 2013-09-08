From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 08 Sep 2013 15:56:07 +0000
Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
Message-Id: <522C9E17.9010701@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 09/08/2013 07:07 AM, Tomas Larsson wrote:
> I have 2 motherboards, both of the same type.
> They are INTEL D945 with ATOM 330 processor.
> One of them is running CENTOS 5.9, the other one is running CENTOS 6.4, both
> 32-bit versions
>
> After installing lm_sensors and running sensors-detect
> I have the following output:
>
> CENTOS 5.9 sensors version 2.10.7 with libsensors version 2.10.7
>
> [root@BLATUNGA ~]# /etc/rc.d/init.d/lm_sensors status
> smsc47m192-i2c-0-2d
> Adapter: SMBus I801 adapter at 3000
> +2.5V:     +2.53 V  (min =  +0.00 V, max =  +3.32 V)
> Vcore:     +1.15 V  (min =  +0.00 V, max =  +2.99 V)
> +3.3V:     +3.23 V  (min =  +0.00 V, max =  +4.38 V)
> +5V:       +4.92 V  (min =  +0.00 V, max =  +6.64 V)
> +12V:     +11.94 V  (min =  +0.00 V, max = +15.94 V)
> VCC:       +3.25 V  (min =  +0.00 V, max =  +4.38 V)
> +1.5V:     +1.56 V  (min =  +0.00 V, max =  +1.99 V)
> +1.8V:     +1.76 V  (min =  +0.00 V, max =  +2.39 V)
> Chipset Temp:  +44.0°C  (low  =  -127°C, high =  +127°C)
> CPU Temp:  +69.0°C  (low  =  -127°C, high =  +127°C)
> System Temp:  +55.0°C  (low  =  -127°C, high =  +127°C)
> vid:      +2.050 V  (VRM Version 8.2)
>
> smsc47m1-isa-0680
> Adapter: ISA adapter
> Case Fan:    0 RPM  (min = 1280 RPM, div = 4)          ALARM
> CPU Fan:     0 RPM  (min = 1280 RPM, div = 4)          ALARM
> [root@BLATUNGA ~]# sensors -v
> sensors version 2.10.7 with libsensors version 2.10.7
> [root@BLATUNGA ~]#
>
> CENTOS 6.4 sensors version 3.1.1 with libsensors version 3.1.1
>
> [root@seedbox ~]# /etc/rc.d/init.d/lm_sensors status
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +36.0°C  (high = +70.0°C, crit = +90.0°C)
> Core 1:      +36.0°C  (high = +70.0°C, crit = +90.0°C)
> [root@seedbox ~]# sensors -v
> sensors version 3.1.1 with libsensors version 3.1.1
> [root@seedbox ~]#
>
>
> Why is it that the outputs are different, It seems to be impossible to get
> the rest of the output in the 3.1.1 version
>

Hard to say without additional information. What is the output of sensors-detect ?
Is it possible that you did not load the smsc47m1 and smsc47m192 modules on the
second system ? What is the output of lsmod ? Is there anything interesting in dmesg ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
