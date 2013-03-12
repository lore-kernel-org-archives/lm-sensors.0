From: Doug Anderson <dianders@chromium.org>
Date: Tue, 12 Mar 2013 23:26:42 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: ntc: Add DT with IIO support to NTC thermistor driver
Message-Id: <CAD=FV=Wn5=XVUNXia1=9oEXA89gVPkjP7+itewXjXa19r-o6ZA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1363077566-6254-1-git-send-email-ch.naveen@samsung.com>
	<20130312134528.GA28019@roeck-us.net>
In-Reply-To: <20130312134528.GA28019@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Jean Delvare <khali@linux-fr.org>, Naveen Krishna <naveenkrishna.ch@gmail.com>

Hi,

On Tue, Mar 12, 2013 at 6:45 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Mar 12, 2013 at 02:09:26PM +0530, Naveen Krishna Chatradhi wrote:
>> This patch adds DT support to NTC driver to parse the
>> platform data.
>>
>> Also adds the support to work as an iio device.
>>
>> During the probe ntc driver gets the respective channels of ADC
>> and uses iio_raw_read calls to get the ADC converted value.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>

I know that there is still work to do to address Guenter's comments,
but I spent a little time playing with this today to see what else was
missing and actually got it working.  :)  I'll add a "Tested-by" once
Naveen reposts.

I sent up my patches that I needed to the ADC + device trees to get it
working, but I just realized that I forgot to CC Guenter.  Doh!  In
case you're curious, you can find them at:
* https://patchwork.kernel.org/patch/2260231/
* https://patchwork.kernel.org/patch/2260211/
* https://patchwork.kernel.org/patch/2260221/
* https://patchwork.kernel.org/patch/2260201/


> You'll still need the conditional dependency on IIO in Kconfig.
> Something like
>         depends on IIO if OF
> if that works, or alternatively
>         select IIO if OF
> if that is acceptable.

This was important for me.  I had IIO setup as a module and adc
configured an in-kernel.  Without the above I got a nice linker error.
 ;)
The syntax that worked for me was 'select IIO if OF'.  I don't think
you can do a conditional depends on (it didn't work for me and I
couldn't find any examples like that).


>> +Read more about iio bindings at
>> +     Documentation/devicetree/bindings/iio/iio-bindings.txt
>> +

BTW: the above line had a whitespace error on it.  Double-check that
it's gone for the next version.


-Doug

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
