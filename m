From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20031130162949.2c2e2e4e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Modified Files:
> 	sensors-detect 
> Log Message:
> (Khali) Get rid of DMI and ACPI detection methods. VPD should be
>         sufficent.

This is the last step to a definitive (hopefully) solution to the
Thinkpad problem.

What's missing now is the list of faulty Thinkpads (those with the
24RF08) to blacklist, or the list of non-faulty Thinkpads to white-list.
The problem is that I doubt we'll ever obtain such lists in an official
way. Even if we would, this still means we would have to maintain these
lists. Maintaining a blacklist in real-time is almost impossible without
an active support from IBM, which I guess we'll never get. Maintaining a
white-list is safer, but still requires that someone spends time to
track newly released Thinkpad models.

So I have been thinking of another way to handle the problem. Here we
go.

I assume the following is true:
1* We have a reliable way to detect IBM systems in sensors-detect (VPD).
2* Some of these systems have a dangerous 24RF08 chip on-board. Such
chips use a fixed range of addresses: 0x54-0x57.
3* These addresses are only used by two drivers in our package: eeprom
and ddcmon. These drivers now have a workaround that is supposed to
prevent the 24RF08 corruption. The sensors-detect script itself has such
a workaround
4* The i2c-piix4, which is the bus driver needed on all faulty systems
seen so far, won't load on IBM systems (using DMI, not VPD).
Let me know if I'm wrong somewhere.

3 and 4 together make it not even necessary to prevent IBM users to run
sensors-detect. Nothing bad should happen anymore. Even 4 is
somewhat redundant with 3 (and not very reliable still it could miss
some IBM systems). Still I understand that we want to play it safe. But
we don't have to bail out from sensors-detect if an IBM system is
detected. Instead, what about simply excluding 0x54-0x57 from the scan
range and/or exclude the eeprom and ddcmon drivers?

Since regular eeproms are rarely seen within 0x54-0x57 (except on Sony
laptops, but they are not IBM laptops, of course), excluding this range
from the scan is not really a problem. And excluding addresses from the
scan should be really easy.

Excluding drivers would probably be a bit more tricky, and I don't think
it's necessary. Exclusing addresses should be sufficent, and even safer.

I first feared that the ddcmon would cause trouble because it declares
0x51-0x57 as subaddresses, but reading the driver code, it seems that it
doesn't use them (and doesn't even "register" them).

One additional note. In sensors-detect we scan all addresses from 0x00
to 0x7F. I don't think it's correct. According to what I know, 0x00,
0x02-0x03, 0x0C and 0x7C-0x7F should not be scanned, being respectively
the general call address, a reserved range, the alert response address
and another reserved range. I propose to exclude these addresses from
the scan. Then, all we need to do is add four addresses to the exclusion
list if an IBM system is detected. This also opens a path for more
addresses exclusions if this is needed later.

Comments welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
