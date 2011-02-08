From: "Eibach, Dirk" <Eibach@gdsys.de>
Date: Tue, 08 Feb 2011 15:54:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Consider LM64 temperature offset
Message-Id: <48D3D52125C49B43AE880038E2E5314BB5BE41@SRV101.gdsys.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297170966-13101-1-git-send-email-eibach@gdsys.de> <20110208152815.GA13436@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: linux-kernel@vger.kernel.org, khali@linux-fr.org, lm-sensors@lm-sensors.org


Dear Guenter, 

> Chip id is already detected in lm63_detect. You don't need to 
> detect it again.
> The more common approach would be something along the line of
> 	data->kind = id->driver_data;
>     You would then use
> 	if (data->kind = lm64)
>     throughout the code. In addition to that, you could define
> 	data->kind = id->driver_data;
> 	if (data->kind = lm64)
> 		data->offset = 16000;
>     which would save you the repeated recalculation of offset 
> as mentioned before.

I don't understand, what structures "data" and "id" you are referring to
here and where the fields driver_data and kind come from. I remember to
have seen such in older kernels, but wasn't that replaced sometime ago?

Cheers
Dirk



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
