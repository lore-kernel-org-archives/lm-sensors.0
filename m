From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: driver design question
Message-Id: <3F2DB4D1.20407@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030728153714.7b09e0b7.khali@linux-fr.org>
In-Reply-To: <20030728153714.7b09e0b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Doing some catching up.

Good discussion, I agree with most of it.
Some thoughts:

- ACPI can indeed go poking around behind our backs.

- Experimenting using one (small) driver is indeed a good thing.
  Note that adm1021 has my enhancements for returning an alarm if a read fails.

- Reading limits less often than other things is probably good.

- If people have a problem with eeprom performance they can rmmod it.



Philip Pokorny wrote:
> Jean Delvare wrote:
> 
>>>> Quick note: The refresh frequency limit was introduced because the 
>>>> hardware would give bad results if you polled it too fast.  So, 
>>>> depending on what the datasheet for the chip says, we adjust the
>>>> max polling frequency to match.  So this was to ensure accurate
>>>> results from the hardware, not as a performace optimization.
>>>>
>>
>>> Take a look at the ADM1026 driver (by Phil P.) as a counter-example. 
>>> The update routine is apropos to this thread.  He uses two different
>>> refresh frequencies - the slower one for config data.  I thought this
>>> was a good idea when I first saw it.
>>>
>>
>> Exactly what I had in mind. I didn't know someone else already did that
>> :)
>>
>> After some more thinking however, I'm not sure it's what we really want.
>> We are talking (correct me if I'm wrong there) about data that should
>> not change *at all*, not data that should not change *often*. So
>> sampling their value every 5 minutes doesn't make much sense. If they
>> change and we are not aware of the change, it's likely to cause trouble
>> that will solve only up to 5 minutes later. The user will probably get
>> mad about this (by the time he/she tries to figure out what's wrong, the
>> problem will solve by itself). So I think we should opt for one of the
>> following policy:
> 
> 
> 
> That's one of the reasons that I still poll the data that I don't expect 
> to be different.  I made sure to update the cache immediately when I 
> change a configuration parameter so that future reads will return the 
> correct data. But then at some time later, The driver will read the 
> actual hardware so you can always be sure that after some period of time 
> what you see from the driver is what's actually on the chip.
> 
> This turned out to be important because it helped me find a programming 
> bug in my driver.  I wasn't bit shifting and masking one of the 
> parameters correctly in and out of the chip.  The result was that some 
> settings didn't get changed correctly.  The cache was what I "wanted" 
> but the chip was set to something different.  If I hadn't included the 
> re-read of the chip, I don't think I would have found this bug.
> 
> A cache is just a cache.  It's not the real thing.  You must include a 
> way to update the cache to make it consistent with the "real thing".  
> That might be some other parameter/attribute that you write to to 
> trigger a cache update on demand.  Or it can be a timeout as implemented 
> in the adm1026 driver.
> 
> With ACPI and IPMI poking at these monitoring chips, I think it's 
> dangerous for us to assume that we know everything that's going on with 
> the sensor. Witness Margit's experience where we programmed the limits 
> incorrectly and the BIOS shut down his machine.  Or where we set off 
> alarm beepers because the limits are wrong.
> 
>> 1* We refresh these values as often as the other ones (what most of our
>> drivers do) and don't care about the performance cost. Play it safe,
>> Phil E. said.
> 
> 
> 
> That's reasonable for simple chips with few registers.  But consider 
> that just about every chip has twice as many limit values (min and max) 
> as current readings.  That means that only 35% of the data is changing 
> rapidly.  That's a significant performance optimization to reduce 65% of 
> reads.
> 
> 
>> 2* We say these values should *NOT* change, we don't sample them, and if
>> something goes wrong, obviously it's not our fault (though the user will
>> certainly complain to us). We can enable a check (that is, sampling the
>> should-not-change data as in 1* and emit a warning if we see a change in
>> the values) in debug mode (or additional parameter?) to catch the
>> problem.
> 
> 
> 
> As I said above, I think we should just read the bits once in a while.  
> Adding checks for unexpected changes could add significantly to the code.
> 
>> One more thought though: remember that these things are very unlikely to
>> happen. We have the adm1026 driver which as a different policy, now the
>> adm1025 has its own one too. These are good tests. If we have no bad
>> feedback about these, it must mean it's safe to change our global policy
>> to either of those.
>>
>>>> Now, your point about reducing a significant amount of latency is a
>>>> good one.  That's a reasonable reason for such an optimization.  I'm
>>>> not sure if it is a strong enough reason, though.  I think we'd need
>>>> to do a little math to figure out exactly how much it 'costs' to
>>>> read limits and what it would save us to poll them less frequently.
>>>>
>>> It depends on the chip of course - but I think the ADM1026 driver
>>> might be a good model to follow for others which are deemed worth
>>> optimizing.
> 
> 
>>
>> What about trying some real-life tests (that's what it's all about after
>> all)? I could try the different policies on the w83781d driver and
>> measure how much time module loads and data refreshs take.
> 
> 
> 
> Real world test data is always best.
> 
> :v)
> 
> 
> 
