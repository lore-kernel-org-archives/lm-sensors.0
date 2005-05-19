From: rysanek@fccps.cz (rysanek@fccps.cz)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: SOLVED: an issue + a bug in eepromer/eeprom.c from lm_sensors.tgz
Message-Id: <Pine.LNX.4.33.0305221553160.23255-100000@usti.fccps.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0305221414100.23255-200000@usti.fccps.cz>
In-Reply-To: <Pine.LNX.4.33.0305221414100.23255-200000@usti.fccps.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 22 May 2003, Mark Studebaker wrote:
>
> In lm_sensors-2.7.0,
> we've already made clear in the README files in prog/eepromer
> that 'eeprom' is for small eeproms and 'eepromer' is for big eeproms.
>
no doubt you have, and indeed that information was very important to me.

However, in the "eeprom.c vs. eepromer.c" case, the border line is
between 24C01-to-24C16 (eeprom) vs. 24C32-and-above (eepromer).
To quote README.eepromer:

#> The EEPROM must be a large EEPROM which uses a 2-byte address
#> field (24C32 or larger). It will NOT WORK on small EEPROMs
#> (24C01 - 24C16) such as those used on SDRAM DIMMs.

Whereas the 8byte vs. 16byte burst size is yet another border line within
the "eeprom.c" camp: 24C01-&-24C02 (8 bytes) vs. 24C04-to-24C16 (16
bytes).

> > I did have to modify eepromer/eeprom.c a bit though, to support
> > my 24C02. The essential gotcha was this: whereas the 24C16 that
> > you were using supports maximum burst size of 16 bytes (the same
> > applies to 24C08 and 24C04), the 24C02 and 24C01 only support
> > bursts up to 8 bytes long.

Oh, sorry about including the eepromer/ directory in the file
reference - I meant to distinguish the prog/eepromer/eeprom.c file
from the eeprom/* directory, that contains stuff for decoding the DIMMs.

As for 8 vs. 16 bytes, no doubt there are several ways to address this
feature of the "eeprom.c" style devices. Put a comment into the
documentation, use yet another getopt option in eeprom.c, or just set the
burst size to 8 bytes as a rule, which is supported by all the
"eeprom.c" chips (24C01 to 24C16) - IMO the little bit of additional
bus bandwidth overhead doesn't really matter.

Thanks again for the time you spend doing this great job.

Frank Rysanek



