From: Dmitry Gromov <gromovd@gmail.com>
Date: Tue, 18 May 2010 12:03:29 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: Update coretemp to current
Message-Id: <AANLkTim9yxegoi5H5R5BCxXVdQazo59kYKv0eZPcOC2T@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100510035031.GD9181@owl> <20100514065808.GA11598@owl> 
	<20100517094136.094800562@osadl.org> <AANLkTinQlH7LhCAz00WaHqbbslcSqipzVx4tDoQKSqIL@mail.gmail.com> 
	<4BF23B36.7030809@osadl.org>
In-Reply-To: <4BF23B36.7030809@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Carsten Emde <C.Emde@osadl.org>
Cc: Huaxu Wan <huaxu.wan@intel.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi!

On Tue, May 18, 2010 at 03:01, Carsten Emde <C.Emde@osadl.org> wrote:
> Dmitry,
>
>>> Here comes the current version of the coretemp patches. Huaxu did the
>>> initial work; Jean suggested to submit them directly to Andrew.
>>>
>>> I made some style changes as advised by checkpatch.
>>>
>>> The patches have been tested successfully on Core 2 Duo and Quad, and on
>>> Nehalem and Nehalem/Westmere where temperature readings were plausible
>>> and
>>> changed with load as expected. When tested on an Atom processor (N270),
>>> the
>>> temperature values were identical to previous versions of the coretemp
>>> module and also changed with load. However, the readings should be higher
>>> by 10 to 15C as compared to the outside temperature of the processor.
>>> Huaxu, could you check? I would guess TjMax to be 105 instead of 90C in
>>> these
>>> processors.
>>
>> I apologize, if I ask a stupid question, but are you saying that TjMax in
>> coretemp.c should be set to higher value than Tcase-max value specified in
>> Intel documents?
>
> Hmm, no. I am saying that I would like the reading to be correct. I have
> measured the outside temperature of the case with an infrared thermometer
> [1] and found it to be higher than the readings returned by the coretemp
> module. In all other CPUs I have, the coretemp readings are higher than the
> case temperature.
>

Thank you very much for an explanation, Carsten.


-- 
DG
NJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
