From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 28 May 2006 19:24:30 +0000
Subject: [lm-sensors] PATCH: libsensors and sensors prog support for
Message-Id: <4479F8EE.70707@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4470B176.5000703@hhs.nl>
In-Reply-To: <4470B176.5000703@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
>> And the nescesarry userspace support.
>> (...)
>> I did this patch against 2.10.0 not CVS, sorry no time to redo it right
>> now. I hope this is atleast good enough for a review and if the merging
>> then gives troubles I rebase against CVS.
> 
> Here comes the review:
> 

Thanks! I'll create a new version of the patch this will probably take a
couple of days though (the weekend is over).

> 
> Please only include one config example in the default configuration
> file. We just can't include one configuration section for each
> motherboard. You can make the other configuration files available (or
> maybe post them to this list if you have nowhere to store them
> publicly.)
> 

Hmm,

I guess this is non negotiable? Wouldn't it be an idea to have a doc
(sub)dir with known working motherboard sensors.conf parts?

As you know I'm currently "working" on an lm_sensors autoconf project,
part of which will be a database with working/good sensors.conf entries
matched to motherboards. As I already mailed I got 4 applications todo
this google soc project. Most applicants listed as motivation (amongst
other things) the fact that they had configured lm_sensors in the past
and that it was a pain to configure. This is precisely the reason why
I've included configs for all known motherboards using the uguru in
sensors.conf.eg, so that end users which a known motherboard can set it
up in a breeze (compared to not having this info).

Anyways unless this turns out to be negotiable I'll create a webpage
with the configuration info per motherboard and put a link to this page
in sensors.conf.eg . I assume that is acceptable?

As for your other feedback, I'll fix/make things as requested.


Regards,

Hans

p.s.

What do you think about the lm "autoconf" google soc project? I've n't
seen any responses about this sofar. The student who is doing it is
working in it, but he doesn't have a proposal ready for public
discussion yet.

