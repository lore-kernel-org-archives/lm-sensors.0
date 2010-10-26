From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Oct 2010 20:30:22 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <20101026223022.3df3a74d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 Oct 2010 22:09:39 +0200, Karsten de Freese wrote:
> hi Jean,
> 
> 
> Am 26.10.2010 21:06, schrieb Jean Delvare:
> > I think you forgot to check the FAQ and in particular:
> > http://www.lm-sensors.org/wiki/FAQ/Chapter3#Isetnewlimitsanditdidntwork
> >
> >    
> indeed - I remember having read that before, but just forgot ..
> 
> now setting the limits does work for jc42 _min and _max values, however 
> not for _max_hyst (although the setting seems to exist)
> 
> The latest config file:
> 
> /bus "i2c-0" "SMBus PIIX4 adapter at 0b00"
> 
> chip "jc42-i2c-0-18"
>          label temp1 "DRAM_0"
>          set temp1_max 60
>          set temp1_crit 70
>          set temp1_max_hyst 65
> 
> chip "jc42-i2c-0-19"
>          label temp1 "DRAM_1"
>          set temp1_max 60
>          set temp1_crit 70
>          set temp1_max_hyst 65
> /
> and the latest output
> /karsten:~/temp$ sudo sensors -s
> Error: File /etc/sensors.d/jc42.conf, line 7: Failed to set value
> jc42-i2c-0-18: At least one "set" statement failed
> Error: File /etc/sensors.d/jc42.conf, line 14: Failed to set value
> jc42-i2c-0-19: At least one "set" statement failed/

There's a trick: temp1_max_hyst exists but is read-only.
temp1_crit_hyst is writable, set it and the same delta will be applied
to temp1_max_hyst (relative to temp1_max, obviously.) The reason is
that there's only one register in the chip to store the delta, and it
applied to both limits.

> (actually I get the same error message for the K10temp _min & _max 
> settings, but maybe these are hardwired?)

Yes they are hardwired for k10temp.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
