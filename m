From: Wayne Tams <wayne.tams@gmail.com>
Date: Tue, 20 Dec 2011 16:00:35 +0000
Subject: Re: [lm-sensors] i2cdetect running slow but not "bus inactive" slow,
Message-Id: <CAN=k24kfHvkSs1QyYZopHPGc2EfrONzceu03C_cBrr7ou-_mYg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAN=k24=RXfkyzdLqF2=xSU6nHT28YGwFFu9TDfJihn7wg8tsLQ@mail.gmail.com>
In-Reply-To: <CAN=k24=RXfkyzdLqF2=xSU6nHT28YGwFFu9TDfJihn7wg8tsLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Turns out it was an I2C voltage translator had popped, thankfully all
my I2C devices are ok. Did not realise i2cdetect could behave in such
a peculiar way.

Thanks

Wayne

On Fri, Dec 16, 2011 at 4:29 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Fri, 2011-12-16 at 10:33 -0500, Wayne Tams wrote:
>> Hi,
>>
>> i2cdetect is behaving in a fashion that I have not seen before and I
>> just would like to know if anyone has a suggestion on what it is
>> telling me.
>>
>> Normally i2cdetect returns in <1s, if the bus were inactive it would
>> take closer to 20s. However I'm finding that the scanning is taken a
>> round 5s and the addresses returned appear random, except for one.
>> Obviously there must be a fault in my hardware, but I just wanted to
>> make sure that was/wasn't a common explanation for this behaviour
>> before I go debugging up the wrong tree.
>
> I typically see this kind of problem if there is something wrong on the
> i2c bus, for example if a signal is pulled high or low. I have also seen
> it after I managed to physically "destroy" an I2C controller by applying
> a reversed voltage to the i2c signal pins.
>
> If you have a logic analyzer or a scope, you might want to connect it to
> the clock and data lines to see what is happening on the bus.
>
> Guenter
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
