From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20031115104547.50399d8d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> never mind.
> I think, on the iopener, when sensors-detect gave the IBM warning,
> I was running as non-root.
> It doesn't give the warning when run as root.
> Sorry for the false alarm.

I prefer it that way, since I had some difficulties imagining what would
have cause such a failure in the detection code.

> But anyway, would it be helpful to put out a message in sensors-detect
> when it can't determine the system type, even as root?

Auxiliary question, should we even accept running as non-root? We can't
detect an IBM system if we are not root, still the user can scan any
already-loaded bus driver, providing i2c-dev is loaded too. Isn't it
dangerous? OTOH i2c-dev shouldn't be loaded on such a system, and
i2c-piix4 shouldn't possibly load anyway.

(BTW, should I replace DMI with VPD in i2c-piix4/dmi_scan? Or is it
considered a feature to use different protection systems? Not all
Thinkpads have a DMI table. OTOH, DMI scan is already handled by the
kernel so idealy we could get rid of dmi_scan, as it was done in
Linux 2.6. And after all, the eeprom module is supposed to be safe WRT
faulty eeproms now, so dmi/vpd detection at this level is not really
required anymore, right?)

To answer your question, failing to detect the system type now (with
VPD) can only occur if we can't read /dev/mem (because we are not root,
or because a read error occured, which could happen on some non-i386
architectures). Since all Thinkpads are i386 systems AFAIK, the second
case isn't really a problem.

And we already output a message if the system type couldn't be detected.
I'll just leave it in place.

> And yes, on the 2 "typical" machines, it doesn't mention VPD.

Which basically means "the system is safe", left apart the two cases
mentioned above.

> nice job on the dmidecode package and website BTW.

Thanks :) Do you really like the website. I'm not sure how to organize
it. For now, there's a single page with anything on it. I wonder if I
should split it into many pages, but actually there isn't that much to
write about it, so my conclusion so far was that it wasn't necessary.

As for the design, see how clean and easy it is to use CSS and XHTML to
get an easy-to-maintain site. Admittedly, I kept the look very simple,
half because I like simple and fast-loading pages as a user, half
because I am not particularily talented when it comes to complex design.

I'd love to see the lm_sensors website with a single CSS and clean HTML
pages too, unfortunately I don't really have the time to work on this -
and after all the current website does its job rather well, methinks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
