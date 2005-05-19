From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <4241277C.1080401@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Grant Coady wrote:

>Hi Mark,
>
>On Wed, 23 Mar 2005 01:35:14 -0500, "Mark M. Hoffman" <mhoffman@lightlink.com> wrote:
>  
>
>>>Thinking about the fan_div setting, it is a read/modify/write 
>>>(RMW) operation to a chip register, should we take action to 
>>>prevent another process accessing the chip on i2c during this 
>>>RMW action?
>>>      
>>>
>>Looks like Philip addressed this one.
>>    
>>
>
>Not at all.
>  
>

I'm sorry, I didn't mean to offend.

In addition to the way I know my drivers worked, I believe that all 
other drivers have an update_lock semaphore that could be used to 
protect read-modify-write's in the same way.

:v)
