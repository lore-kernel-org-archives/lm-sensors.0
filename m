From: "Philip Pokorny" <ppokorny@penguincomputing.com>
Date: Thu, 19 Nov 2009 13:00:11 +0000
Subject: Re: [lm-sensors] ipmisensors module ported to 2.6.29
Message-Id: <6BBCB212-1E75-4B22-9088-C9F394CCD3B6@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1258584180.8521.102.camel@pharper_desktop.arrs.arrisi.com>
In-Reply-To: <1258584180.8521.102.camel@pharper_desktop.arrs.arrisi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Anyone with rw permission on the ipmi device can tell the bmc to turn  
off the power to the server, change sensor limits, and BIOS settings  
in some cases

Access to ipmi isn't something ordinary users should have.

Phil P.

-- 
Philip Pokorny, RHCE
Chief Hardware Architect
PENGUIN COMPUTING, Inc
www.penguincomputing.com

On Nov 19, 2009, at 6:24 AM, "Luca Tettamanti" <kronos.it@gmail.com>  
wrote:

> On Thu, Nov 19, 2009 at 11:46 AM, Jean Delvare <khali@linux-fr.org>  
> wrote:
>> For IPMI, I don't know if "ipmitool sensor" can be run as non-root,
>> this needs to be confirmed. I presume it depends on the permissions  
>> of
>> the /dev/impi* nodes.
>
> Yes, the user needs rw permission on the device node.
>
>>> If you are willing to spend effort on this, I would be happy to  
>>> help were I
>>> can!
>>
>> The bottom line is that anyone who pushes IPMI sensors support  
>> forward
>> has my blessing. Honestly, I don't care that much whether it is in  
>> the
>> kernel or in libsensors, as long as it finally happens. It has been
>> pending for sooooo long :(
>
> +1 ;-)
> I have the hardware (a few Dell servers) so at least I can do testing
> (and hopefully some coding).
>
> L
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
