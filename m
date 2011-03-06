From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 06 Mar 2011 17:07:42 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan RPM
Message-Id: <20110306170742.GA10411@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ian,

On Sun, Mar 06, 2011 at 07:38:24AM -0500, Ian Dobson wrote:
> Hello All,
> 
> Firstly I'd like to thank Guenter for all his work adding support for the 
> nct6776f superIO chip.
> 
> During my testing of the driver on a Asus p8p67 pro motherboard and a Arctic 
> cooling fan I've come across a small problem that the RPM reading is 
> sometimes incorrect, usually the incorrect reading is almost double the 
> expected value and is only incorrect for 2 seconds (Next actual read from 
> the chip). Looking at the tacho signal from the fan with an oscilloscope  I 
> can see short pulses/dropouts which cause the incorrect reading. Looking 
> through the data sheet I see that the nct6776f and nct6775f both support 
> de-bouncing the fan rpm signal (logical device b address 0xf0 bit 1-5 for 
> nct6776f or 1-4 for nct6775f). After enabling the rpm de-bounce for the CPU 
> fan I've not seen any more miss readings. I tested for 24hours and usually I 
> see a incorrect reading within 10-30 minutes.
> 
> The first question is, should we offer the possibility to enable rpm 
> de-bounce for chips that support it? If yes then what interface should we 
> use? I can see 3 possibilities:-
> 1) Through sysfs fanX_debounce (0/1). I already have a patch for this and 
> the diff is about 60 lines of code
> 2) Through a module parameter (fan_debounce=X) where X could be 0/1 for 
> disable/enable for all fans or a decimal value which is the bit pattern for 
> the de-bounce to enable.
> 3) Always enable the fan de-bounce if the chip supports it.
> 
> Note enabling de-bounce does not appear to have any negative effects.
> 
Thanks a lot for the feedback and testing.

Since there will always be just one of those devices in a system, option 2) or 3)
seem to be better choices; I like to avoid adding new attributes if there is another
option and if the attribute would only be used by a single driver.

We could implement 3) for simplicity, but question is if this might have any
undesired side effects on other boards. So 2) might be the safer approach.

Thoughts, anyone ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
