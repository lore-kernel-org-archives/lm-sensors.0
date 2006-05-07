From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Sun, 07 May 2006 14:02:41 +0000
Subject: [lm-sensors] Fwd: Re: latest findings - my older posting from ~ 11
Message-Id: <200605071602.42069.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,
please find the results of the reprogramming attached to this mail. It seems 
as if the reprogramming worked, i. e. the output switched to 65:

80c0: 65 65 20 2c 2c 6c 6c 6c 65 65 44 65 28 4c 20 44

But see yourself, the file's attached.
Thanks for helping - the hammering on the device by the loop you supplied was 
very efficient ;-). The crash happened after about three hours or 20065 
cycles of permanent reading.

Take care


Dieter
----------  Weitergeleitete Nachricht  ----------

Subject: Re: [lm-sensors] latest findings - my older posting from ~ 11 days 
ago / Tyan Tiger MoBo 2460
Date: Freitag, 5. Mai 2006 23:33
From: Rudolf Marek <r.marek at sh.cvut.cz>
To: Dieter Jurzitza <dieter.jurzitza at t-online.de>
Cc: lm-sensors at lm-sensors.org

Thanks for the report.

80c0: 68 48 20 2c 2c 6c 6c 6c 65 65 44 65 28 4c 20 44
******

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
8000: 01 04 20 03 01 00 00 00 7a fc 93 00 00 00 00 00 
8010: 0c 00 00 00 00 00 c3 03 00 00 ff ff 00 00 f0 00 
8020: 00 00 00 00 e0 00 00 17 02 00 80 00 01 00 00 f0 
8030: 0a 00 00 00 00 00 00 00 38 80 02 00 00 00 00 00 
8040: 00 00 00 00 08 00 03 00 00 00 00 00 00 00 00 00 
8050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
8060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
8070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
8080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
8090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
80a0: 00 00 00 00 00 00 00 00 ff 86 04 00 00 00 00 00 
80b0: ff 0d 00 00 fa f2 00 00 00 00 00 00 00 00 00 00 
80c0: 65 65 20 2c 2c 6c 6c 6c 65 65 44 65 28 4c 20 44 
80d0: 65 20 40 40 03 af cd 0f 00 00 00 00 ff ff ff ff 
80e0: 00 00 22 00 5a 00 00 00 4e 00 55 00 ba 46 10 10 
80f0: 00 00 00 00 20 28 65 65 65 44 44 44 20 20 20 20 
