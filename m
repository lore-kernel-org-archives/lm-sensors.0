From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 12 Jun 2005 09:15:43 +0000
Subject: [lm-sensors] How can I skip i2c detection?
Message-Id: <20050612091518.624bbb05.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> I am as certain as I can be that I am using a LM82.
> The chip is on two different motherboards, one is from Avantech and
> one is a custom job.
> 
> Our schematic calls out a LM82 and the chip has this text on it: 43AB
> 82CI MQA
> I don't know what "43AB" refers to, but "82CIMQA" is part of the order
> number "LM82CIMQA".
> 
> The Avantech demo board has the same chip, except that the first
> number is "42AB".
> The BIOS on the Avantech board calls it a LM82.
> 
> It could be that the LM82 and LM83 have an identical uC inside and
> just the packaging is different.

My guess exactly. So I updated our sensors-detect script accordingly, it
won't try to differenciate between LM82 and LM83 anymore. I do not plan
to update the lm83 driver for now, as it seems that the LM82 is already
supported by the driver, it would only be a matter of updating the
documentation to say so. I'll try to get additional information before I
do.

Thanks for the report!
-- 
Jean Delvare
