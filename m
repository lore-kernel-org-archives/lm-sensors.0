From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 31 Mar 2010 15:55:54 +0000
Subject: Re: [lm-sensors] [PATCH] V3, TI ads7871 a/d converter,
Message-Id: <4BB3708A.3030608@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1269124170-11623-1-git-send-email-pthomas8589@gmail.com>
In-Reply-To: <1269124170-11623-1-git-send-email-pthomas8589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/31/10 16:02, Paul Thomas wrote:
> Great, just a couple of responses.
> 

...

>>> +static const struct attribute_group ads7871_group = {
>>> +     .attrs = ads7871_attributes,
>>> +};
>>> +
>>> +static int __devinit ads7871_probe(struct spi_device *spi)
>>> +{
>>> +     int status, ret, err = 0;
>>> +     uint8_t val;
>>> +     struct ads7871_data *pdata;
>>> +
>> There is still a lot of debug code in here that is useful for development
>> but probably doesn't want to be in the final driver.
> I'm happy with what you think is best, but in other driver I've been
> glad to have a little bit in demesg.
Fair enough.  How much you report tends to be a personal decision, so
it's fine with me as is.

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
