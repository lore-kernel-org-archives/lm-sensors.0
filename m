From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <4240BADF.8040908@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The ADM1026 and LM85 drivers should be requesting the semaphore on the 
internal per-chip data structure before doing any modification of the 
fan_div.  In that way there is only one writer to the data structure and 
consistency should be enforced.  If someone pokes at the hardware 
without going through the driver there isn't much we can do...

With 2.6 (and perhaps 2.4?) there are one-writer or multiple reader 
locks that might be more appropriate for locking the per chip data 
structures...

:v)

Grant Coady wrote:

>Hi All,
>
>Requesting information on two issues, taking a the lock for 
>read/modify/write i2c chip update cycles, and rate limiting 
>write access to i2c bus to prevent user-space DoS on the i2c 
>bus with continuous update requests.
>
>i2c locking:
>
>Thinking about the fan_div setting, it is a read/modify/write 
>(RMW) operation to a chip register, should we take action to 
>prevent another process accessing the chip on i2c during this 
>RMW action?
>
>What I'm thinking is sort of:
>..
>	if new_div not in (valid_divisor_set)
>		return error message
>	~
>	read old_div
>	if (new_div = old_div)
>		goto exit
>	read fan_min
>	adjust fan_min
>	write new_div
>	write fan_min
>exit:
>	~
>..
>
>Should we hold exclusive access to i2c bus + chip between the 
>tildes above?  Or is my thinking bounding too far into highly 
>unlikely events?
>  
>

