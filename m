From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Gigabyte GA-7VRXP rev 2.0
Message-Id: <20030707075228.33ba0585.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Alex,

On this page:
  http://mbm.livewiredev.com/comp/gigabyte.html
You say that the Gigabyte GA-7VRXP rev 2.0 has an LM83 on it. After a
user tried our LM Sensors package on such a motherboard and couldn't get
it to work properly, I asked him for an I2C dump of the chip that was
supposed to be an LM83 and it turned out to actually be an LM90
(manufacturer ID 0x01 at 0xFE, device ID 0x21 at 0xFF).

I just wanted to let you know, so that you can check it and correct the
information on this page. Let us know if you have additional info about
this board.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
