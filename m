From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 23 Oct 2014 13:43:00 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (i5500_temp) Don't bind to disabled sensors
Message-Id: <544905E4.7030701@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141022111321.22ab7122@endymion.delvare>
In-Reply-To: <20141022111321.22ab7122@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/23/2014 06:26 AM, Jean Delvare wrote:
> On Thu, 23 Oct 2014 06:15:50 -0700, Guenter Roeck wrote:
>> On 10/23/2014 01:44 AM, Jean Delvare wrote:
>>> Another interesting register in device 00:14.2 is THRERRCTL. It's set
>>> to 0x5 on the one working board I have access to, and to 0x0 on
>>> non-working ones.
>>
>> Can you set it on the non-working boards ?
>
> Mind you, I tried that already, but it didn't help :( So either it is a
> hardware issue (pins not connected as you suggested before) or it takes
> a combination of changes to get it to work and we did not find all the
> steps, or didn't apply them all at the same time, or not in the right
> order... Maybe Romain will have more luck than me.
>
Should have guessed. Well, you can only do so much.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
