From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: bug : mkdev.sh creates devices that sensors-detect cannot use
Message-Id: <200407091101.i69B1fXA063226@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040708184144.4554439e@pegasus.ucs.co.za>
In-Reply-To: <20040708184144.4554439e@pegasus.ucs.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> First of all, which version of lm_sensors are you using?
>
>As above, version 2.8.7 . I downloaded it yesterday using :

Ooops, sorry. I missed the information at first, my bad.

>> If you are using the latest version if sensors-detect AND you use
>> devfs AND you have i2c-dev loaded AND sensors-detect still complains,
>> then this is likely to be a problem with your bus driver (i2c-viapro).
>
>When I insmod i2c-viapro, devfs doesn't create any new devices. However,
>after reading your response this morning, I removed all the i2c devices
>I created, rmmodded all i2c modules except i2c-core and i2c-dev and
>reran sensors-detect. The same message appeared:
>
>Can't open /dev/i2c/0
>
>but I continued with the config process, ran sensors and voila! works
>perfectly.

Hmm, strange. I guess that your hardware monitoring chipset is located on
the ISA bus (thus using i2c-isa instead of i2c-viapro)?

I don't use devfs myself, but I think that it is OK not to have
/dev/i2c/0 with only i2c-dev loaded. Device files should be created as
you load bus driver modules. Could someone with devfs confirm this?

I don't think you told us which (exact) kernel version you were using,
did you?

>Now that I have it working, lm_sensors will be installed on all of a
>client's servers (+- 200) and will be used to provide valuable, hitherto
>inaccessible information about the state of their cpus and fans. If this
>is successful, as I'm sure it will be, it is intended to roll out
>lm_sensors to some of our other clients too.

Do all of these servers have similar hardware? Remember that your
experience with lm_sensors depends much on the exact hardware
configuration.

>Please accept an apology for my hasty assumption and thanks for a
>great and essential tool!

I don't see much you should apologize about. Although it didn't seem to
prevent you from using lm_sensors, there still is something bad with
your hardware/devfs/lm_sensors/kernel combination and we better find out
what it is. I admit I don't have many ideas at the moment, mainly
because I don't use devfs myself so there is no chance I could
reproduce the problem.

At least, one thing we could do: detect devfs at the beginning of
mkdev.sh, and bail out with a message instead of silently creating
useless device files?

Thanks,
Jean Delvare
