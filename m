From: Doug Anderson <dianders@chromium.org>
Date: Tue, 29 Jan 2013 21:46:52 +0000
Subject: Re: [lm-sensors] MAX1363 IIO driver questions
Message-Id: <CAD=FV=U1mNJE--S0QrYUe6T5k4B-RNm4xc2WWOrYoR1iuvBABA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121124052707.GA17392@roeck-us.net>
	<50B09EDC.4020200@kernel.org>
	<20130116054918.GA7056@roeck-us.net>
	<50F667C9.6000106@jic23.retrosnub.co.uk>
	<20130117204549.GB22045@roeck-us.net>
	<8649d873-66ef-4b0f-a22d-8480e5aa1ead@email.android.com>
	<20130118220922.GB12459@roeck-us.net>
	<5103BD2F.30405@kernel.org>
	<20130129200055.GA18207@roeck-us.net>
	<51082CB1.1050401@metafoo.de>
	<20130129210550.GA18566@roeck-us.net>
	<51083D3E.7090008@metafoo.de>
In-Reply-To: <51083D3E.7090008@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, linux-iio <linux-iio@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>

Lars / Guenter,

On Tue, Jan 29, 2013 at 1:21 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 01/29/2013 10:05 PM, Guenter Roeck wrote:
>> On Tue, Jan 29, 2013 at 09:10:25PM +0100, Lars-Peter Clausen wrote:
>>> I wrote in another mail a few days ago, how I think dt bindings for IIO could
>>> be implemented. The basic idea was to simply use bindings very similar to what
>>> the clk API uses, since its provider/consumer structure actually matches what
>>> we do in IIO pretty good.
>>>
>>> The full mail can be found here:
>>> http://marc.info/?l=linux-iio&m5902119507483&w=2
>>>
>> Hi Lars,
>>
>> looks like a good idea.
>>
>> Do you know if anyone is working on an implementation ?
>> Otherwise I'll give it a shot.
>
> I unfortunately dont have time for this atm, but maybe Naveen or Dou is working
> on it. Added them to Cc.

I believe Naveen was going to work on this but I found out this
morning that he had to go on leave for some days so I'm not sure when
he might respond.  If you want to take a whack at implementing the
bindings I don't think he would mind, though.  ...then he'd be able to
build on the same bindings to get the Samsung ADC working.  :)

-Doug

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
