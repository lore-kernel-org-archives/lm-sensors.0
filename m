From: ralf.roesch@rw-gmbh.de (=?iso-8859-1?Q?Ralf_R=F6sch?=)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: New max6626.c driver for linux 2.6
Message-Id: <NHBBLBCCGMJFJIKAMKLHMEHECCAA.ralf.roesch@rw-gmbh.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi at all,

i would like to provide a new chip driver for the max6626 temp. sensor.
Could you please review and check in?

The provided patch is against linux-mips 2.6.10-rc2.

Is there any chance that this driver will be adopted from the official
kernel tree?

Thanks and regards
Ralf R?sch


Roesch & Walter___________________________________________
Industrie-Elektronik GmbH * Tel.: +49-7824 / 6628-0
Im Heidenwinkel 5         * Fax:  +49-7824 / 6628-29
D-77963 Schwanau          * mailto:ralf.roesch@rw-gmbh.de
Germany                   * WWW: http://www.rw-gmbh.de

P.S. i had been in contact with Greg and Jean in 2004-04.
There had been issue with the eeprom.c on MIPS platform.
Just to confirm: the eeprom.c is also working under MIPS linux 2.6.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: max6626.c
Type: application/octet-stream
Size: 8264 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041118/42d88f42/max6626.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-rnw-2004-11-18.patch
Type: application/octet-stream
Size: 1477 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041118/42d88f42/i2c-rnw-2004-11-18.obj
