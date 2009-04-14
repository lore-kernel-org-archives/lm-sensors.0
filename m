From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Date: Tue, 14 Apr 2009 09:27:46 +0000
Subject: [lm-sensors] w83793 related question
Message-Id: <49E45712.6020906@aei.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

on Supermicro PDMSL-LN2+ boards there is a w83793 chip which seems to
work fine, however, it seems we are hitting quite a few error messages
and I don't know how to get rid off them cleanly

typical messages are:

[1953397.341265] w83793 0-002f: set bank to 2 failed, fall back to bank
0, read reg 0x215 error
[1975470.881264] w83793 0-002f: set bank to 2 failed, fall back to bank
0, read reg 0x210 error
[1996226.542514] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0x8c error
[2007778.861264] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0x88 error
[2030598.800018] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0x78 error
[2047548.600033] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0x78 error
[2061616.870018] i801_smbus 0000:00:1f.3: Transaction timeout
[2061616.890025] i801_smbus 0000:00:1f.3: Failed terminating the transaction
[2061616.890233] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0xb2 error
[2061616.890600] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
[2061616.890812] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
[2061616.891014] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0xc3 error
[2061616.891384] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
[2061616.891585] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0xc4 error
[2061616.891948] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
[2061616.892146] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0xc5 error
[2061616.892515] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
[2061616.892716] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0x52 error
[2061616.893082] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
[2061616.893281] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0x53 error
[2061616.893653] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
[2061616.893858] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0x54 error
[2061616.894228] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
[2061616.894427] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0x55 error
[2061616.894790] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
[2061616.894988] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0x56 error
[2061616.895356] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
[2061616.895555] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0x57 error
[2091449.930030] w83793 0-002f: set bank to 0 failed, fall back to bank
2, read reg 0x8c error
[2122602.861265] w83793 0-002f: set bank to 2 failed, fall back to bank
0, read reg 0x210 error

Google only shows me lots of references to the Linux kernel, but that
does not really help me much right now.

System is running pretty recent 2.6.27 kernel and lm-sensors 3.0.2.

Any hint how i can get rid off these?

Cheers and thanks a lot in advance

Carsten

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
