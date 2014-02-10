From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 10 Feb 2014 18:55:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6650) Rename the device ids to contain the hwmon suffix
Message-Id: <20140210195516.07405462@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392045953-26596-1-git-send-email-lpapp@kde.org>
	<20140210160842.GB26997@lee--X1>
	<20140210173811.04ba5964@endymion.delvare>
	<20140210165853.GD26997@lee--X1>
	<20140210184323.456e921c@endymion.delvare>
	<CAOMwXhPdu=uNEcffKdmjKsD0q5SKiwDx_Hnv8BTbSsGzqa4SGQ@mail.gmail.com>
In-Reply-To: <CAOMwXhPdu=uNEcffKdmjKsD0q5SKiwDx_Hnv8BTbSsGzqa4SGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laszlo Papp <lpapp@kde.org>
Cc: Jean Delvare <jdelvare@suse.de>, Lee Jones <lee.jones@linaro.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Mon, 10 Feb 2014 18:27:07 +0000, Laszlo Papp wrote:
> On Mon, Feb 10, 2014 at 5:43 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > On Mon, 10 Feb 2014 16:58:53 +0000, Lee Jones wrote:
> >> > > Might be worth taking the opportunity to swap out these magic numbers
> >> > > now.
> >> >
> >> > There's nothing magic about them, they tell the driver how many fans
> >> > each device supports. If you don't pass them as driver_data you'll have
> >> > to derive them from the device name in the probe function.
> >>
> >> They're magic in that they're not easily identifiable. In the few
> >> moments that I looked at the patch I assumed they were device
> >> IDs. They should be clearly defined.
> >
> > They could have been device IDs, some drivers do that, and that would
> > have been equally fine. driver_data can be anything. Best thing to do
> > is to document it right above the device id array if you really find it
> > confusing (I don't.) I don't know what else exactly you had in mind,
> > but #defining FOUR_FANS as 4 and ONE_FAN as 1 and using that doesn't
> > strike me as the best coding practice.
> 
> Err... no. 1/4 fan is not the only difference between max6650 and
> max6651 ... (might be worth looking up the datasheet).

This is the only difference the driver cared about so far, so the code
made sense. If the driver is extended to support features which differ
between the MAX6650 and MAX6651 then it will make sense to revisit, of
course.

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
