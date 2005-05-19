From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <eWd5UQ7B.1111655856.9782620.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Okay, appended is via686a as it was the cleanest conversion to new
> set fan_div with the suggested locking.  This patch has twice been
> proposed for comment.  Hopefully a little better each time.

True, improving over time and tries. Not perfect yet though (sorry). See
right below.

> Next step is to force a delay before driver can reacquire the lock
> to guarantee any particular driver cannot DoS the i2c bus.  Then
> I would feel much more at ease with system operation.

As Mark explained, typically only root can write, and root is omnipotent
anyway. There is no point in attempting to prevent him/her from doing
anything. Also this would significantly slow down "sensors -s".
Significant drawback, little benefit (if any). Don't do it! ;)

> This patch updates via686a to report an error when an unsupported
> set fan_div value is requested, the patch also skips update where
> there is no change and takes the update_lock during the read,
> update, write chips register cycle.

Sounds good.

> Compile tested.  No hardware for functional test.

I have a disconnected via686 chip at home, I'll give a try to your patch
this evening.

>+/*
>+ * DIV_TO_REG subsumed into this function
>+ * Add error reporting for invalid fan divisor input
>+ * Skip updating when no change in divisor
>+ * Adjust fan_min to match new divisor
>+ */
>+

Your comments should focus on what the driver now does, and not the
changes made. In the future, the comment about DIV_TO_REG will make no
sense to the reader, since this function is gone. Same goes for "Add",
what really matters is what the function does now, not the fact that it
used not to do it. Oh, and no blank line between comment and function
please.

>-	int val = simple_strtol(buf, NULL, 10);
>+	int new, val = simple_strtol(buf, NULL, 10);

If you'd add "new" on its own line, it would make the patch more
readable, and reduce the risk of patch rejection.

> 	int old = via686a_read_value(client, VIA686A_REG_FANDIV);

Move variable declaration to the top of the block. Your compiler might
not care, but olders do. Could be made an u8, BTW.

>+	long min = FAN_FROM_REG(data->fan_min[nr],
>+					DIV_FROM_REG(data->fan_div[nr]));

Ditto. Maybe this should be made unsigned, too.

These details left apart, looks functionally correct.

Thanks,
--
Jean Delvare
