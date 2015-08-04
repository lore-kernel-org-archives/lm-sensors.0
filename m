From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 04 Aug 2015 21:24:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for IT8732F
Message-Id: <55C12D98.5060603@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/04/2015 02:03 PM, Jean Delvare wrote:
> On Tue,  4 Aug 2015 12:45:31 -0700, Justin Maggard wrote:
>> Add support for the IT8732F.  This chip is pretty similar to IT8721F,
>> with the main difference being that the ADC LSB is 10.9 mV instead of
>> 12 mV.
>
> 10.9 mV. No kidding. Sigh.
>
> Drunk people shouldn't be allowed to design chipsets really.
>

Well, we are lucky. It could be 10.931 mV, after all. Wait, maybe it is ;-).

Makes me wonder, though - I hope this is a real chip value and not just
the value computed as the result after some external resistor pre-scaling.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
