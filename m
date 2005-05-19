From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: seperate mallocs
Message-Id: <406EECE0.6080807@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <406E5CFB.6030309@penguincomputing.com>
In-Reply-To: <406E5CFB.6030309@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>In the patch:
>>    
>>http://jdelvare.net1.nerim.net/sensors/lm_sensors-CVS-separate-mallocs.diff
>>
>>to break the kmalloc's out, why did you remove the
>>
>>-	default :
>>-		printk("lm85: Internal error, invalid kind (%d)!", kind);
>>-		err = -EFAULT ;
>>-		goto ERROR1;
>>
>>
>>clause from the kind detection switch statement in the ADM1026 and
>>LM85 drivers?   Shouldn't we trap any invalid "kind" values?
>>    
>>
>
>After taking a closer look at the code it seemed obvious that this case
>just couldn't happen. The negative "kind" case is handled by the "if
>(kind <= 0)" block right above, and all the other values are handled in
>the swicth/case block. So why would we try to catch an error that, by
>construction, cannot happen?
>  
>
Ahh, but that's just it.  "all" the other values are *not* handled in 
the switch/case block.  The variable "kind" is passed in as an argument 
to the function.  As such, we have *no* control over the values it 
takes.  It is set by the i2c core code that parses the force_foo= 
arguments and sets "kind" as appropriate.  But if we got a version 
mismatch between part of the core and the driver, then perhaps kind 
could be set to a value we don't expect.

So better to detect that and bail out, rather than blindly carry on 
without a "valid" chip type.  The rest of the code is going to make 
decisions based on the 'data->type' field to which kind is eventually 
copied, so the behavior of the driver would become "undefined" with an 
erroneous value in that variable.

Defensive programming is never a bad idea.  'default' clauses in a 
switch are almost always a good idea.

:v)
