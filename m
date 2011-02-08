From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 08 Feb 2011 16:07:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Consider LM64 temperature offset
Message-Id: <20110208160736.GA13717@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297170966-13101-1-git-send-email-eibach@gdsys.de>
 <20110208152815.GA13436@ericsson.com>
 <48D3D52125C49B43AE880038E2E5314BB5BE41@SRV101.gdsys.de>
In-Reply-To: <48D3D52125C49B43AE880038E2E5314BB5BE41@SRV101.gdsys.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Eibach, Dirk" <Eibach@gdsys.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Tue, Feb 08, 2011 at 10:54:52AM -0500, Eibach, Dirk wrote:
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
> here and where the fields driver_data and kind come from. I remember to
> have seen such in older kernels, but wasn't that replaced sometime ago?
> 

static int lm63_probe(struct i2c_client *new_client,
                      const struct i2c_device_id *id)
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
{
	struct lm63_data *data;
	^^^^^^^^^^^^^^^^^^^^^^
	...
	/* Set the device type */
        data->kind = id->driver_data;

with

struct lm63_data {
	...
	int kind;	// instead of is_lm64
	...
};

id is from 

static const struct i2c_device_id lm63_id[] = {
        { "lm63", lm63 },
        { "lm64", lm64 },
        { }
};

id->driver_data is thus either lm63 or lm64, depending on the chip type
detected in lm63_detect().

Thanks,
Guenter 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
