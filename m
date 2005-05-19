From: jon@resfeber.se (Jon)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: Ticket # 986 (problems with loading i2c-amd756)
Message-Id: <20020829104620.48164567.jon@resfeber.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

You wrote:
--------------------------------------------
did you do a make install?
Your module is version 2.5.5 but your sensors-detect is version 2.6.4.
Get rid of old modules, install new ones, you will be fine.
---------------------------------------------

I've don a make install in i2c-2.6.4 but it doesn't include an amd module, here's from todays make install:
 ls -l /lib/modules/2.4.7-10custom/kernel/drivers/i2c/
total 204
-rw-r--r--    1 root     root        13476 Aug 29 10:33 i2c-algo-bit.o
-rw-r--r--    1 root     root         9740 Aug 29 10:33 i2c-algo-pcf.o
-rw-r--r--    1 root     root         7896 Feb  5  2002 i2c-ali15x3.o
-rw-r--r--    1 root     root         6508 Feb  5  2002 i2c-amd756.o
-rw-r--r--    1 root     root        27784 Aug 29 10:33 i2c-core.o
-rw-r--r--    1 root     root         7884 Aug 29 10:33 i2c-dev.o
-rw-r--r--    1 root     root         6032 Aug 29 10:33 i2c-elektor.o
-rw-r--r--    1 root     root         4320 Aug 29 10:33 i2c-elv.o
-rw-r--r--    1 root     root         3716 Feb  5  2002 i2c-hydra.o
-rw-r--r--    1 root     root         9260 Feb  5  2002 i2c-i801.o
-rw-r--r--    1 root     root         5620 Feb  5  2002 i2c-i810.o
-rw-r--r--    1 root     root         3084 Feb  5  2002 i2c-isa.o
-rw-r--r--    1 root     root         6724 Aug 29 10:33 i2c-pcf-epp.o
-rw-r--r--    1 root     root         5244 Aug 29 10:33 i2c-philips-par.o
-rw-r--r--    1 root     root         8224 Feb  5  2002 i2c-piix4.o
-rw-r--r--    1 root     root         4304 Aug 29 10:33 i2c-pport.o
-rw-r--r--    1 root     root        10600 Aug 29 10:33 i2c-proc.o
-rw-r--r--    1 root     root         4096 Aug 29 10:33 i2c-velleman.o
-rw-r--r--    1 root     root         4444 Feb  5  2002 i2c-via.o
-rw-r--r--    1 root     root         8256 Feb  5  2002 i2c-viapro.o
-rw-r--r--    1 root     root         5940 Feb  5  2002 i2c-voodoo3.o

Actually i can't find anything with amd ("find . -name '*amd*'") in the i2c-2.6.4 dir returns nothing. Do I have to download something else? The package I have is from your download section.

/Jon
