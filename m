From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <5382411n7nd09as98rp9ehr41h3fkmcqkm@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Wed, 23 Mar 2005 01:35:14 -0500, "Mark M. Hoffman" <mhoffman@lightlink.com> wrote:

>> Thinking about the fan_div setting, it is a read/modify/write 
>> (RMW) operation to a chip register, should we take action to 
>> prevent another process accessing the chip on i2c during this 
>> RMW action?
>
>Looks like Philip addressed this one.

Not at all.

>> preventing DoS, updating i2c bus chips
>> 
>> Another query, we take care not to read chip too frequently, 
>> what stops user-space DoS'ing the i2c bus with continuous 
>> writes by constant update requests?  
>
>Nothing prevents it, except that you need root to do those writes/updates.
>Considering all the other damage you can do as root... there's not much
>point in any further protection for the I2C bus.

Your answer tells me it is not an issue.  "Don't do that"

Cheers,
Grant.
