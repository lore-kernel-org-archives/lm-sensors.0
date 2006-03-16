From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 16 Mar 2006 08:46:51 +0000
Subject: [lm-sensors] sis96x compiled in by error: delay of one minute
Message-Id: <3ZH07HE0.1142498811.4526410.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20060316035916.GA10675@jupiter.solarsys.private>
References: <20060316035916.GA10675@jupiter.solarsys.private>
In-Reply-To: <20060316035916.GA10675@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, Etienne Lorrain <etienne_lorrain@yahoo.fr>, lm-sensors <lm-sensors@lm-sensors.org>


Hi Mark,

On 2006-03-16, Mark M. Hoffman wrote:
> Here's a start: why does i2c-parport[-light] have a default adapter
> type?

I think I made it look as closely as possible like the old
i2c-philips-par driver, which is was replacing, so that users could
switch with the least effort.

> Loading it with the default could be considered an accident by
> definition. It takes ~6 seconds to load all of
> kernel/drivers/hwmon/*.ko on a test box here with i2c-parport-light
> present (but without any adapter hardware). With this patch, that
> drops to ~1 second.

Note that the same result could be achieved by using
i2c_algo_bit.bit_test=1, which is why I was suggesting to make it the
default. Doing so would also help the radeonfb driver users: this one
creates up to 4 i2c busses and at least one does not work for me (I
guess it depends on how the chip was wired on the graphics adapter),
causing significant delays on when loading i2c chip drivers afterwards.

I wonder if i2c_algo_bit.bit_test=1 can cause problems. Why wasn't it
made the default in the first place?

> This patch forces the user to specify what type of adapter is present
> when loading i2c-parport or i2c-parport-light.  If none is specified,
> the driver init simply fails - instead of assuming adapter type 0.
>
> This alleviates the sometimes lengthy boot time delays which can be
> caused by accidentally building one of these into a kernel along with
> several i2c slave drivers that have lengthy probe routines (e.g. hwmon
> drivers).

This makes sense, no adapter type is more likely to be found than the
others. So I like the patch and am willing to accept it. However, given
that it changes the default behavior, and makes the "type" module
parameter mandatory, a short notice in the documentation and/or Kconfig
would be welcome, don't you think?

Thanks,
--
Jean Delvare

