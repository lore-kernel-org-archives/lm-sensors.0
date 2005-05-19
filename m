From: mark@alpha.dyndns.org (Mark McClelland)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Request for I2C IDs
Message-Id: <400BDD97.8090909@alpha.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040118175528.66a9d01a.khali@linux-fr.org>
In-Reply-To: <20040118175528.66a9d01a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>I hope you're the right person to contact about this. I sent this to
>>the I2C mailing list a few months ago, but got no response.
>>    
>>
>
>That was the correct address. I see your previous post. Sorry we had no
>time to answer then. Greg KH must know about it too.
>  
>

Not a problem. I've been using temporary IDs in the meantime (outside 
the kernel only).

>>I'd like to request the following I2C IDs for the OVCam driver project
>><http://alpha.dyndns.org/ov511/>:
>>    
>>
<snip>

>One preliminary note: our authority on I2C IDs isn't unquestionable.
>Sometimes people submit patches to the Linux kernel and use whatever ID
>they want. It's a shame but it works. So, if someone is quicker than you
>to use the following IDs, we may have to concede and have you change
>your IDs.
>  
>

Understood. Not a problem.

>Another note: you shouldn't expect to see any of your drivers accepted
>into Linux 2.4 anymore.
>  
>

You're probably right, but I'll try anyway. It would be a shame if it 
didn't go in, since the already-merged W9967CF driver depends on ovcamchip.

>Here we go anyway:
>
>#define I2C_DRIVERID_OVCAMCHIP	61	/* OmniVision CMOS image sens.	*/
>#define I2C_DRIVERID_TDA7313	62	/* TDA7313 audio processor	*/
>
>#define I2C_HW_SMBUS_OV511	0x0e	/* OV511(+) USB 1.1 webcam ICs	*/
>#define I2C_HW_SMBUS_OV518	0x0f	/* OV518(+) USB 1.1 webcam ICs	*/
>#define I2C_HW_SMBUS_OV519	0x10	/* OV519 USB 1.1 webcam IC	*/
>#define I2C_HW_SMBUS_OVFX2	0x11	/* Cypress Ez-USB FX2 USB 2.0	*/
>  
>

You should change that last comment to "Cypress/OmniVision FX2 webcam", 
since lots of other (non-webcam) devices utilize the FX2.

Anyway, the rest look good. Thanks for your assistance with this!

-- 
Mark McClelland
mark@alpha.dyndns.org

