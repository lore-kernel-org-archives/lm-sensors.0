From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <4240E8AF.9030107@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Grant Coady wrote:

>On Tue, 22 Mar 2005 16:40:00 -0800, Philip Pokorny <ppokorny@penguincomputing.com> wrote:
>
>  
>
>>The ADM1026 and LM85 drivers should be requesting the semaphore on the 
>>    
>>
>     ^^^^^^^-- off my work list as it requires too much change
>for an obvious fix, care to comment on partial patch?  
>  
>
A fix for what? Locking or rate limiting?

>I stopped when I realised it had an odd data structure and fixing 
>that is too invasive as I cannot go further than compile test.
>  
>
I'm trying to explain that the locking is already *there* in the adm1026 
and lm85 drivers.  The semaphore "data->update_lock" is taken whenever 
lm85_update_device is called to *read* the chip and whenever any of the 
set_ functions is called to *write* to the chip.  Therefore all reads 
and writes are serialized and locked by the data->update_lock semaphore.

Further the functions that set the fan_div and fan_min also take the 
semaphore making those multi-value updates atomic as well.

>Per register access locking achieves nothing for a read/modify/write 
>cycle as another proces may change that register during the modify 
>phase if i2c bus released.  
>  
>
Just to re-iterate, the update_lock is held the entire time we're 
updating the values.  No other process can change a register because it 
will have to wait on the update_lock.

>On one hand I've been told not to trust cache coherency with chip 
>registers, thus implying read/modify/write cycle, which should take 
>exclusive access to i2c bus for the read and writeback operations.
>  
>
There is no cache in this case.  The i2c devices are not accessed 
directly, so there should not be any cache coherency issues.

However, it is also true that hardware does not always read back what 
was last written.  Sometimes bits (like alarms) are cleared when written 
with a one.

>Does that clarify my query?
>
I'm not sure.  Do my comments clarify things at all?

:v)
