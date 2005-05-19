From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: [RFC 2.6] sensor chips sysfs interface change (long)
Message-Id: <1077205138.4034d8928851e@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218220845.361341c9.khali@linux-fr.org>
In-Reply-To: <20040218220845.361341c9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to "Mark M. Hoffman" <mhoffman@lightlink.com>:

> (trimmed distribution since I don't have much to add...)

Well, since you seem to agree with my proposal, you could distribute to
everyone ;)) More seriously, since the LKML was the primary target,
CC'ing them would have make sense IMHO. Anyway...

> > I plan to make rather important changes to the sysfs interface of
> > I2C
> 
> Gkrellm might be annoyed, but I better let them speak for
> themselves.

Sure they will blame me and curse me with some voodoo spell, at their
first reaction at least. Probably as much as I blame them for not using
libsensors. But in the end, I guess they will enjoy the change since it
precisely should help them be able to leave without libsensors and
still display correct values to their users (providing the are able to
parse /etc/sensors.conf by themselves, or have their own, similar
configuration file.


> This proposal looks good to me.  Have you already started the
> patches?

Yes. Greg wants it to be done as soon as possible in the 2.6.4 kernel
life cycle.

> Are there any you would like me to do?

There isn't much to do. Each driver (but eeprom) has to be converted.
This is a repetitive but easy job. Then some changes to the library and
doc, and we're done. I think I can handle that.

Where I will appreciate your help (and other's...) is for patches review
and testing. I will be able to test 2 drivers only, ideally we would
want to test them all.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
