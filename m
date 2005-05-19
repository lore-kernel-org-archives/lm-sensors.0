From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: ADM1030 Driver
Message-Id: <1082409370.656.29.camel@megapc>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I proposed to handle it with a bitfield. A 1 means that the given
> temperature channel is taken into account for the given fan speed
> control. I agree that it's not immediate but with some extra thinking
> and work we can have the ADM1030/1031 fit it this model.
> 
> For the adm1030:
> 
> - ext temp for regulation
>   file 1 value is 00000010b
> 
> - max of the 2 channels
>   file 1 value is 00000011b
> 
> For the adm101:
> - ext temp1 for fan1, ext temp2 for fan2
>   file 1 value is 00000010b
>   file 2 value is 00000100b
> 
> - ext temp1 for fan1 and fan2 
>   file 1 value is 00000010b
>   file 2 value is 00000010b
> 
> - ext temp2 for fan1 and fan2 
>   file 1 value is 00000100b
>   file 2 value is 00000100b
> 
> - max of 3 channels for fan1 and fan2
>   file 1 value is 00000111b
>   file 2 value is 00000111b
> 
> So "decoding" it is easy. Now for encoding it's somewhat more tricky,
> admittedly, because you write to a single file at a time while the
> values are linked. That's not the first time we have to do that. There's
> a first example in lm90.c.
> 
> If the value written is just not possible (say 00000110b to file 1) just
> return an error (-EINVAL).
> 
> If it is possible and is compatible with the current value of the other
> file, do the change.
> 
> If it is possible but not compatible with the current value of the other
> file, change the other file, preferably to the "nearest" value.
> 
> The main advantage of this method compared with yours is that we can
> hope to implement it in a similar and compatible way for the other
> chipsets as well, thus preserving our ultimate goal: chip-independancy.
> 
> Does it sound feasable?
I'm going to try such an implementation.

> 
> BTW remember that you can always propose a not full-features driver yet,
> and add the extra features as further patches.
> 
> Also, how do you plan to add support to the user space (sensors and
> libsensors?) Looks like you need a 2.4 driver as well to do it the same
> way the other drivers do. So either you will have to backport it, or we
> will have to find a trick.
When the 2.6 driver will be finnished, I'll backport it to the 2.4
kernel if you want me to.
But as I have only a adm1030 chip on my motherboard, the 1031 features
will not be tested...

> Thanks.
