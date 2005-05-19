From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: [RFC PATCH] I2C adm9240 driver, second round
Message-Id: <7Usrhyq6.1113314361.7103790.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <10hm51pcfe9aqb87f8ki18ht3runithc0v@4ax.com>
In-Reply-To: <10hm51pcfe9aqb87f8ki18ht3runithc0v@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Problems: libsensors can't read temperature, I do not know why.

You named the hysteresis file temp1_hyst, while libsensors expects
temp1_max_hyst (and is right at that).

> Removed:
>	vrm r/w accessor
>	fan_div r/w accessor
>	unused macros

Sounds good to me.

> Added:
>	chassis intrusion latch clear write-only accessor: echo 1 > ci_clear
>	automatic fan clock divider control, documented in a separate post
>	analog output
>	generalised scaling macros for integer scaling with rounding

Sounds good too.

> Changed:
>	measurement cycle no longer reads entire chip, just the 12
>	measurement values, controls and limits are read on an
>	as-needed basis -- I've noticed an improvement as the chip
>	reads 12 rather 33 single byte values, previous to this change
>	I could notice measurement updating delay on text terminal.

Caching register values forever is a bad idea. Sometimes the BIOS or
something will access the chip in your back, and if you never refresh
the register values you'll never find out.

It was underlined before on this mailing-list that caching belang to the
application more than the driver. We do caching for technical reasons
(not to stop the chip from monitoring).

If you want to speed up the registers refresh, I would invite you to take
a look at the lm85 driver. It has different cache lifetime for
measurements and limits. This is still discussable but at least doesn't
cache any register value forever.

>	decrease measurement lockout from 2 to 3/2 seconds

Are you sure that all three supported chips can refresh the measurement
in less than 2 seconds? I think I remember that one of them is slower,
wich explaied the 2 seconds.

>	vid report uses external vrm for scaling and does not store copy
>	of vrm.

I am not sure I understand what you mean by "external vrm". The VRM
value is guessed from the CPU model by a kernel helper, so it's by
definition internal.

Not caching the vrm value is a bad idea, as the helper is not trivial.
The overhead of having an additional u8 to store the vrm version is
definitely overweighted by the speed up.

More comments on the code itself (possibly) later.

Thanks,
--
Jean Delvare
