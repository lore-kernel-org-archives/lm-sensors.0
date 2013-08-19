From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 19 Aug 2013 13:40:51 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6681D/NCT7802 Support?
Message-Id: <52122063.5010803@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFqD5d+OcNEF0KoPn9qUNomYvmH14EuoRtVv-59xG5hcYrGduw@mail.gmail.com>
In-Reply-To: <CAFqD5d+OcNEF0KoPn9qUNomYvmH14EuoRtVv-59xG5hcYrGduw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/18/2013 01:12 PM, Pedro wrote:
>> On Sat, Sep 17, 2011 at 09:10:11PM -0400, Jeffrey Chenkus wrote:
>> > Is there any plan to add support for the Nuvoton NCT6681D and NCT7802 chips?
>>
>> Jeffrey,
>>
>> Following up on this ... I plan to write a driver to support NCT6683D, which
>> presumably is similar to NCT6681D (still waiting for confirmation from Nuvoton,
>> though). Do you still have the need/ability to test a driver for NCT6681D ?
>>
>> Thanks,
>> Guenter
> Hi Guenter, hi list,
>
> I'm joining the fight ! I have a all brand new Asus Z87 motherboard with Nuvoton NCT7802 chip with it.
> So i'm definitely in need for linux support and i can help testing a driver.
>
> While running Linux i just can't control the fan behaviour. I would like to have the ability to set temperature thresholds for slowing fans as i can do with Fan Xpert in Windows. I know how to compile a kernel module and how to test it. I can test different kernels if it can help.
> currently 3.8.0-27-generic #40-Ubuntu SMP Tue Jul 9 00:17:05 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
>
I added the chip and your request to the lm-sensors page. As this is a new chip,
we will have to find someone to write a new driver for it.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
