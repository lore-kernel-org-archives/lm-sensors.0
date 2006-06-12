From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Mon, 12 Jun 2006 17:13:38 +0000
Subject: [lm-sensors] [PATCH] I2C: i2c_bit_add_bus should initialize SDA
Message-Id: <m3hd2q47r1.fsf@defiant.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <m34pyyz0e1.fsf@defiant.localdomain>
	<20060609110546.GA26073@jupiter.solarsys.private>
	<m3lks4k5od.fsf@defiant.localdomain>
	<20060612123626.GA27429@jupiter.solarsys.private>
In-Reply-To: <20060612123626.GA27429@jupiter.solarsys.private> (Mark M. Hoffman's message of "Mon, 12 Jun 2006 08:36:26 -0400")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi,

"Mark M. Hoffman" <mhoffman at lightlink.com> writes:

> If you can't read the line state... well, that's not actually a proper
> I2C bus anyway.

Actually you only have to be able to read SDA state, it might not be
true WRT SCL. I think most implementations use a single master and
a fixed access timing and thus only read SDA (SCL can as well be
a simple 2-state normal output from master instead of open
drain/collector or 3-state).

I'm not sure initializing the bus (in terms of ~ handshaking)
belongs to hw driver and not to the algorithm but such is live.

Thanks.
-- 
Krzysztof Halasa

