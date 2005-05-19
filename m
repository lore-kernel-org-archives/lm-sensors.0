From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: [RFC] I2C: Remove the i2c_client id field
Message-Id: <41D18B9E.2080706@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041227230402.272fafd0.khali@linux-fr.org>	<41D0942B.8020109@penguincomputing.com> <20041228114258.35e9b5b7.khali@linux-fr.org>
In-Reply-To: <20041228114258.35e9b5b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>

Jean Delvare wrote:

>Hi Philip,
>
>  
>
>>So only the drives I wrote use the ID in a meaningful way?
>>    
>>
>
>True, providing we limit our consideration to the hardware monitoring
>drivers. Even in your drivers, the meaningfulness is discussable.
>
>The lm85 driver simply displays the assigned id once (at the time it
>assigns it). Since the id is then never used, I would consider the lm85
>driver similar to the other hardware monitoring drivers.
>  
>

Oops.  I probably should have used the ID in the debug messages...  I 
guess it doesn't matter now.

>The adm1026 driver, OTOH, does use the id value in all debug messages,
>and it also only reconfigures the GPIO pins for the first client only
>(id = 0). Although this is a real use of the id, it only matters if you
>use the module parameters for GPIO pins reconfiguration and actually
>have more than one ADM1026 chip (a quite rare chip if you remember).
>
Not for me.  We ship hundreds of systems each month with a motherboard 
with that chip on it.  I think it's actually on two different 
motherboards we sell.

> You
>don't necessarily know which ADM1026 will get id 0 anyway (if the chips
>are on different busses it depends on the order the bus drivers were
>loaded in),
>
Wouldn't a force_xxx parameter cause a specific bus/id to be probed and 
assigned first?

> and I am not sure why one would want to reprogram only the
>first chip. Unless someone comes with such a specific hardware setup so
>that we can examine what is really needed,
>
Well, that's exactly the problem that I had.  The motherboard vendor's 
BIOS didn't set the chip up and I had to program it myself.  I got the 
schematics from the vendor for the part of the motherboard attached to 
the chip so that I could program it correctly.

> I think we can get rid of the
>"id = 0" test and reconfigure "all" ADM1026 chips (which really is only
>one for the two known boards using an ADM1026).
>  
>
I think that would be a bad idea.  Reprogramming any chip is generally a 
bad idea (as we can see from the recent removal of all the init code) 
and forcing any specified config to apply to all chips found in the 
system would be an even worse idea.

I think a better idea that addresses your concerns about bus ordering 
would be to add an additional parameter that is a bus/chip number pair 
which is the chip to initialize.  Something like:

static int gpio_target[2] = { -1, -1 }
MODULE_PARM(gpio_target, "2i");
MODULE_PARM_DESC(gpio_target,"Address of chip to whose GPIO is to be 
programmed");

This would be similar to the bus/address pairs used in the 
force_subclient parameters to the w83781d driver.

>BTW, does anyone really use the GPIO pins reconfiguration parameters?
>  
>

Not anymore, but I did as I mention above.

:v)
