From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 17 Jul 2007 05:13:52 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver\
Message-Id: <469C5010.7080908@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713002836.GR3435@tree.beaverton.ibm.com>
In-Reply-To: <20070713002836.GR3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Darrick J. Wong wrote:
> On Sat, Jul 14, 2007 at 07:22:41PM +0200, Hans de Goede wrote:
>> Hmm,
>>
>> I see it refresh the readings every 2 seconds, since reading things takes 1 
>> sec minimum, I think it would be a good idea to make this somewhat bigger. 
>> Darrick, can you post a new version and or an incremental patch with a 
>> slower read frequency, say once every 5 or 10 seconds?
> 
> Will do.  The data sheet says you have to wait 200ms *
> number_of_temperature_sensor_chips.  Unfortunately, there's no way to find
> out how many sensor chips there are before you read them, but 1s seemed to
> work ok for all my systems.  I suppose I could modify the init function
> to do the read once with the long delay, then lower it to 200ms *
> however many temperature sensors read a "sane" value.
> 

I think this will be rather tricky, its esp tricky to define what is a sane value.

How about the following instead:
-convert TEMP_COLLECTION_TIME to jiffies
-add a started_reading member to data
-driver initializes
-sets start reading temp sensors bit
-set started_reading to jiffies
-in update_device:
  if (time_before(jiffies, data->last_updated + REFRESH_INTERVAL)
	&& data->valid)
	goto out;

  /* cache jiffies to make sure it doesn't change, possible causing an unwanted
     overflow in the substraction when calculating how long to sleep */
  unsigned long current_jiffies = jiffies;
  if (time_before(current_jiffies, data->started_reading +
		TEMP_COLLECTION_TIME))
	msleep(jiffies_to_msecs((data->started_reading + TEMP_COLLECTION_TIME) 			- 
current_jiffies));

  /* done reading temperature sensors */
  ...

  /* read registers */
  ...


  /* start reading temperature sensors */
  ...

  data->started_reading = jiffies;

  ...

  "exit update_device"

-Notice that the msleep, now will only be triggered if update_device gets
  called within TEMP_COLLECTION_TIME of driver loading, assuming that
  REFRESH_INTERVAL > TEMP_COLLECTION_TIME. I did it this way hoping that the
  startup scripts of the PC will have enough time between insmod and the first
  read, thus not delaying PC startup.


---

In a releated note, depending on where the 0ther 0.7 seconds are, you could try 
todo less reading, for example each time you start / stop the temp reading you 
first read the cfg register, why not just use a cached value, is there a reason 
to assumee it will change? Esp when stopping I would be using the value already 
read when starting (in the current code).

Also you read the limits and other non sensor reading registers each update, 
why not just read these once at driver initialisation, is there a reason to 
assume they will change?

Regards,

Hans


p.s.

I saw your longer read intervals and make temps signed patches, since the 
driver hasn't been merged yet, maybe its a good idea todo a v4 ?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
