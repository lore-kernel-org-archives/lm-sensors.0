From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <Wdb5uxdO.1111740866.9581640.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> > > Then think of reader locking, can drivers simply return
> > > -error_update_in_progress_uncertain_data_value_try_again ?
> >
> > With what benefit, when we can wait a fraction of second and return a
> > valid value?
>
> How driver wait for that?  If writer taken lock, is reader
> blocked?
> Not as far as I see.

It is blocked. It will wait until the lock is released and can be
acquired again. This is why forgetting to release a lock leads to a
driver lockup.

> Perhaps need yet another lock to do this properly, writer takes
> exclusive lock, reader takes non-exclusive lock that will block
> update writers but not other readers.

We don't need this. There are no "pure readers" in our model. The
update function reads from the chip registers and writes to the data
structure. The sysfs write callbacks write to the data structure and
write to the chip registers. So everyone is writing to the data
structure, which means that the lock must be exclusive for everyone.
It's exactly what the lm85, adm1026 and adm1031 drivers do.

> Somewhere I read on lm_sensors to take out 'tickets' so others know
> what is being developed.

Don't trust what you read on this page. it's dead old and outdated (and
hopefully soon gone). This mailing-list is where things are discussed,
so it's already done.

> I'll repost via686a against -mm2 as new thread.

Ok, will review. Sorry I couldn't test your patch as planned yesterday
evening, but I had other tests going on the same machine.

I will (try to) provide patches for the following drivers today: lm63,
lm80, lm83, lm87, lm90, lm92, pc87360. As a side note, the w83l785ts
driver is read-only so it obviously doesn'y need to be updated.

Thanks,
--
Jean Delvare
