From: ianp <braveheart_leo@yahoo.com>
Date: Wed, 19 Feb 2014 18:20:16 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <1392834016.85222.YahooMailNeo@web160502.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> On Thursday, February 20, 2014 12:35 AM, Jean Delvare <jdelvare@suse.de> wrote:

>
>>  * It should be noted that it is recommended to have at least 3 voltage 
> samples to facilitate an accurate computation. More importantly, the samples 
> must be taken from the BIOS, whether seen from a screenshot or personally 
> observed, and not from some monitoring software.
> 
> Monitoring software provided by the vendor is good. What's not good is
> 3rd party software.
> 

I don't have much experience on using vendor-provided monitoring software, so I think that can be an exception.

>>  When I was computing for the +5V scale I had a hard time collecting samples 
> because the +5V monitor from the BIOS rarely fluctuated -- my PSU must be that 
> stable
> 
> Yeah, I had the same problem. Ironically, having a good, stable PSU
> makes the job harder. A crappy PSU oscillating between 5 different
> values in the BIOS would be much better ;-)
> 

Almost twenty minutes into just staring at the monitor, I thought about replacing the PSU with a generic unit that I have lying around here just to get it moving. But then I had an idea that maybe I could introduce a tiny ripple if I open and close my optical drive's tray. And that did the trick and gave me a quick 5.040 reading. :-)

> 
> Thanks for your suggestions, I have updated my guide to clarify the
> points you mentioned, hopefully it's better now.
> 

Yes it is. It bridges the gap I encountered while following the guide, i.e. what recommended voltage to use when validating the scaling factor.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
