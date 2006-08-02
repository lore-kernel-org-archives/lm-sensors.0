From: cybercorecentre@gmail.com (Jax)
Date: Wed, 02 Aug 2006 13:32:10 +0000
Subject: [lm-sensors] Fan speed on hp d530
Message-Id: <44D0A95A.8090004@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <413680bb0608020106r68fb3903jc8bc40d3f2cc4026@mail.gmail.com>
In-Reply-To: <413680bb0608020106r68fb3903jc8bc40d3f2cc4026@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jon wrote:
> Hi list,
>
>   
Hi!
> I have some problems with setting the fan speed on my hp d530 desktop.
> I saw a ticket (closed) in the tracker #1837 which said it was
> examined/resolved in lm_sensors 2.8.8 Linux 2.6.9. I'm using sensors
> 2.10.0 with kernel 2.6.15-1-686 (debian-testing) and I can't get it to
> work (and the cpu fan sounds like a vacuum cleaner, doing its best to
> drive me nuts). I get reasonable data from everything but the fans:
> # sensors
> adt7463-i2c-0-2e
> Adapter: SMBus I801 adapter at fc00
>
> V1.5:      +0.000 V  (min =  +0.00 V, max =  +3.32 V)   ALARM
> VCore:     +1.339 V  (min =  +0.00 V, max =  +2.99 V)
> V3.3:      +3.283 V  (min =  +0.00 V, max =  +4.38 V)
> V5:       +5.111 V  (min =  +0.00 V, max =  +6.64 V)
> V12:      +0.125 V  (min =  +0.00 V, max = +15.94 V)
> CPU_Fan:      0 RPM  (min =    0 RPM)
> fan2:         0 RPM  (min =    0 RPM)
> fan3:         0 RPM  (min =    0 RPM)
> fan4:         0 RPM  (min =    0 RPM)
> CPU:      +34.25?C  (low  =   +50?C, high =   +55?C)     ALARM
> Board:    +39.00?C  (low  =   +45?C, high =   +50?C)     ALARM
> Remote:   +60.25?C  (low  =   +60?C, high =   +65?C)     ALARM
> CPU_PWM:    57
> Fan2_PWM:  255
> Fan3_PWM:  255
> vid:      +1.387 V  (VRM Version 10.0)
>
> There are no _div-files for the fans:
> ls fan1* pwm1*
> fan1_input  fan1_min  pwm1  pwm1_auto_channels  pwm1_auto_pwm_freq
> pwm1_auto_pwm_min  pwm1_auto_pwm_minctl  pwm1_enable
>
> Running pwmconfig fails with "echo: write error: Input/output error"
> for all three (gives that when trying to write to pwmx_enable).
>
> I know it's possible to control the fans as the co worker having this
> box before me ran windows and he told me he ran some app to limit the
> speed but I can't figure out how to do it in Linux.
>
> Anyone that has a clue?
>
>   
I experience the same problem at the moment with tyan S2466N. I can get 
the sensor data but can't control the fans :(((
And I trying to get work since 3 days, I write letter even to my 
motherboard manufactur, but first I need to go through some insane 
process until I can contact with them so good luck!
If you can control them from windows with speedfan thats a good sign 
man, because I can't :(
Try motherboard monitor too.
> Thanks
> Jon
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>   


