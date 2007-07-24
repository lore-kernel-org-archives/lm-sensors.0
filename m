From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 24 Jul 2007 18:56:51 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver\
Message-Id: <46A64B73.2080403@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713002836.GR3435@tree.beaverton.ibm.com>
In-Reply-To: <20070713002836.GR3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Darrick J. Wong wrote:
> On Tue, Jul 17, 2007 at 07:13:52AM +0200, Hans de Goede wrote:
>> I think this will be rather tricky, its esp tricky to define what is a sane 
>> value.
> <snip>
>> -Notice that the msleep, now will only be triggered if update_device gets
>>  called within TEMP_COLLECTION_TIME of driver loading, assuming that
>>  REFRESH_INTERVAL > TEMP_COLLECTION_TIME. I did it this way hoping that the
>>  startup scripts of the PC will have enough time between insmod and the 
>>  first
>>  read, thus not delaying PC startup.
> 
> As I understand your pseudocode, you want to start the temperature
> reading at the end of a call to update_device and init, and pick up
> the temp values the next time update_device gets called, sleeping as
> necessary.  I've a few questions about this approach:
> 

Correct, as said notice that the sleep will only be needed if an attribute gets 
read within TEMP_COLLECTION_TIME of the driver load, see below for more on this.

> (1) Each sysfs attribute calls update_device before calling sprintf
> to write the sysfs attribute.  If a user decides to read all sysfs
> attributes at once (for example, via that grep trick), won't this
> cause a new round of temperature sensor reading every time a sysfs
> attribute is read, as well as a sleep for the next sysfs attribute read?
> 

No, the regular do we need to update, iow is jiffies > (last_update + 
REFRESH_INTERVAL) check will be done first, and only when that succeeds the 
check to see if we still need to sleep for TEMP_COLLECTION_TIME to complete 
will be done, this is why I also wrote:

 >>  Notice that the msleep, now will only be triggered if update_device gets
 >>  called within TEMP_COLLECTION_TIME of driver loading, assuming that
 >>  REFRESH_INTERVAL > TEMP_COLLECTION_TIME.

The whole do we need to sleep because the  TEMP_COLLECTION_TIME hasn't passed 
really is only there for when an attribute gets read immediately after driver 
init. As said I've written the pseudo code like this, so that driver init 
itself doesn't need to sleep, hoping that the attr reading will happen later 
and that thus Pc-booting isn't delayed.

> (2) Let's say a user reads a sensor and causes the temperature sensors
> to start reading.  Then, the user goes to sleep for an hour, and reads
> the temperature sensor via sysfs.  Since the last temperature sensor
> refresh was an hour previously, won't this cause the user to see
> temperature readings that are an hour old?
> 

I don't know, possibly yes. That would be a problem, you could add some logic 
to redo the temp reading if its older then say a minute. The problem with the 
current code is that regular non threaded sensors apps like ksensors, gkrellm 
and gnome-applet-sensors will block for an extended amount of time now.

Maybe the best way would be to use a timer to driver the device_update, 
avoiding your hour old readings scenario that way.

> (3) If the startup scripts load the driver and immediately begin
> querying the sensor readings, the scripts will take the msleep hit
> anyway.
> 

It will, but only on the first query, after that there will be no more sleeping.

>> In a releated note, depending on where the 0ther 0.7 seconds are, you could 
>> try todo less reading, for example each time you start / stop the temp 
>> reading you first read the cfg register, why not just use a cached value, 
>> is there a reason to assumee it will change? Esp when stopping I would be 
>> using the value already read when starting (in the current code).
> 
> I suspect that would work fine.  It looks like the bits in the config
> register only get changed by the driver, so I'd only need to read it
> once.
> 
>> Also you read the limits and other non sensor reading registers each 
>> update, why not just read these once at driver initialisation, is there a 
>> reason to assume they will change?
> 
> Nope.  I can make these two changes.
> 
>> I saw your longer read intervals and make temps signed patches, since the 
>> driver hasn't been merged yet, maybe its a good idea todo a v4 ?
> 
> Not hard, though I'll have to collapse the two subsequent incremental
> patches.  It'd be less work to just make one more incremental patch and
> send the entire patchset to lm-sensors.
> 

Never mind about this I've already requested Mark to pick up the v3 patch + the 
2 fixes.

Jean, if you are reading this what do you think about this whole sleep for a 
sesond in device_update stuff and possible workarounds?

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
