From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <J8KP1J8i.1111680149.6990440.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Philip,

> I think both cases are problematic.  It doesn't matter which order you
> do the writes, if you attempt to cache the value written to the
> register, then you must do that atomically.  Otherwise, the following
> can potentially occur and lead to the wrong result:
> 
>     Thread A                Thread B
>     Write first value
>                             Write first value
>                             Write second value
>     Write second value
> 
> End result is second value is Thread A and first value is Thread B.
>
> Without locking, this sort of sequence is possible.  As long as you have
> to update two values in different locations, you've got to have some
> kind of locking or synchronization.

My original case was different as it had only one value being written,
but you got point in that there *are* cases where we actually write to
several registers.

All in all, I think we made it clear that all sysfs callbacks which write
to a register and update the cache need locking. If a few ones don't
need it for obscure reasons, it's probably not a problem to still lock
there, as this will prevent the introduction of race conditions in the
future for a very small price.

Thanks,
--
Jean Delvare
