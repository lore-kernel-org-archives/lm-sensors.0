From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 19 Feb 2014 16:35:59 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <20140219173559.6cb918e3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Wed, 19 Feb 2014 07:05:36 -0800 (PST), ianp wrote:
> Indeed. Many thanks for your well-written guide.
> 
> If I may make some suggestions to further improve the guide:
> 
> * It wasn't obvious nor clear, at least to me, that one needs to arbitrarily choose, by means of trial-and-error, from the set of voltage samples the value that will produce the closest, if not exact, match to one of the unscaled sensor inputs when validating the scaling factor.

Indeed. In my example the BIOS displayed only one value so the problem
did not exist. And you are right, the values do not have to match
exactly as "sensors" may be displaying the value for a slightly
different register value than the BIOS was.

> If you could specify that then I think it would really be a big help. When I first tried following your guide I didn't know this so that I was skeptical of the results I was getting and couldn't make a definitive map to one of the unscaled sensor inputs.
> 
> * It should be noted that it is recommended to have at least 3 voltage samples to facilitate an accurate computation. More importantly, the samples must be taken from the BIOS, whether seen from a screenshot or personally observed, and not from some monitoring software.

Monitoring software provided by the vendor is good. What's not good is
3rd party software.

> When I was computing for the +5V scale I had a hard time collecting samples because the +5V monitor from the BIOS rarely fluctuated -- my PSU must be that stable

Yeah, I had the same problem. Ironically, having a good, stable PSU
makes the job harder. A crappy PSU oscillating between 5 different
values in the BIOS would be much better ;-)

> -- so that I only got values that I had observed and the other from the screenshot in the manual. I found it difficult scouring the web for BIOS voltage screenshots with the exact motherboad model as mine. With just two samples, it was hard to infer on the number of possible scaling factor steps.

Well it really depends on the motherboard brand and model. In my
example it was relatively easy, while I admit I had a hard time finding
screenshots for yours (for only one and then realized it wasn't even
exactly the same as yours.)

> 
> I tried using the value I got from hwmonitor in Windows, but the results didn't make any sense when computed together with the other two values from the BIOS.

Thanks for your suggestions, I have updated my guide to clarify the
points you mentioned, hopefully it's better now.

> ---------
> 
> All in all, this has been a very educating experience, and I really appreciate the inputs and patience that you and Guenter Roeck have given me.

You're welcome :-)

> 
> Moreover, I have gained an appreciation of the sensors in my system that I was quick to disregard as being inaccurate, and it looks as though there's a problem with hwmonitor because I have now corroborated in Linux, via lm-sensors, values that I am seeing in the BIOS.
> 
> I will post my configuration file in a short while, and I hope you or some one could add it to the wiki.

I will do.

-- 
Jean Delvare
Suse L3 Support
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
