From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 May 2011 12:24:07 +0000
Subject: Re: [lm-sensors] Config file for Gigabyte GA-EX38-DS4
Message-Id: <20110503142407.13bce2f3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 19 Apr 2011 23:26:38 +0200, Marc Muehlfeld wrote:
> I created a sensors3.conf for my Gigabyte GA-EX38-DS4. Maybe someone with an 
> account can add this to the wiki.

I've added it:
http://www.lm-sensors.org/wiki/Configurations/Gigabyte/EX38-DS4
Thanks for your contribution.

> chip "it8718-*"
> 
>         # Voltages
>         label   in0 "CPU Vcore"
>         label   in1 "DDR"
> (...)
>         set in0_min  1.120 * 0.95
>         set in0_max  1.120 * 1.05

I'd be surprised if your CPU doesn't change its core voltage depending
on the frequency. Almost all modern x86 CPUs do this.

>         set in1_min  1.89  * 0.95
>         set in1_max  1.89  * 1.05

Overclocked RAM? DDR2 normally runs at 1.8 V.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
