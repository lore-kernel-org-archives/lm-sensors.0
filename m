From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: i2c/kernel i2c-proc.c
Message-Id: <3EE247B0.2000406@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE246E6.1020806@penguincomputing.com>
In-Reply-To: <3EE246E6.1020806@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

That's true.
But if it isn't defined until some kernel after 2.4.9 then we can't use it.
Anyway there's no harm in taking it out.

Philip Pokorny wrote:
> I think "unlikely" is a macro or a hint to GCC that the if condition 
> being tested is unlikely to be true and therefore it should set the 
> branch prediction bits in the code generated to improve performance for 
> the more probable case of the expression being false...
> 
> author@mordac.netroedge.com wrote:
> 
>> Update of /home/cvs/i2c/kernel
>> In directory mordac.netroedge.com:/tmp/cvs-serv18981
>>
>> Modified Files:
>>       Tag: lk2-4
>>     i2c-proc.c Log Message:
>> (mds) fix problem with multiple chips from same driver
>>       found by Khali. This was caused by not mallocing space for
>>       and copying the ctl_template.
>>       This also fixes incomplete removal of the sysctl table
>>       when i2c-proc is rmmodded.
>>       Also remove unlikely() calls since unlikely() is not available
>>       in kernel 2.4.9.
>>
>>
> 
> 
