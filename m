From: Chris Rodley <chris@snapithd.com>
Date: Thu, 29 Aug 2013 03:18:55 +0000
Subject: Re: [lm-sensors] sht15 kernel driver
Message-Id: <521EBD9F.7070502@snapithd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <521E7CA7.5060407@snapithd.com> <87fvtt4dmt.fsf@jerows.sfl>
In-Reply-To: <87fvtt4dmt.fsf@jerows.sfl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Cc: kernel@savoirfairelinux.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Thanks Jerome!

That was just what I needed to know.
The device is now set up and is working well - I will have a go at back 
porting now.

Many thanks again for your help!
Chris

On 29/08/13 11:08, Jerome Oufella wrote:
>> Hi,
>>
>> I am trying to get a sht75 humidity and temperature sensor working
>> with the linux kernel module in 3.2.
>> Is there a code example for application code that you have available?
>>
>> Many thanks,
> Hi Chris,
>
> There was much less support for the sht15 back in 3.2 compared to recent
> kernel releases. You may want to backport features and/or fixes to suit
> your needs.
>
> You can find a usage example for 3.2 in arch/arm/mach-pxa/stargate2.c
> around line 140:
>
> First, create a platform data struct and specify which GPIO lines are
> hooked to the data and sck lines of your sht-15:
>   
>   static struct sht15_platform_data platform_data_sht15 = {
>          .gpio_data =  100,
>          .gpio_sck  =  98,
>   };
>
> Then setup a platform device referencing those platform data, that you
> will have to register on the platform bus using platform_add_devices()
> or equivalent:
>
>   static struct platform_device sht15 = {
>          .name = "sht15",
>          .id = -1,
>          .dev = {
>                  .platform_data = &platform_data_sht15,
>          },
>   };
>
>   ...
>
>   platform_add_devices(...);
>
>
>
> Cheers,


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
