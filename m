From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: [Fwd: Broken link on web page] VIA datasheets
Message-Id: <3E2C949B.1060309@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E248908.80200@netroedge.com>
In-Reply-To: <3E248908.80200@netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
>>go for it
> 
> 
> I am in the process of updating useful_addresses.html, and am using
> http://secure.netroedge.com/~lm78/supported.html
> as a reference.
> 
> This page mentions a MAX1676A chipset, which we are pretending to
> support. Unfortunately, there's no trace of this chipset's in our source
> code nor on Maxim IC's website. So, I would tend to think that this is a
> typo and that it should be MAX1617A instead. Am I right?
> 

right. I just fixed supported.html in CVS.


> Also, I couldn't find any DS1625 chipset on Dallas Semiconductor website
> (which is the same as Maxim IC's one, I guess they have joined somehow).
> But this time, there is a lot of references to it in our source code.
> Who's wrong? Any clue welcome.
> 

Maxim bought Dallas a year or two ago.
They are now "maxim/dallas".
I have a 1625 datasheet, it is labeled 'not for new design',
I'm pretty sure the 1621 is the replacement.

> Updating useful_addresses.html is a long and slow process, so please be
> patient.
> 

thanks for tackling this.
You can of course check in updates as you go if you like.
Given that suppliers update their web pages frequently
it may make sense just to link to their home page rather
than try to reference a datasheet page in particular.
Especially since many have a form on the home page you can
type a part number into to get info.
