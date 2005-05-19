From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <4242E076.1030802@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Grant,
>
>  
>
>>Surveyed drivers/i2c/chips/*.c containing "_write_value(" and...
>>
>>The winner is lm85.c :o)
>>
>>driver          write lock taken status [0]
>>--------------  ---------------------------------------------------
>>adm1021.c       no, appears to not need it
>>    
>>
>
>Out of curiousity, I took a look. See what I found:
>
>	data->value = TEMP_TO_REG(temp);
>	adm1021_write_value(client, reg, data->value);
>
>As long as we don't hold update_lock here, it could happen that
>data->value is overwritten by an update right inbetween these two lines,
>right? Causing the write to become silently useless, which is no good.
>So, either the lock should be held even in this most simple write case,
>or we should use a temporary variable and put the lines the other way
>around:
>
>	w = TEMP_TO_REG(temp);
>	adm1021_write_value(client, reg, w);
>	data->value = w;
>
>This should be concurrent-update-safe as far as I can see. I don't know
>what is preferable, performance-wise. At least, locking is a general
>solution to the problem. Temporary variables might be fine for simple
>cases like the one above, but it might become a mess for more complex
>functions. Also, using locks make it clear to the user that a concurrent
>access issue exists. The trick of using local variables isn't as
>obvious, and future code cleanup attempts might break it. So all in all
>I believe that using the lock is better.
>
>  
>

I think both cases are problematic.  It doesn't matter which order you 
do the writes, if you attempt to cache the value written to the 
register, then you must do that atomically.  Otherwise, the following 
can potentially occur and lead to the wrong result:

    Thread A                Thread B
    Write first value
                            Write first value
                            Write second value
    Write second value

End result is second value is Thread A and first value is Thread B.

Without locking, this sort of sequence is possible.  As long as you have 
to update two values in different locations, you've got to have some 
kind of locking or synchronization.

:v)
