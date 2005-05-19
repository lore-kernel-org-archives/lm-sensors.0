From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: Ticket 1834 Update
Message-Id: <20041205100419.51a41230.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41B1D44F.4090303@vfx.to>
In-Reply-To: <41B1D44F.4090303@vfx.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > >The chip on the MSI KT8 Neo is actually a Winbond w83697hf and is
> > > not detected correctly during sensors-detect.
> >
> > What was sensors-detect detecting? Please attach the complete log.
>
> Log is attached...
> (...)
> Probing for `Winbond W83697HF Super IO Sensors'
>   Success... found at address 0x0290
> (...)

Well it looks like a correct detection to me.

Also, you seem to have an unrecognized I2C/SMBus device at address 0x2f.
Could you please provide a dump of it (i2cdump 0 0x2f or i2cdump 1 0x2f
after loading i2c-viapro, depending on the bus number your SMBus
received)?

> > (...) Maybe you need to adjust the PWM clock. (...)
> 
> Actually this works great! I have set it to 25 and it scales good now.
> 
> isaset 0x295 0x296 0 25
> 
> Here the pwmconfig output:
> 
> Testing pwm control 1-0290/fan1_pwm ...
>   1-0290/fan1_input ... speed was 2777 now 0
>     It appears that fan 1-0290/fan1_input
>     is controlled by pwm 1-0290/fan1_pwm
> Would you like to generate a detailed correlation (y)?
>     PWM 255 FAN 3245
>     PWM 240 FAN 3245
>     PWM 225 FAN 3214
>     PWM 210 FAN 3199
>     PWM 195 FAN 3183
>     PWM 180 FAN 3154
>     PWM 165 FAN 3139
>     PWM 150 FAN 3110
>     PWM 135 FAN 3082
>     PWM 120 FAN 3082
>     PWM 105 FAN 3040
>     PWM 90 FAN 3013
>     PWM 75 FAN 2960
>     PWM 60 FAN 2922
>     PWM 45 FAN 2824
>     PWM 30 FAN 2755
>     PWM 15 FAN 0
>     Fan Stopped at PWM = 15

Wow. Glad it work, I didn't really expected it to. Are you using some
unconventional fan? You might want to try different clock values, since
the speed curve is still not perfect.

> What would be the "nicest" way of setting these values? I would
> suggest putting it into /etc/modules.conf:
> 
> post-install w83627hf /usr/sbin/isaset -y 0x295 0x296 0 25 > /dev/null
>              2> /dev/null
> 
> Ok? Or is there a better/safer way?

The driver doesn't need to be loaded for it to work (and actually it
would probably be better to run isaset before it is) so I would do a
pre-install. Alternatively you can run the command from any init script,
it doesn't really matter.

In cas you need it, the register for PWM 2 is 0x02 and works exactly the
same.

I'll update and close ticket #1384 now.

> Thanks a lot. Cheers,

You're welcome :)

-- 
Jean Delvare
http://khali.linux-fr.org/
