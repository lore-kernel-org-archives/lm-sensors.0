From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: SOLVED: an issue + a bug in eepromer/eeprom.c from lm_sensors.tgz
Message-Id: <3ECCCF09.3552BFBF@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0305221414100.23255-200000@usti.fccps.cz>
In-Reply-To: <Pine.LNX.4.33.0305221414100.23255-200000@usti.fccps.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In lm_sensors-2.7.0,
we've already made clear in the README files in prog/eepromer
that 'eeprom' is for small eeproms and 'eepromer' is for big eeproms.

rysanek@fccps.cz wrote:
> 
> Dear Chris,
> 
> many thanks for writing eeprom.c in the first place.
> It has saved me an indefinite amount of time when I needed
> to access a 24C02 in a cursed notebook battery pack that
> someone's trying to refurbish.
> 
> Many more thanks to the authors of lm_sensors and Linux i2c
> for writing their software, of course.
> 
> I did have to modify eepromer/eeprom.c a bit though, to support
> my 24C02. The essential gotcha was this: whereas the 24C16 that
> you were using supports maximum burst size of 16 bytes (the same
> applies to 24C08 and 24C04), the 24C02 and 24C01 only support
> bursts up to 8 bytes long.
> I assume that in fact you already know this, as in your code
> there's a neat #define called MAX_BYTES to hold exactly this
> burst length. And, this was the first thing I modified when
> I was trying to solve my problem.
> There's one more associated bug though, probably a result of
> the fact that your code was not tested with MAX_BYTES values
> other than 16. The two for(;;) cycles for reading/writing
> consecutive bursts have a wrong terminal condition: they're
> comparing the loop count against MAX_BYTES instead of
> (BYTES_PER_PAGE/MAX_BYTES).
> 
> With this e-mail, I am enclosing the corrected eeprom.c.
> 
> My symptoms looked like this: I read the eeprom just fine.
> I did my dirty work on two bytes in the eprom dump and
> flashed it back. When I re-read the eprom contents,
> I found garbage - or so it seemed.
> At a closer look, I found out that every second
> half-burst (the second 8 bytes of the 16) was correct and
> every first 8 bytes was garbled. (Compared that using two
> hex editors open on consoles 1 and 2.)
> After a few more  seconds I found out that the two half-bursts
> were really identical.
> My final explanation is that each 16byte write resulted in
> only the first half-burst being overwritten (the second was
> left untouched), only the eeprom latched in all 16 bytes
> obediently, so that its FIFO overflew and looped around
> exactly once, which resulted in the *second* half-burst
> being written into the *first* eight bytes...
> 
> Based largely on eeprom.c, I've already hacked a simple util
> to write only those two or four bytes that matter to me (the
> actual battery capacity and the write-protect stuff).
> 
> If the battery refurbishment works out, I'll update my website
> to report this success, including all my code snippets.
> Thanks again :)
> 
> Frank Rysanek
> 
>   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>                Name: eeprom.c
>    eeprom.c    Type: Plain Text (TEXT/PLAIN)
>            Encoding: BASE64
