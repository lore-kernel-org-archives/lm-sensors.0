From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: ADM1030 Driver
Message-Id: <20040419231202.4bc24f3e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Concerning the channel configuration, as
> 
> adm1030 can select:
> 	- ext temp for regulation 
> 	- max of the 2 channels
> 
> adm1031 can select:
> 	- ext temp1 for fan1, ext temp2 for fan2
> 	- ext temp1 for fan1 and fan2 
> 	- ext temp2 for fan1 and fan2 
> 	- max of 3 channels for fan1 and fan2
> 
> it is pretty hard to create a standard interface, so what I suggest,
> is to create a file fan_auto_temp_select that would verbosely print
> the values it can hold. Example for adm1030:
> 
> # cat fan_auto_temp_select
>   * 0 => manual mode
>     1 => temp2 controls fan1 temp3 controls fan2
>     2 => temp2 controls fan1 and fan2
>     3 => temp3 controls fan1 and fan2
>     4 => max controls fan1 and fan2
> 
> The star shows the current config.
> 
> Do you like this approach ?

Not at all.

> Is it possible to write as many bytes in the buffer given to the show() interface ?

Probably but with a little more research and work.

> Or do you have another idea ?

I proposed to handle it with a bitfield. A 1 means that the given
temperature channel is taken into account for the given fan speed
control. I agree that it's not immediate but with some extra thinking
and work we can have the ADM1030/1031 fit it this model.

For the adm1030:

- ext temp for regulation
  file 1 value is 00000010b

- max of the 2 channels
  file 1 value is 00000011b

For the adm101:
- ext temp1 for fan1, ext temp2 for fan2
  file 1 value is 00000010b
  file 2 value is 00000100b

- ext temp1 for fan1 and fan2 
  file 1 value is 00000010b
  file 2 value is 00000010b

- ext temp2 for fan1 and fan2 
  file 1 value is 00000100b
  file 2 value is 00000100b

- max of 3 channels for fan1 and fan2
  file 1 value is 00000111b
  file 2 value is 00000111b

So "decoding" it is easy. Now for encoding it's somewhat more tricky,
admittedly, because you write to a single file at a time while the
values are linked. That's not the first time we have to do that. There's
a first example in lm90.c.

If the value written is just not possible (say 00000110b to file 1) just
return an error (-EINVAL).

If it is possible and is compatible with the current value of the other
file, do the change.

If it is possible but not compatible with the current value of the other
file, change the other file, preferably to the "nearest" value.

The main advantage of this method compared with yours is that we can
hope to implement it in a similar and compatible way for the other
chipsets as well, thus preserving our ultimate goal: chip-independancy.

Does it sound feasable?

BTW remember that you can always propose a not full-features driver yet,
and add the extra features as further patches.

Also, how do you plan to add support to the user space (sensors and
libsensors?) Looks like you need a 2.4 driver as well to do it the same
way the other drivers do. So either you will have to backport it, or we
will have to find a trick.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
