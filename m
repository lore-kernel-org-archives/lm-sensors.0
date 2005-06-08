From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 08 Jun 2005 19:09:14 +0000
Subject: [lm-sensors] Re: sclhi retval not tested in i2c-algo-bit.c
Message-Id: <20050608190817.71777c8f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050604201931.4e533021.khali@linux-fr.org>
In-Reply-To: <20050604201931.4e533021.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Karel,

Please answer to the mailing-list rather than to me only.

> The device is I2C2P http://i2c2p.twibright.com
> It's an optically isolated parport <-> I2C converter which is
> bidirectional in both SDA and SCL. The half near PC is powered from
> the parallel port, the other half externally.
> 
> Normally, the adapter supports SCL readback. However when the remote
> part is not powered, SCL readback doesn't work. As the power applied
> to the remote half is independent from PC power (typical use is to
> hook it up to some device with 24C16 inside and using it for
> brainwashing the device), this can normally happen.

Except that you should not load a driver for unpowered hardware, as the
i2c subsystem doesn't support any kind of hotplugging.

You mentioned the fact that you had a long delay at boot time when the
"second half" was not powered on. This shouldn't happen. Even without
anything plugged on the parport, i2c-parport loads without any delay, I
just tested. This is quite logical because neither sda nor scl are read
back at i2c-parport load time (unless you set i2c_algo_bit.test_bit to
1). So I suspect that you additionally load i2c chip drivers, or run
user-space commands which generate traffic on the adapter, and this is
what causes the long delay. Please investigate in this direction.

> I have already sent you my newest patch for I2C2P which incorporated
> this. Please look at it.

Yes, I got it. BTW, it would be better if you could send patches to this
mailing-list rather than to me only. More eyes is better, and I am
rather busy myself (as you must have noticed by now). Especially the
proposed changes to i2c-algo-bit need an in-deep review (and should
really be a separate patch). This code is used by 69 drivers in the
kernel only, which I wouldn't want to break.

Thanks,
-- 
Jean Delvare
