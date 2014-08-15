From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Fri, 15 Aug 2014 15:18:18 +0000
Subject: Re: [lm-sensors] [PATCH V3] hwmon, k10temp: Add support for F15h M60h
Message-Id: <CAAek22FpQRhDqjSQjOL_UfoJ51hHqbxYZu2AGTA54LRM9sFn2g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408058127-19374-1-git-send-email-aravind.gopalakrishnan@amd.com>
In-Reply-To: <1408058127-19374-1-git-send-email-aravind.gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>  On 08/14/2014 04:15 PM, Aravind Gopalakrishnan wrote:
>>
>>> This patch adds temperature monitoring support for F15h M60h processor.
>>>   - Add new pci device id for the relevant processor
>>>   - The functionality of REG_REPORTED_TEMPERATURE is moved to
>>>     D0F0xBC_xD820_0CA4 [Reported Temperature Control]
>>>     - So, use this to get CUR_TEMP value
>>>     - Since we need an indirect register access, protect this with
>>>       a mutex lock
>>>
>>
>>
What about making this a new driver forked from k10temp.

AMD has changed how they report temperatures and the very different method
of getting these temps suggests that it is no longer reasonable to add
support to this driver for these new chips. Particular attention to the
mutex required to protect the indirect register suggests that this would
benefit from focus in its own driver now that there are multiple members of
the "k15temp" family.

Anyone else have thoughts?


-- 
Philip Pokorny, RHCE
Chief Technical Officer
PENGUIN COMPUTING, Inc
www.penguincomputing.com
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
