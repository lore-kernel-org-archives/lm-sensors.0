From: Per =?iso-8859-1?Q?Dal=E9n?= <per.dalen@appeartv.com>
Date: Wed, 06 Apr 2011 20:22:43 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for MAX6642
Message-Id: <22597.212.251.245.59.1302121363.squirrel@webmail.s7.itpays.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D9CB118.80103@appeartv.com>
In-Reply-To: <4D9CB118.80103@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> On Wed, Apr 06, 2011 at 03:06:13PM -0400, Per Dal=E9n wrote:
>> On 04/06/2011 08:58 PM, Guenter Roeck wrote:
>> > Hi Per,
>> >
>> > On Wed, Apr 06, 2011 at 02:29:44PM -0400, Per Dal=E9n wrote:
>> >> First a big thanks to Guenter Roeck for helping me (allot) to cleanup
>> >> this driver
>> >>
>> >> v3 -> v4:
>> >>  * Removed "data->valid =3D 0;" (missed that in v3 ;)
>> >>  * only read the limits once
>> >>  * changed the temp_input and temp_high as suggested by Guenter, also
>> >> changed the functions/macros related to that change
>> >
>> >> MAX6642 is a SMBus-Compatible Remote/Local Temperature Sensor with
>> Overtemperature Alarm from Maxim.
>> >>
>> >> Signed-off-by: Per Dalen <per.dalen@appeartv.com>
>> >>
>> > Sorry, one more detail I just noticed. More of a question.
>> >
>> > [ ... ]
>> >> +
>> >> +static struct max6642_data *max6642_update_device(struct device
>> *dev)
>> >> +{
>> >> +	struct i2c_client *client =3D to_i2c_client(dev);
>> >> +	struct max6642_data *data =3D i2c_get_clientdata(client);
>> >> +	u16 val, tmp;
>> >> +
>> >> +	mutex_lock(&data->update_lock);
>> >> +
>> >> +	if (time_after(jiffies, data->last_updated + HZ * 8) ||
>> !data->valid) {
>> >
>> > Are you sure you only want to update readings every 8 seconds ?
>>
>> No, this is wrong from me. Every second, or what do you think?
>>
> Something like that, or HZ + HZ/<fraction> if you want to be fancy.
>
>> >
>> > Also, after spending all this time on this driver (and after falling
>> into
>> > the same trap last night with another driver ;), it looks like this is
>> really
>> > just another variant of the lm90, and adding support for max6642 to
>> the lm90
>> > driver might be quite trivial. Have you considered this ?
>>
>> Hmmm, ;)
>>
>> "Re: [lm-sensors] [PATCH] hwmon: (lm90) Add support for max6642
>>
>> On 03/03/2011 08:55 PM, Guenter Roeck wrote:
>> With all the differences and lacking registers, I wonder if it would be
>> better to write a new driver, either based on this driver of based on
>> the max1619 driver.
>>
>> Guenter"
>>
> Guess you got me there. But then this was more than a month ago, and it
> was
> my birthday, so who knows how much blood was left in my alcohol ;).

Ok, that is something I can relate to ;)

Do you think I should do the last fix on the max6642 driver or should I
add it to lm90?

>
> Thanks,
> Guenter
>

/Per


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
