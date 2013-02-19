From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Feb 2013 12:53:32 +0000
Subject: Re: [lm-sensors] Asus P8P67 Pro configuration (for wiki)
Message-Id: <20130219135332.6df9912f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1268999849.63442.1360921639457.JavaMail.mail@webmail07>
In-Reply-To: <1268999849.63442.1360921639457.JavaMail.mail@webmail07>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Artem,

On Fri, 15 Feb 2013 09:47:19 +0000 (UTC), Artem S. Tashkinov wrote:
> Hi,
> 
> Here's my Asus P8P67 Pro lm-sensors configuration (I couldn't create a wiki page):

I've created it for you:
http://www.lm-sensors.org/wiki/Configurations/Asus/P8P67%20Pro

> chip "nct6776-*"
>     label temp1 "MB"
>     set temp1_max 50
>     set temp1_max_hyst 40
> 
>     ignore temp2
> 
>     label temp3 "CPU"
> 
>     label in0 "Vcore"
>     set in0_min 0.75
>     set in0_max 1.35
> 
>     label in2 "AVCC"
>     set in2_min  3.3 * 0.95
>     set in2_max  3.3 * 1.1
> 
>     label in3 "+3.3V"
>     set in3_min  3.3 * 0.95
>     set in3_max  3.3 * 1.1
> 
>     label in7 "3VSB"
>     set in7_min  3.3 * 0.95
>     set in7_max  3.3 * 1.1

This looks incomplete: no +5V, no +12V and no fans? The BIOS shows them
so they must be present. If you need help to find the mapping and
scaling for +5V and +12V, please read this article:
http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling

Also the voltage limits are odd, there's little rationale for allowing
-5% but up to +10%. The ATX specification says +/- 5% for positive
voltage values.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
