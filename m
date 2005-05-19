From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <20050323063514.GE4309@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant:

* Grant Coady <grant_nospam@dodo.com.au> [2005-03-23 09:25:25 +1100]:
> Hi All,
> 
> Requesting information on two issues, taking a the lock for 
> read/modify/write i2c chip update cycles, and rate limiting 
> write access to i2c bus to prevent user-space DoS on the i2c 
> bus with continuous update requests.
> 
> i2c locking:
> 
> Thinking about the fan_div setting, it is a read/modify/write 
> (RMW) operation to a chip register, should we take action to 
> prevent another process accessing the chip on i2c during this 
> RMW action?

Looks like Philip addressed this one.

> preventing DoS, updating i2c bus chips
> 
> Another query, we take care not to read chip too frequently, 
> what stops user-space DoS'ing the i2c bus with continuous 
> writes by constant update requests?  

Nothing prevents it, except that you need root to do those writes/updates.
Considering all the other damage you can do as root... there's not much
point in any further protection for the I2C bus.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
