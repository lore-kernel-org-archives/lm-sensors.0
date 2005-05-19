From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Vaio eeprom security issue
Message-Id: <20030806233617.5a83d0b6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

As some of you may know, I have been working on an EEPROM that is found
in Sony Vaio laptops for quite some time now. I recently found that the
BIOS password, when set, is stored in that EEPROM in a very lightly
coded way (took me less than a minute to find the encoding/decoding
method). Since the eeprom module will export the data to userspace, it
looks like we could have a security issue.

The good thing is that I was precisely using that field as a way to
detect the EEPROM, so once a password is set, sensors-detect won't
detect it anymore (and thus give it a confidence 1 only). Sensors will
not recognize the EEPROM either.

The bad thing is that the data is still exported to userspace. What's
more, this field is also where the regular SPD main data are (the memory
type and size). Fortunately, the values should be different enough so
that no password could make sensors think this is a SPD EEPROM. Still,
some password could make the SPD checksum succeed (while it usually
fails on Sony Vaio EEPROMs) and confuse sensors-detect.

So, here is the proposed plan:

1* Fix sensors-detect so that it will identify the two different kind of
eeproms correctly. I think we could have two distinct entries in our
chips list (say "SPD EEPROM" and "Sony Vaio EEPROM"), even if both are
EEPROMs, using the same driver and prefix.

2* Check that detection procedures in the eeprom driver are correct.
IIRC, there is almost no check unless checksum=1, maybe some checks
should be added.

3* Define a security policy for that password issue. I think we simply
should disable the Vaio EEPROM in the eeprom module if we find there is
a password set. It could be forced using the force_eeprom module
parameter (or should we define another module parameter?) Another
possibility is to hide that particular field instead, but I'm not sure
it's worth the work.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
