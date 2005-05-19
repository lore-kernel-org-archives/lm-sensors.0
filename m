From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: P4 lm_sensors module?
Message-Id: <3F2DA537.6030605@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F287A84.6090802@penguincomputing.com>
In-Reply-To: <3F287A84.6090802@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a driver I haven't checked in yet.
It's essentially a one-sensor version of adm1021. If you try adm1021 and it works
let me know and then I can fix up my xeon driver and send it to you to test.

Philip Pokorny wrote:
> I did write a driver, but later I looked in more detail at the adm1021 
> driver and saw that it is a more appropriate driver for the sensor on 
> the Xeons.
> 
> Intel got a little tricky with the older 400MHz FSB Xeon procs and 
> included the sensor on the PCB rather than building it into the CPU 
> processor die itself.  Then they wrote the Xeon sensor spec to be a 
> subset of the ADM1021 register set.  That let them use any ADM1021 
> compliant sensor.  So if you 'modprobe adm1021' and it detects two 
> sensors, then you've found your CPU sensors.  The CPU temperatures will 
> be the "REMOTE" temperatures from those two.  The "BOARD" or internal 
> temperatures will be a sensor in the adm1021 itself on the CPU carrier 
> board.  If you have an adm1023 you get .25degC resolution as a bonus.
> 
> If you've got 533MHz FSB Xeons, then you've got a different problem. 
> Intel *removed* the onboard adm1021 from the 533MHz parts and left it up 
> to the motherboard to sample and report the die temperature.  In that 
> case, you won't find a "xeon" sensor on the I2C bus, but should look for 
> temperatures from some other sensor (winbond w83781d or compatible for 
> example...)
> 
> I don't have direct experience with the Westerville board, so I'm sorry 
> I won't be much more help.  I've CC'd the sensors mailing list so 
> perhaps someone on that list has your motherboard and can advise you.
> 
> :v)
> 
> Dave wrote:
> 
>> Hi!  I found a note on the web from 2002 about you working on a P4
>> (Xeon) temp sensor for lm_sensors.  How did that work out?  I'm trying
>> to read the on-chip temerature on an SE7501WV2 Intel (westerville) board
>> with dual xeons, and not getting anywhere.
>>
>> If you have somehting that you'd be willing to share, even if it's not
>> complete or stable, I'd really appreciate it.
>>
>> thanks,
>> dave.
>>
>>
> 
> 
> 
