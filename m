From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: use of I2C addresses
Message-Id: <20030719114549.0165ba96.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

I wrote a simple perl script for fun this morning, which may be of
interest for the rest of you, so I though I'd just share it with you.

The script scans sensors-detect and prints a map of scanned i2c
addresses, with a number that say how chips can use the address. Here is
a sample output for the CVS sensors-detect:

*** START ***

sensors-detect knows 53 chips and scans 49 addresses.

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- 01 -- -- -- --
10: -- -- -- -- -- -- -- -- 09 09 09 -- -- -- -- --
20: 12 12 12 12 12 12 12 12 12 21 21 21 28 29 26 17
30: -- -- -- -- -- -- -- -- 02 02 02 02 01 01 01 01
40: -- -- -- -- -- -- -- -- 03 03 03 03 13 12 12 03
50: 02 01 01 01 01 01 01 01 01 01 01 -- -- -- -- --
60: -- 01 -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- 02 -- -- -- --                        

*** END ***

I did this by curiousity mainly, but I think it may be interesting to
know how many other chips use our addresses, when we do add support for
a new chip. This may help us decide how precise the detection must be.

Should I add this script to our CVS repository? (where?)

Should we include the output of this script at the beginning of
sensors-detect?

One feature I could add is the possibility to ask *which* chips are know
to use a given address (or range of address). This would require some
more code but is probably not very complicated to do. This would let us
check all "concurrent" chips each time we add one, to make sure the
different detection routines are working well altogether.

(I may send the script to anyone interested.)

Comments welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
