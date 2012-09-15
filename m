From: Parag Warudkar <parag.lkml@gmail.com>
Date: Sat, 15 Sep 2012 23:38:00 +0000
Subject: Re: [lm-sensors] [PATCH] applesmc: Bump max wait and rearrange udelay
Message-Id: <alpine.DEB.2.02.1209151936220.2271@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.02.1209151834120.2271@ubuntu> <20120915225841.GA3816@roeck-us.net> <alpine.DEB.2.02.1209151918210.2271@ubuntu>
In-Reply-To: <alpine.DEB.2.02.1209151918210.2271@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Parag Warudkar <parag.lkml@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, rydberg@euromail.se, khali@linux-fr.org



On Sat, 15 Sep 2012, Parag Warudkar wrote:

> 
> Yeah, that would fix the code to match what it says and eliminate most 
> failures. But in my testing sometimes it needed a max wait of 57344 us - 
> I wrote a separate patch to instrument it by bumping up max wait in 
> increments of 0x2000 until it no longer failed under my normal workloads. 

Of course I meant 57 us instead of 57344 which I remembered from my 
unconverted debug printks.

Parag

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
