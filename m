From: TheOneAndOnlySM@hot.rr.com (Sandeep Mehta)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: pc87360 sensor-driver results
Message-Id: <4099A689.1040902@hot.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm_sensors cvs 05/05/04 @ 6:00 pm

Fan speeds are still problematic. I tried the isasets, but it didn't 
make any apparent difference.

the in8 and in9 dumps are attached

;after running
isaset -f 0xecc0 3
isaset -f 0xecc2 3
will I need to set it back to the default setting? How would I do so, or 
will it not make a difference in testing the fans?
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 06 00 00 00 00 00 1f 05 02 09 80 ff ff 00 00 00 
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 06 00 00 00 00 00 1f 05 02 09 81 ff ff 00 00 00 
