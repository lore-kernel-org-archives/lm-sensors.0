From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 08 Feb 2011 16:09:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Consider LM64 temperature offset
Message-Id: <20110208170951.2cc64a62@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297170966-13101-1-git-send-email-eibach@gdsys.de>
	<20110208152815.GA13436@ericsson.com>
	<48D3D52125C49B43AE880038E2E5314BB5BE41@SRV101.gdsys.de>
In-Reply-To: <48D3D52125C49B43AE880038E2E5314BB5BE41@SRV101.gdsys.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Eibach, Dirk" <Eibach@gdsys.de>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Dirk,

On Tue, 8 Feb 2011 16:54:52 +0100, Eibach, Dirk wrote:
> 
> Dear Guenter, 
> 
> > Chip id is already detected in lm63_detect. You don't need to 
> > detect it again.
> > The more common approach would be something along the line of
> > 	data->kind = id->driver_data;
> >     You would then use
> > 	if (data->kind = lm64)
> >     throughout the code. In addition to that, you could define
> > 	data->kind = id->driver_data;
> > 	if (data->kind = lm64)
> > 		data->offset = 16000;
> >     which would save you the repeated recalculation of offset 
> > as mentioned before.
> 
> I don't understand, what structures "data" and "id" you are referring to

data is struct lm63_data and id is const struct i2c_device_id which is
passed as a second parameter to the probe function.

> here and where the fields driver_data and kind come from. I remember to
> have seen such in older kernels, but wasn't that replaced sometime ago?

There were indeed some changes in this area in the past few years, but
what Guenter says still applies to current kernels. Look at lm90_probe()
in drivers/hwmon/lm90.c for an example (amongst may others.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
