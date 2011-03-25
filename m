From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Mar 2011 12:00:51 +0000
Subject: Re: [lm-sensors] [config] sensors.d config for Zotac ZBox HD-ID11
Message-Id: <20110325130051.7807ac18@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <21E792C5-FD4F-487B-B8B8-E35B18F218DF@wsisiz.edu.pl>
In-Reply-To: <21E792C5-FD4F-487B-B8B8-E35B18F218DF@wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 25 Mar 2011 11:49:14 +0100, Piotr Maksymiuk wrote:
> Actually, turns out i was wrong about one sensor (temp1 is not GPU but
> the M/B chipset, unfortunately the i2c supplied with nvidia drivers do
> not report any thermal information). Could you update the entry with
> this?

Done. Minor comments below:

> ##/etc/sensors.d/zbox-hd-id-11
> 
> chip "w83667hg-isa-0a10"
> 
>    # Voltages
> 
>    label  in0 "Vcore"
>    label  in1 "RAM"
>    label  in2 "AVCC"
>    label  in3 "+3.3V"
>    label  in4 "Chipset"
>    label  in5 "+1.5V"
>    label  in6 "3VSB"

Did you drop the in7 label ("VBatt") on purpose?

> 
>    set in0_min  1.1 * 0.90
>    set in0_max  1.1 * 1.10
>    set in1_min  1.9 * 0.90
>    set in1_max  1.9 * 1.10
>    set in2_min  3.3 * 0.90
>    set in2_max  3.3 * 1.10
>    set in3_min  3.3 * 0.90
>    set in3_max  3.3 * 1.10
>    set in4_min  1.1 * 0.90
>    set in4_max  1.1 * 1.10
>    set in5_min  1.5 * 0.90
>    set in5_max  1.5 * 1.10
>       

Trailing white space here, removed.

>    # Fans
> 
>    # Only fan2 is used in this barebone.
>    ignore fan1
>    label  fan2 "Case Fan"
>    ignore fan3
>    ignore fan4
>    ignore fan5
> 
>    set fan2_min  800
> 
>    # Temperatures
> 
>    #unfortunately i'm not sure if temp3 is ram
>    label  temp1 "M/B Temp"
>    label  temp2 "CPU Temp"
>    label  temp3 "RAM Temp"
> 
>    #this always returns a 0 reading
>    ignore cpu0_vid
> 
>    set temp1_max       50
>    set temp1_max_hyst  40
> 
>    set temp2_max       75
>    set temp2_max_hyst  60
> 
>    set temp3_max       35
>    set temp3_max_hyst  30

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
