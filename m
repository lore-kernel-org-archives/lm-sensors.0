From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: [RFC|PATCH][2.6] Additional i2c adapter flags for i2c client
Message-Id: <40716F40.4070609@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <40686476.7020603@convergence.de>	<406EBA38.1030203@gmx.de>	<20040403163031.122b5df8.khali@linux-fr.org> <1081163597.607.15.camel@newt>
In-Reply-To: <1081163597.607.15.camel@newt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org, Michael Hunold <m.hunold@gmx.de>, Greg KH <greg@kroah.com>

Adrian Cox wrote:

>On Sat, 2004-04-03 at 15:30, Jean Delvare wrote:
>
>  
>
>>I'm not sure that the function you propose would be really useful. I
>>guess that most people don't load i2c chip drivers they don't need. The
>>class filter you propose, added to the different I2C addresses, should
>>do the rest.
>>    
>>
>
>What about using two DVB cards of different models to record off one
>multiplex while watching another?
>
>Only an explicit list of which chips should be probed on each I2C bus is
>safe for this sort of system.
>
>  
>
You might be able to use the ignore= and force=  parameters to the i2c 
drivers to accomplish this.  With ignore you can prevent a driver from 
scanning an address (specify -1 as the bus to ignore that address on all 
busses) and with force you can specify which bus/address to find the 
specific chip.

I haven't read the code in detail yet, but if force doesn't already 
override ignore, it probably should.  I can't think of reason why you 
would want ignore to override a force directive.

:v)
