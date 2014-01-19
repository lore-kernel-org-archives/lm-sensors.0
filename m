From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 19 Jan 2014 17:01:13 +0000
Subject: Re: [lm-sensors] Some questions from first user
Message-Id: <52DC04D9.9010202@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
In-Reply-To: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/19/2014 05:51 AM, Jean Delvare wrote:
> Hi Martin,
>
> On Sun, 19 Jan 2014 14:32:37 +0100, Martin Herrman wrote:
>> However, it doesn't reset values to the BIOS settings (I guess it
>> cannot retrieve the BIOS settings). So when removing a setting in
>> sensors.conf and using the init script, will not reset the removed
>> setting to BIOS value.
>
> Indeed BIOS values aren't stored anywhere so the only way to go back to
> them is to cold boot the machine.
>
>> (...)
>> I can explain negative values: BIOS sets offset to 72, so when set to
>> 10 it will decrease by 62 instead of adding 10 :-)
>
> 72 is an unusually high offset. It might have to do with PECI sensor
> type where values are reported relatively to a limit. Different
> monitoring chips handle this case differently.
>

Yes, that is usually what happens with PECI. The 'offset' is really
the maximum temperature, since PECI delivers the difference to that
temperature.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
