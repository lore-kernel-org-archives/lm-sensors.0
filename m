From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: Cannot have lm-sensors work with my NV7m ABIT motherboard
Message-Id: <20030325093636.0d5df760.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048326224.4015.63.camel@Ordiyann>
In-Reply-To: <1048326224.4015.63.camel@Ordiyann>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Mark, I call upon you. Come to our help! :))

> I removed all the modules I don't need for lm-sensors, actually, all
> the modules that may access the i2c bus.
> (...)
> The big problem, is that, although I have removed all the modules from
> /lib/modules/[name of my kernel]/kernel/[whatsoever] and put them in
> another directory so that they can't be found by the system (I had
> begun with renaming them, but the system could always find them, so I
> renamed the directories in which they were, but it was the same...), I
> still get this when doing sensors-detect:
> (...)
> Client found at address 0x00
> Client found at address 0x01
> Client found at address 0x02
> Client found at address 0x03
> Client found at address 0x04
> Client found at address 0x05
> Client found at address 0x06
> Client found at address 0x07
> Client found at address 0x08
> Client found at address 0x09
> Client found at address 0x0a
> Client found at address 0x0b
> Probing for `Smart Battery'... Failed!
> Client found at address 0x0c
> Client found at address 0x0d
> (...)
> So? Do you have any idea, or did I put my finger on something
> completly crazy???

Well, sort of. Since it seems we can't blame any other driver, must be
our fault. I don't know what to do next, except wait for Mark to have
some time for us.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
