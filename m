From: Rudolf Marek <r.marek@assembler.cz>
Date: Fri, 08 Nov 2013 00:07:40 +0000
Subject: Re: [lm-sensors] About the Asus F2A85 temperature sensor (it8603e)
Message-Id: <527C2B4C.9030000@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <527C23BE.9030308@assembler.cz>
In-Reply-To: <527C23BE.9030308@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> That is a good idea. The current driver causes the chip to stop updating
> temperatures, though fan control continues to work. That probably means a
> different/additional exit sequence is needed -- or perhaps writing to the chip
> is entirely wrong.

Hm maybe we just hit some undefined register due to feature reduction. Does it 
happen with coreboot too? (You will have to enable the logical device, I think 
Im not doing that). How you know it is not updating? If you program own io 
routine to just read out temps, does it work?

I can check more stuff next week.

> I'll look for an 8728 datasheet

Looks I found something through google on ulozto.

Thanks
Rudolf


.
>
> David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
