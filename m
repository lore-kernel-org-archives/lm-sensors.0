From: Robert Kaiser <kairo@kairo.at>
Date: Thu, 10 Mar 2011 21:03:58 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan
Message-Id: <ilbebu$fq7$1@dough.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ian Dobson schrieb:
> Any chance you can have a look in the BIOS and email the exact values
> you see there.

Ah, right, good idea, wrote a note and will do so tomorrow when I get up 
and boot the machine!

> What
> motherboard do you have? Maybe the manufacturer has some documentation.

As I mentioned in the first message where I posted this, I have an Intel 
DH67CL - as this is one of the relatively new Sandy Bridge 
graphics-enabled board, I guess we'll see those in wider circulation in 
the next months (esp. once the B3 version with the fixed SATA channels 
is available everywhere).

> Maybe something similar would be correct for your board. If you add this
> to your config file

I'll look into that - are your values better for those voltages that 
already get named (and calculated) by Guenther's standalone driver or 
are those just duplicates of what it already does by default?

Robert Kaiser


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
