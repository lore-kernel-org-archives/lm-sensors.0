From: michaelnel@comcast.net (Michael Nelson)
Date: Sat, 23 Dec 2006 23:40:12 +0000
Subject: [lm-sensors] Andigilog aSC7621 & Intel D975XBX2 Motherboard
Message-Id: <20061223234012.GA5410@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi...

I've managed to do it again... bought another motherboard that seems to
have hardware monitoring stuff on it that is not yet supported by
lm-sensors.

The board I have is an Intel D975XBX2KR.  Nice board, but I can't find
anywhere in the documentation on the Intel site or that came with the
board what kind of hw monitoring chip it has.  The monitoring does work
(I can see it in the BIOS setup screens), but running sensors-detect
from lm-sensors 2.10.1 just recommends loading eeprom and i2c-i801.
Naturally, sensors doesn't work.

I grabbed the nightly lm-sensors-r4270-20061223.tar.bz2 and it will
compile "make user" and run sensors-detect.

It says: 

	Probing for `Andigilog aSC7621'...  Success!
          (confidence 5, driver `to-be-written')

So... is someone working on a driver for this chip, or is it a
mis-detection, or?

Thanks
Michael

-- 
If a kid asks where rain comes from, I think a cute thing to tell him is
"God is crying." And if he asks why God is crying, another cute thing to
tell him is "Probably because of something you did."

San Francisco, CA

