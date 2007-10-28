From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Oct 2007 14:44:15 +0000
Subject: Re: [lm-sensors] lm_sensors on ASUS M2NPV-VM motherboard using
Message-Id: <20071028154415.79e5acab@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46ED7EFC.4030609@Winfirst.Com>
In-Reply-To: <46ED7EFC.4030609@Winfirst.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Fri, 19 Oct 2007 12:40:52 -0700, Mark E. Hansen wrote:
> I posted this question on Sept 16th, but didn't get any responses. The point
> I don't understand about creating a 'sensors.conf' from scratch is how to
> come up with the various multiplier/division factors that are needed to
> get accurate voltages.

There are several ways, none of which is perfect:
* Ask your motherboard vendor or manufacturer about the factors.
  Most of the time they will simply ignore you.
* Look at the voltage values displayed by your BIOS, and use factors
  such that "sensors" will display the same values. Ordering is usually
  the same as well.
* Look at the voltage values displayed by a Windows tool, and use
  factors such that "sensors" will display the same values.
* Find working configuration files for boards similar to yours, they
  might hold valuable hints.

This is tricky either way. It took me two years to be able to write
custom configuration files with good results, so I don't really expect
users to get it right at their first try.

> Can someone please have a look at this and let me know if I'm just missing
> something?
> 
> Thanks
> 
> ----- original messages posted on 16 September 2007:
> 
> I'm running CentOS Linux 4.5 on a desktop machine using the
> ASUS M2NPV-VM motherboard and an AMD A64 X2 3800 (65watt) CPU.
> The chipset is Northbridge NVIDIA GeForce 6150 GPU, Southbridge
> NVIDIA nForce 430 MCP.
> 
> I'm running lm_sensors 2.8.7 (which is current for CentOS 4.5)

This is 3 years old, which probably explains why you did not get any
answer.

>  From reading various archives of problems other people have had,
> it seems those with the same board have the IT8716F chip, but
> when I run sensors detect, it shows that I'm running the IT8705F/
> IT8712F/SiS 950, which should be supported.

Your board really has an IT8716F, not one of the older variants. The
IT8716F is somewhat compatible, but not completely. One significant
difference is that the IT8716F supports two additional fans.

> When I use the sensors.conf that comes with the package, it seems
> to not be showing the correct sensor data, as though it thought
> it was a different chip.
> 
> Is sensors-detect wrong in saying that I'm running the IT8705F,
> and that I'm really running the IT8716F?

Certainly. That's not very surprising if you ran a 3-year-old version
of sensors-detect to identify a device that did not even exist 3 years
ago. Just run a more recent version of sensors-detect and it'll tell
you the truth:
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt

> 
> Here is the summary output from sensors-detect:
> 
> ==================================
>   Now follows a summary of the probes I have just done.
>   Just press ENTER to continue:
> 
> Driver `it87' (should be inserted):
>    Detects correctly:
>    * ISA bus address 0x0290 (Busdriver `i2c-isa')
>      Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)
> ==================================
> (...)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
