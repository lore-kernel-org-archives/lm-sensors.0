From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Wed, 31 Oct 2007 19:20:24 +0000
Subject: Re: [lm-sensors] lm_sensors on ASUS M2NPV-VM motherboard using
Message-Id: <4728D578.4050201@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46ED7EFC.4030609@Winfirst.Com>
In-Reply-To: <46ED7EFC.4030609@Winfirst.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/31/07 11:47, Jean Delvare wrote:
> Hi Mark,
> 
> On Sun, 28 Oct 2007 13:39:21 -0700, Mark E. Hansen wrote:
>> On 10/28/07 07:44, Jean Delvare wrote:
>> > * Find working configuration files for boards similar to yours, they
>> >   might hold valuable hints.
>> 
>> But if I understand it correctly, it's not just that they use the same
>> chipset and sensor chips, but the resistors they use could easily be
>> different (even the type of heat sensor, for example), right?
> 
> You are right. But manufacturers have their habits, so two motherboards
> from a given manufacturer using the same monitoring chip are likely to
> share some settings.

Okay, I see.

> 
>> > This is tricky either way. It took me two years to be able to write
>> > custom configuration files with good results, so I don't really expect
>> > users to get it right at their first try.
>> 

[ snip ]

> 
>> (...)
>> If it really is using the IT8716F, then I think I read something somewhere
>> that this chip is not really supported yet, and a kernel patch was
>> required. Is that right?
> 
> Depends on what kernel version you're using. I added support for the
> IT8716F in 2.6.19. For 2.6.17 and 2.6.18, there are kernel patches.
> 

Oh, this may be a problem. I'm running CentOS 4.5, which uses kernel 2.6.9.
I would imagine that it would take more than just building a new kernel to
get my machine up to that level (I'm assuming there would be a lot of
dependent packages that would need to be upgraded first, etc.).

Is there any way to apply this patch to a 2.6.9 kernel? (probably not...)

I guess I'll start looking into upgrading my machine to CentOS 5.0 (which
uses kernel 2.6.18, if I understand the site correctly).

Thanks for your help.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
