From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Mon, 08 May 2006 19:37:23 +0000
Subject: [lm-sensors] latest findings - my older posting from ~ 11 days
Message-Id: <200605082137.23105.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200605022128.10627.dieter.jurzitza@t-online.de>
In-Reply-To: <200605022128.10627.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Rudolf,
would have been a nice workaround - if it had had worked :-((( Unfortunately, 
the line 0x80c1 remains at "48" rather than going "68" when being 
reprogrammed.
Please take a look at the logfile I attached; it is the result of the commands 
below. Repetitive unloading and loading of all i2c-drivers does not cure the 
issue.

Thank you very much,
take care


Dieter Jurzitza

*********************************
> rmmod i2c-amd756
> isaset -y -f 0x80c0 0x5
> isaset -y -f 0x80c1 0x5
> isadump -y -f 0x8000
*********************************

-- 
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <??__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------
-------------- next part --------------
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
8000: 01 04 20 03 01 00 00 00 49 04 63 00 00 00 00 00 
8010: 0c 00 00 00 00 00 c3 03 00 00 ff ff 00 00 f0 00 
8020: 00 00 00 00 e0 00 00 17 02 00 80 00 01 00 00 f0 
8030: 0a 00 00 00 00 00 00 00 38 80 02 00 00 00 00 00 
8040: 00 00 00 00 08 00 03 00 00 00 00 00 00 00 00 00 
8050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
8060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
8070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
8080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
8090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
80a0: 00 00 00 00 00 00 00 00 ff 86 00 00 00 00 00 00 
80b0: ff 0d 00 00 fa f2 00 00 00 00 00 00 00 00 00 00 
80c0: 68 48 20 2c 2c 6c 6c 6c 65 65 44 65 28 4c 20 44 
80d0: 65 20 40 40 02 af cd 0f 00 00 00 00 ff ff ff ff 
80e0: 00 08 22 00 5a 00 00 00 4e 00 42 00 ff 00 10 10 
80f0: 00 00 00 00 20 28 65 65 65 44 44 44 20 20 20 20 
