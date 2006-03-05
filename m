From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 05 Mar 2006 20:34:54 +0000
Subject: [lm-sensors] [PATCH 1/1] i2c: m41txx driver for ST i2c RTC chips
Message-Id: <440B4B6E.8080307@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060217011359.GA16247@mag.az.mvista.com>
In-Reply-To: <20060217011359.GA16247@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again,

> to get an idea what that patch would look like.

Good that is what I wanted to see :)

> I presume you mean the i2c addr.  If that's correct, then that address is
> passed into the driver via platform_data.  Look at
> include/linux/m41txx.h then search for 'i2c_addr' in the driver. 

Yep I done that. This assumes that people using this driver must fix it to support
it through the platform data...

>>I tried to review the driver and seems OK to me.
> 
> 
> Thanks for taking the time to look at it.

Lets wait when Jean will have some little time to look into it.

Regards
Rudolf

