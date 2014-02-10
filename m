From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 10 Feb 2014 18:15:08 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6650) Rename the device ids to contain the hwmon suffix
Message-Id: <20140210191508.1a37505f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392045953-26596-1-git-send-email-lpapp@kde.org>
	<20140210160842.GB26997@lee--X1>
	<20140210173811.04ba5964@endymion.delvare>
	<20140210165853.GD26997@lee--X1>
	<20140210184323.456e921c@endymion.delvare>
	<20140210180159.GF26997@lee--X1>
In-Reply-To: <20140210180159.GF26997@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Laszlo Papp <lpapp@kde.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Mon, 10 Feb 2014 18:01:59 +0000, Lee Jones wrote:
> > > > > Might be worth taking the opportunity to swap out these magic numbers
> > > > > now.
> > > > 
> > > > There's nothing magic about them, they tell the driver how many fans
> > > > each device supports. If you don't pass them as driver_data you'll have
> > > > to derive them from the device name in the probe function.
> > > 
> > > They're magic in that they're not easily identifiable. In the few
> > > moments that I looked at the patch I assumed they were device
> > > IDs. They should be clearly defined.
> > 
> > They could have been device IDs, some drivers do that, and that would
> > have been equally fine. driver_data can be anything. Best thing to do
> > is to document it right above the device id array if you really find it
> > confusing (I don't.) I don't know what else exactly you had in mind,
> > but #defining FOUR_FANS as 4 and ONE_FAN as 1 and using that doesn't
> > strike me as the best coding practice.
> 
> On the contrary. Perhaps the nomenclature can be worked on a little,
> but if I saw the aforementioned defines I would have known instantly
> what was being defined without searching for co-located comments. Thus
> elevating the requirement for me to even mention it. Even when we
> use the .data element for very simple information such as device IDs
> we do so with a #define.

Right, you have a point here.

I suppose it was deemed unneeded for a ~750 lines driver nobody really
cared about. But if the driver is becoming more complex and popular
then indeed it makes sense to clean it up a little. Starting with
reordering functions to kill forward declarations ^^

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
