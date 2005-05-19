From: cminyard@mvista.com (Corey Minyard)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: I2C support for IPMI
Message-Id: <41EFC6B0.3050402@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41EEDAD7.70105@mvista.com>
In-Reply-To: <41EEDAD7.70105@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:

>Hi Corey:
>
>* Corey Minyard <cminyard@mvista.com> [2005-01-19 22:11:23 -0600]:
>  
>
>>Mark M. Hoffman wrote:
>>
>>    
>>
>>>Well, wait_event_interruptible_timeout() schedules, so at a quick glance
>>>this will not work for i2c-ibm_iic at least.  But more generally...
>>>
>>>
>>>      
>>>
>>I think I got that one.  If you look at the function in the patch, I 
>>made some changes to that.
>>    
>>
>
>I'm sorry but I don't see it.  All I see is that you modified the function
>iic_wait_for_tc() to not schedule, but only if it's in polling mode.  The
>interrupt mode code is unchanged.
>  
>
Oops, I missed that.  I think just adding a !i2c_spin_delay to the first 
if statement should do it.

However, there's still a race where if you panic while in 
iic_wait_for_tc(), you wouldn't be able to send anything and the 
interface will be stuck.  The same is true for all other bus drivers.  
If the code is in an msleep() when the panic occurs, the bus lock will 
be held and nothing else will be able to do anything.

>  
>
>>>I started to rewrite i2c-i801 [1] to use interrupts rather than pure
>>>polling as it does now, so I'm interested to know: how can the panic-time
>>>operation work for bus drivers that need interrupts?  
>>>
>>>
>>>      
>>>
>>What I have done in the IPMI driver is when you wait for an operation, 
>>if you are in a panic then call the interrupt handler continuously until 
>>the operation completes.  Sort of like the network polling does.
>>    
>>
>
>So e.g. i2c-ibm_iic would need similar changes too, right?
>  
>
Well, not exactly.  The trouble is that the I2C interface is 
synchronous; it blocks until the message is sent.  So there's no way for 
a user of the i2c code to do a "Send this message and poll until the 
operation is finished."  That way any operations that were in progress 
would be finished and the operation in question could complete.

I've never dealt with a synchronous interface in this manner.  I'll have 
to study the code a little bit more.  The trouble is that at panic time, 
wait_event_interruptuble_timeout() can never be made to "return" and 
clean things out.  And you want the operations in progress to complete; 
I know of one case where you go into this mode and then return back to a 
normal running kernel.  In the kernel coredump code it supports a "take 
a kernel dump and then keep going" operation.  Scheduling is disabled 
during the coredump, but the coredump code has to keep kicking the 
watchdog, and if it's an IPMI watchdog on an SMBus then it has to go 
through I2C.

IMHO, synchronous interfaces are a trap device driver writers fall 
into.  They are simpler at first, but then you run into situations where 
things just won't work right.  For instance, suppose some crazy hardware 
designer puts a reset register out on the I2C (assuming this hasn't 
already happened).  With the current design of the I2C driver, you could 
get into a situation where at a panic you cannot reset the system.  With 
an asyncronous interface, you could put setting the reset register into 
a xmit queue and poll the interface until the reset occurred.

Anyway, looking at the current code, I don't think there's a way to make 
this work correctly.  It looks to me that this will take a redesign of 
the interface between the I2C core code and the bus drivers.  I'll have 
to think about it.

-Corey
