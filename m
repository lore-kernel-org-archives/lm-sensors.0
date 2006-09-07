From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 07 Sep 2006 07:59:57 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060907095957.2d716944.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> With the correct SuperIO ID and mask (0xa020/0xfff0) the driver seems to work
> here on:
>   Linux thanatos 2.6.17.7-mh1 #16 SMP PREEMPT Thu Sep 7 00:21:21 CEST 2006
>   i686 Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz GNU/Linux
> 
> But fan5_input (my second case fan) jumps between 0 and something around
> 30000 RPM.

This can happen if you are using fan speed control on 3-wire fans. When
the speed goes really low, the tachometer fails to sense the speed
properly and you get wacky readings. Try restoring the fan to full
speed, the reading should be back. What value is reported in the BIOS?

Also, the w83627ehf driver attempts to automatically pick the best fan
clock divider depending on the fan speed. Maybe tha algorithm has some
issues. If you enable debugging in the driver, it'll tell you the
decisions it takes, that might help pinpoint the problem.

> If I slow down my other case fan by hand (fan1), I'll get wrong values, too
> (around 12000k).

Yes, as I explained above, that's a known issue. This is a physical
limitation, there's not much you can do about that. I have observed the
same here with a different chip a few days ago. Below 50% of its full
speed value, the fan would report wacky speeds.

> Also the fan?_min have some strange values:
>   thanatos device # cat fan?_min
>   10546
>   2960
>   10546
>   10546
>   337500

The low speed limits are uninitialized. It's up to you to set the
values you want. Define them in sensors.conf (e.g. "set fan1_min 2000")
then run "sensors -s" to apply the changes.

-- 
Jean Delvare

