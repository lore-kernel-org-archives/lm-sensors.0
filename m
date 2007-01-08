From: neodym@ne2000.de (Tobias Zuegel)
Date: Mon, 08 Jan 2007 22:18:14 +0000
Subject: [lm-sensors] FoxOne another rebranded F71882FG?
Message-Id: <45A2C326.4040904@ne2000.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Just read here, that EPoX EP1308 and F71882FG are identical and that a 
driver is possible/in development.
I think, I have found another rebranded F71882FG: the FoxOne chip on my 
Foxconn P9657AA board. The chip seems to be used quite often on Foxconn 
boards (e.g. also on the 975X7AA).

Here the relevant output of sensors-detect:
 > Some Super I/O chips may also contain sensors. We have to write to
 > standard I/O ports to probe them. This is usually safe.
 > Do you want to scan for Super I/O sensors? (YES/no):
 > Probing for Super-I/O at 0x2e/0x2f
 > Trying family `ITE'...                                      Yes
 > Found unknown chip with ID 0x0541
 >     (logical device 4 has address 0x295, could be sensors)
 > Trying family `National Semiconductor'...                   No
 > Trying family `SMSC'...                                     No
 > Trying family `VIA/Winbond/Fintek'...                       Yes
 > Found `Fintek F71882FG Super IO Sensors'                    Success!
 >     (address 0x295, driver `to-be-written')
 > Probing for Super-I/O at 0x4e/0x4f
 > Trying family `ITE'...                                      No
 > Trying family `National Semiconductor'...                   No
 > Trying family `SMSC'...                                     No
 > Trying family `VIA/Winbond/Fintek'...                       No

I am looking forward to seeing it supported at some time. I will read 
the mailing list from now on and I am available as a tester ...

Greets,
Toby

