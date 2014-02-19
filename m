From: ianp <braveheart_leo@yahoo.com>
Date: Wed, 19 Feb 2014 15:05:36 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <1392822336.25241.YahooMailNeo@web160501.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Wednesday, February 19, 2014 10:14 PM, Jean Delvare <jdelvare@suse.de> wrote:

>
> I'd even say that 5.064 / (24/8) = 1.688 is close enough to your in5 ;-)
> 

Now 5.064 is the perfect choice. ;-) 

> 
> Yes, I completely agree with your computations. Great job! Glad to see
> my guide working in practice :-)
> 

Indeed. Many thanks for your well-written guide.

If I may make some suggestions to further improve the guide:

* It wasn't obvious nor clear, at least to me, that one needs to arbitrarily choose, by means of trial-and-error, from the set of voltage samples the value that will produce the closest, if not exact, match to one of the unscaled sensor inputs when validating the scaling factor.

If you could specify that then I think it would really be a big help. When I first tried following your guide I didn't know this so that I was skeptical of the results I was getting and couldn't make a definitive map to one of the unscaled sensor inputs.

* It should be noted that it is recommended to have at least 3 voltage samples to facilitate an accurate computation. More importantly, the samples must be taken from the BIOS, whether seen from a screenshot or personally observed, and not from some monitoring software.

When I was computing for the +5V scale I had a hard time collecting samples because the +5V monitor from the BIOS rarely fluctuated -- my PSU must be that stable -- so that I only got values that I had observed and the other from the screenshot in the manual. I found it difficult scouring the web for BIOS voltage screenshots with the exact motherboad model as mine. With just two samples, it was hard to infer on the number of possible scaling factor steps.

I tried using the value I got from hwmonitor in Windows, but the results didn't make any sense when computed together with the other two values from the BIOS.

---------

All in all, this has been a very educating experience, and I really appreciate the inputs and patience that you and Guenter Roeck have given me.

Moreover, I have gained an appreciation of the sensors in my system that I was quick to disregard as being inaccurate, and it looks as though there's a problem with hwmonitor because I have now corroborated in Linux, via lm-sensors, values that I am seeing in the BIOS.

I will post my configuration file in a short while, and I hope you or some one could add it to the wiki.

Many thanks once again,

Ian Pangilinan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
