From: Michael Barkowski <michaelbarkowski@ruggedcom.com>
Date: Wed, 12 Aug 2009 20:58:57 +0000
Subject: Re: [lm-sensors] [PATCH 2/6] mtd: m25p80: Convert to device table
Message-Id: <4A832D11.3020802@ruggedcom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090731003957.GA23982@oksana.dev.rtsoft.ru> <20090731004100.GB8371@oksana.dev.rtsoft.ru> <4A832A03.6020507@ruggedcom.com> <20090812205800.GA27074@oksana.dev.rtsoft.ru>
In-Reply-To: <20090812205800.GA27074@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: avorontsov@ru.mvista.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben@fluff.org>, David Brownell <dbrownell@users.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jean Delvare <khali@linux-fr.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org

Anton Vorontsov wrote:
> On Wed, Aug 12, 2009 at 04:45:55PM -0400, Michael Barkowski wrote:
>> Hello Anton,
>>
>> Is m25p_probe now valid with dev.platform_data = NULL, for of platforms?
>>
>> Then shouldn't you have the following change as well, near the end of
>> the function?
>>
>> -  	} else if (data->nr_parts)
>> +  	} else if (data && data->nr_parts)
>> 		dev_warn(&spi->dev, "ignoring %d default partitions on %s\n",
>> 				data->nr_parts, data->name);
>>
>> Or am I misunderstanding something?
> 
> Yeah, you missed this patch:
> http://patchwork.kernel.org/patch/38179/
> 
> 
> Thanks,
> 

Beautiful - thanks - sorry to interrupt

-- 
Michael Barkowski
905-482-4577

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
