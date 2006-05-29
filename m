From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 29 May 2006 09:30:10 +0000
Subject: [lm-sensors] PATCH: libsensors and sensors prog support for
Message-Id: <20060529113010.26023d4d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4470B176.5000703@hhs.nl>
In-Reply-To: <4470B176.5000703@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> > Please only include one config example in the default configuration
> > file. We just can't include one configuration section for each
> > motherboard. You can make the other configuration files available (or
> > maybe post them to this list if you have nowhere to store them
> > publicly.)
> 
> Hmm,
> 
> I guess this is non negotiable? Wouldn't it be an idea to have a doc
> (sub)dir with known working motherboard sensors.conf parts?

Your guess is right, this is non negotiable ;)

We can't afford to maintain a collection of configuration files. CVS
isn't the right place for that, as we simply don't have the manpower to
handle it.

> As you know I'm currently "working" on an lm_sensors autoconf project,
> part of which will be a database with working/good sensors.conf entries
> matched to motherboards. As I already mailed I got 4 applications todo
> this google soc project. Most applicants listed as motivation (amongst
> other things) the fact that they had configured lm_sensors in the past
> and that it was a pain to configure. This is precisely the reason why
> I've included configs for all known motherboards using the uguru in
> sensors.conf.eg, so that end users which a known motherboard can set it
> up in a breeze (compared to not having this info).
> 
> Anyways unless this turns out to be negotiable I'll create a webpage
> with the configuration info per motherboard and put a link to this page
> in sensors.conf.eg . I assume that is acceptable?

Yes, this sounds like the right thing to do. We can also list your site
in the "Motherboard configuration files" section of our useful
addresses page:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/useful_addresses.html#sensorsconfdb

> As for your other feedback, I'll fix/make things as requested.

Thanks,
-- 
Jean Delvare

