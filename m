From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: unknown chip
Message-Id: <20030807194331.5621dc58.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

Alex van Kaam (MBM) sent me a chip dump this morning:

  0000  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0010  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0020  FF FF FF FF FF FF FF FF 7F 0B FF FF 7F 06 FF FF
  0030  FF FF FF 00 00 00 00 00 00 00 00 00 00 00 5C 60
  0040  04 00 00 00 00 FF 00 FF 00 FF 00 FF 00 FF 81 7F
  0050  81 7F 81 7F FF FF FF FF FF FF FF FF 62 62 62 C3 
  0060  C3 C3 00 00 80 80 80 5A 5A 5A 64 64 64 44 40 00
  0070  FF FF FF 00 FF 00 FF 00 FF 00 11 00 E0 00 EC 10
  0080  5E A4 FF 62 03 80 FF FF FF 03 4D 4D 0E 0E 00 00
  0090  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00A0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00B0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00C0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00D0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00E0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00F0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

This is on a MSI MS-9126 at address 0x2c. We are trying to figure out
what kind of chip it can be. Any idea anyone? (I don't tell you what I
do think it is, so that it won't influence you in any way.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
