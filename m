From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

Requesting information on two issues, taking a the lock for 
read/modify/write i2c chip update cycles, and rate limiting 
write access to i2c bus to prevent user-space DoS on the i2c 
bus with continuous update requests.

i2c locking:

Thinking about the fan_div setting, it is a read/modify/write 
(RMW) operation to a chip register, should we take action to 
prevent another process accessing the chip on i2c during this 
RMW action?

What I'm thinking is sort of:
..
	if new_div not in (valid_divisor_set)
		return error message
	~
	read old_div
	if (new_div = old_div)
		goto exit
	read fan_min
	adjust fan_min
	write new_div
	write fan_min
exit:
	~
..

Should we hold exclusive access to i2c bus + chip between the 
tildes above?  Or is my thinking bounding too far into highly 
unlikely events?


preventing DoS, updating i2c bus chips

Another query, we take care not to read chip too frequently, 
what stops user-space DoS'ing the i2c bus with continuous 
writes by constant update requests?  

Two methods come to mind:

a cheap block until minimum write interval elapsed enforced 
perhaps by not granting lock_request until minimum period 
elapsed?

a more expensive delayed write data buffer (~100 .. ~500ms?) 
would allow aggregation of update operations and take over 
the i2c bus at a controlled maximum duty cycle.

The first method may upset user-space with a delay between 
updates, but is easy/safe to implement.

The second method is far more invasive -- not all drivers 
have clean data structures that reflect the chip registers, 
eliminating them from this type of cleanup until they're 
fixed.

Thanks,
Grant.
