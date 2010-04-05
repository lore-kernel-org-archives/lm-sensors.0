From: Paul Thomas <pthomas8589@gmail.com>
Date: Mon, 05 Apr 2010 18:57:27 +0000
Subject: Re: [lm-sensors] [PATCH] V3, TI ads7871 a/d converter,
Message-Id: <y2qc785bba31004051157u79cc6b33p461af441f21f8f1b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1269124170-11623-1-git-send-email-pthomas8589@gmail.com>
In-Reply-To: <1269124170-11623-1-git-send-email-pthomas8589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Mar 31, 2010 at 8:55 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 03/31/10 16:02, Paul Thomas wrote:
>> Great, just a couple of responses.
>>
>
> ...
>
>>>> +static const struct attribute_group ads7871_group =3D {
>>>> + =A0 =A0 .attrs =3D ads7871_attributes,
>>>> +};
>>>> +
>>>> +static int __devinit ads7871_probe(struct spi_device *spi)
>>>> +{
>>>> + =A0 =A0 int status, ret, err =3D 0;
>>>> + =A0 =A0 uint8_t val;
>>>> + =A0 =A0 struct ads7871_data *pdata;
>>>> +
>>> There is still a lot of debug code in here that is useful for developme=
nt
>>> but probably doesn't want to be in the final driver.
>> I'm happy with what you think is best, but in other driver I've been
>> glad to have a little bit in demesg.
> Fair enough. =A0How much you report tends to be a personal decision, so
> it's fine with me as is.
>
> Jonathan
>

Is there a staging git tree for hwmon? I see this:
http://lm-sensors.org/kernel, but both branches look old. Should I cc
another mailing list with this patch? I'm just trying to understand
how the flow between hwmon and the upstream kernel stuff works.

thanks,
Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
