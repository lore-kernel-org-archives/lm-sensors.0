From: rysanek@fccps.cz (rysanek@fccps.cz)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: SOLVED: an issue + a bug in eepromer/eeprom.c from lm_sensors.tgz
Message-Id: <Pine.LNX.4.33.0306020725580.26954-100000@usti.fccps.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0305221414100.23255-200000@usti.fccps.cz>
In-Reply-To: <Pine.LNX.4.33.0305221414100.23255-200000@usti.fccps.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> BTW my interpretation of the Atmel datasheet is that only writes are
> limited to 8 bytes; reads don't appear to have a limit (although the i2c
> layer has a 32 byte limit).
>
exactly, the datasheet does say that, and the original 16byte bursts did
work for reading.

F.Rysanek
