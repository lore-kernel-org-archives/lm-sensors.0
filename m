From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 08 Oct 2006 17:03:52 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <20061008190352.8efb5377.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Michael,

> [root at matrix ~]# sensors
> pc87427-isa-0840
> Adapter: ISA adapter
> case-fan1:3678 RPM  (min = 2000 RPM)
> case-fan2:3391 RPM  (min = 2000 RPM)
> case-fan3:3400 RPM  (min = 2000 RPM)
> case-fan4:3366 RPM  (min = 2000 RPM)
> not-inst:    0 RPM  (min =    0 RPM)          FAULT
> CPU0-fan: 2915 RPM  (min = 2000 RPM)
> not-inst:    0 RPM  (min =    0 RPM)          FAULT
> CPU1-fan: 2830 RPM  (min = 2000 RPM)

You can add the following to your configuration file:

   ignore fan5
   ignore fan7

That way the unused fan inputs won't even show in the output, making it
a bit more user-friendly.

> [root at matrix ~]# tail -n 17 /etc/sensors.conf
> chip "pc87427-*"
>    label fan1 "case-fan1"
>    label fan2 "case-fan2"
>    label fan3 "case-fan3"
>    label fan4 "case-fan4"
>    label fan5 "not-inst"
>    label fan6 "CPU0-fan"
>    label fan7 "not-inst"
>    label fan8 "CPU1-fan"
>    set fan1_min 2000
>    set fan2_min 2000
>    set fan3_min 2000
>    set fan4_min 2000
>    set fan5_min 0
>    set fan6_min 2000
>    set fan7_min 0
>    set fan8_min 2000

I'd suggest that you get rid of the default configuration file
completely and write one from scratch with simply the section above,
libsensors will perform much better.

> JFYI, if I put fan[1-4]_min on 3000, the fans start running at about
> 4500RPM, giving quite a cool ambiance in the chassis. :)
> 2000 should be enough.

I have been playing a bit with a similar board lately and noticed the
same. The low limits seem to somehow influence the fan speeds. I know
that the PC87427 has fan speed control features, but I didn't read the
datasheet in its entirety so I don't know how it works exactly. At any
rate this behvior differers completely from what other chips do.
Usually the low limits simply trigger alarms when crossed, and do not
influence the speed itself.

OK, now that it works, I will have to clean up the driver to make it
suitable for upstream submission. In particular this implies converting
the driver from an i2c-isa driver to a platform driver. Will you be
able to test this second variant of the driver?

Thanks,
-- 
Jean Delvare

