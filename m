From: "John Smith" <Kidfromaussie@gmx.com>
Date: Mon, 25 Jul 2011 09:25:33 +0000
Subject: Re: [lm-sensors] Config for Gigabyte GA-G31M-ES2L
Message-Id: <20110725092534.315740@gmx.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110725080443.315720@gmx.com>
In-Reply-To: <20110725080443.315720@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org



On the other hand,after more looking into it , inputs in4 and in7 might be different
in4 might be representing +12V using unusual scaling and
in7 might be +5VSB 


> 
> chip "it8718-*"
> 
> ### Voltages
> 
>    label  in0  "Vcore"
>    label  in1  "DDR18V"    # "DDR18V" in BIOS
>    label  in2  "+3.3V"
>    label  in3  "+5V"     # Not in BIOS
>    label  in4  "in4"     # Not in BIOS Misterious ?? 0.34v idle; 0.62v under load
>    ignore in5         # raw reads: +4.08 V
>    ignore in6         # raw reads: +4.08 V
>    label  in7  "+12V"
> # i think in8 should be ignored too ,verbatim from G33-DS3R
>    label  in8  "Vbat"    # Not in BIOS,raw reads +3.14 V as in7 ?? 
--


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
