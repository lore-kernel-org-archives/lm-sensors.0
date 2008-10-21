From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Date: Tue, 21 Oct 2008 14:55:27 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adt7473) Fix voltage conversion
Message-Id: <48FDED5F.1080403@teltonika.lt>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081021161730.2a6ddb72@hyperion.delvare>
In-Reply-To: <20081021161730.2a6ddb72@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Darrick,
> 
> Back in April 2008, Paulius Zaleckas posted a patch fixing the voltage
> conversion routines of the adt7473 hwmon driver [1]. I reviewed it and
> asked for a cleaned up version [2] but Paulius never replied and the
> patch was lost. Still, I think this was a good patch so I just did the
> cleanup work and am going to push the patch to Linus in the next days.

Thanks for picking it up! I had no time to finish it...

> Can you please review and ack the patch below? I tested it on an
> emulated chip and it seems to work fine.

Unfortunately I don't have real hardware to test it... My patch was based
on datasheet... Althrough I had written ADT7476 driver(tested) and it was
based on adt7473 driver, thats how I noticed wrong value calculation.

> Thanks.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
