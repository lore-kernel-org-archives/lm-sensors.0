From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 14 Jul 2007 17:22:41 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver\
Message-Id: <46990661.6080402@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713002836.GR3435@tree.beaverton.ibm.com>
In-Reply-To: <20070713002836.GR3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Vadim Zeitlin wrote:
> On Sat, 14 Jul 2007 18:19:22 +0200 Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> 
> HdG> > and the AMB sensors 2 and 3 were not being taken into account. Without knowing
> HdG> > anything about libsensors I thought it was because the file names in
> HdG> > /sys/devices/platform/i5k_amb.0 were named {temp0,temp16,temp32,temp48}_xxx and
> HdG> > not temp[1234] as usual
> HdG> 
> HdG> Yes, thats a rather severe violation of the hwmon sysfs standard. I do not see 
> HdG> this i5k_amb driver in the standard kernel, I assume its an addon driver?
> 
>  Hello Hans,
> 
>  This is the patch recently posted to the list:
> 
> 	http://article.gmane.org/gmane.linux.drivers.sensors/14004
> 
> sorry for not mentioning it (I forgot I was replying in a different thread
> from my reply in that one).
> 

Duh, I actually still have that mail in my Inbox, as I'm planning on reviewing 
it as time permits.

> HdG> > and now everything seems to work fine for me except for the 2
> HdG> > problems mentioned in my previous message (long delay when accessing
> HdG> > the sensors and manifestly incorrect values for temp[256]):
> HdG> 
> HdG> Does this long delay always happen? If you run sensors in 2 quick
> HdG> successions, the second call should be quite fast.
> 
>  No, the delay is always present and always the same.
> 

Hmm,

I see it refresh the readings every 2 seconds, since reading things takes 1 sec 
minimum, I think it would be a good idea to make this somewhat bigger. Darrick, 
can you post a new version and or an incremental patch with a slower read 
frequency, say once every 5 or 10 seconds?

Also I notice that you are still doing a full read of the chip to data->raw, 
this might very well explain some if the slowness. Please remove raw[] from 
data and the full read code from the update() function.

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
