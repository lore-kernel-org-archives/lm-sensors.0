From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 30 Jun 2010 11:20:21 +0000
Subject: Re: [lm-sensors] config for Gigabyte P55-US3L
Message-Id: <20100630132021.5d6ff989@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.00.1006301403230.25622@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.00.1006301403230.25622@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuri,

On Wed, 30 Jun 2010 14:04:58 +0400 (MSD), yuri.nefedov@gmail.com wrote:
> 
>   Unfortunately wiki page (http://www.lm-sensors.org/wiki/Configurations)
>   is not working  (requires authorization).

It is working. There's no rule stating that all wikis in the world have
to be publicly writable.

Actually we would love to make it writable again, if it didn't result
in a huge amount of spam we have no time to deal with.

>   So I send the configuration in the attachment.
> 
>   I used the following modules:
> # Chip drivers
> it87
> coretemp
> 
>   The output of sensors is:
> it8720-isa-0290
> Adapter: ISA adapter
> VCore1:      +0.85 V  (min =  +0.66 V, max =  +1.39 V)
> DDR15V:      +1.58 V  (min =  +1.39 V, max =  +1.60 V)
> +3.3V:       +3.34 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:         +4.97 V  (min =  +4.76 V, max =  +5.24 V)
> in4:         +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> +12V:       +11.92 V  (min = +11.37 V, max = +12.59 V)
> in6:         +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> -12V:       -12.01 V  (min = -10.84 V, max = -13.17 V)

This one is wrong. in7 is 5VSB on all IT8720F chips, because it's
internal. So you want:

   label in7 "5VSB"
   compute  in7  @ * (6.8/10+1), @ / (6.8/10+1)

If the value isn't correct for you, then you probably need the
following patch of mine:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-it87-fix-in7-on-IT8720F.patch

According to my notes, all Gigabyte boards need it (BIOS bug.)

> VBat:        +3.25 V
> CPU Fan:    1285 RPM  (min = 1000 RPM)
> Case Fan:    928 RPM  (min =    0 RPM)
> PCH Temp:    +32.0C  (low  = +127.0C, high = +50.0C)  sensor = thermistor
> CPU Temp:    +24.0C  (low  = +127.0C, high = +70.0C)  sensor = thermistor
> cpu0_vid:   +0.313 V
> 
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +31.0C  (high = +84.0C, crit = +100.0C)
> 
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +27.0C  (high = +84.0C, crit = +100.0C)
> 
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +37.0C  (high = +84.0C, crit = +100.0C)
> 
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +27.0C  (high = +84.0C, crit = +100.0C)
> 
>   Thank you for your wonderful program.

You're welcome :)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
