From: Sean Fidler <fidlersean@gmail.com>
Date: Wed, 10 Mar 2010 18:00:15 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <alpine.OSX.2.00.1003101259330.310@blackbird.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks! Yeah, I must have missed a step that step during this round.

On Wed, 10 Mar 2010, Jean Delvare wrote:

> Hi Sean,
>
> On Wed, 10 Mar 2010 11:19:44 -0500 (EST), Sean Fidler wrote:
>> Thanks for the updated driver.
>>
>> I've run into a second issue: I have to manually insmod the smsc47m1.ko
>> file before I'm able to modprobe smsc47m1.
>>
>> Previously, I used insmod once and the smsc47m1 module loaded properly
>> at boot.
>
> I doubt it. insmod and modprobe do pretty much the same thing, except
> that modprobe has some magic added. If you run "insmod ./smsc47m1.ko",
> then a subsequent "modprobe smsc47m1" is a no-op: modprobe sees that the
> module is already loaded and does nothing.
>
> If you want to load the driver at boot time, you have 2 options:
> 1* Use insmod, with the full path to the new module file.
> 2* Copy the new module file over the old one in /lib/modules, and then
>   you can call modprobe.
>
> Maybe you did 2* last time, and don't remember the step where you
> copied the module file around.
>
> -- 
> Jean Delvare
>

--
Twitter: endersyrinx
GTalk: fidlersean

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
