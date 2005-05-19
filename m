From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: EEPROM read/write user space program
Message-Id: <20031122084059.0f9f73fa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Stefano,

Please contact the mailing-list for general discussion, instead of me
directly

> I'm writing you because I wrote a Linux program to read and write
> 24Cxx EEPROMs through the SMBus interface and want to share it with
> the community (it's free of course).
> 
> I wrote it because the 'eeprom' and 'eepromer' programs require a I2C
> capable chipset (or, at least, this is what I think is the problem :)
> and mine does not seem capable of I2C_RW (I'm using the viapro
> driver).

I don't get it. We have prog/eepromer/eepromer.c that is supposed to to
the very same. In which way is your program different?

I don't know what you mean with "I2C_RW", but all the bus drivers we
have support sending data to the chips.

> I think (and hope:) that eeprog (oh, it's called eeprog) url could be
> included into a README in the eeprom dir or somewhere in lm-sensors
> package so the next more-lucky-then-me can find it if needed.
> 
> info link:
> 	http://codesink.org/eeprog.html
> 
> download:
> 	http://codesink.org/download/eeprog-0.7.3.tar.gz

If your program brings something really new, we will, but for now it
seems to be just a duplicate of eepromer. It would be preferable to
merge our efforts, isn't it? Please explain why eepromer did not work
for you, and/or what eeprog does better.

Mark D. Studebaker and some other persons on the list are much more
knowledged about writing to eeproms than I am, and might be able to
discuss it with you.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
