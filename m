From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 06 Nov 2005 11:07:54 +0000
Subject: [lm-sensors] ATI SMBus - new information
Message-Id: <436DD5CB.3090503@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <435A1BA9.9080009@sh.cvut.cz>
In-Reply-To: <435A1BA9.9080009@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 
> It works for me.

good

> If I understand correctly, is it possible to access chip LPC47MXXX
> through i2c or isa?

10:40 < khali> Driver smsc47m1 always use i2c-isa driver.
10:40 < khali> it's not the same part of the device being accessed
10:41 < khali> throught ISA we have fan monitoring and control
10:41 < khali> on SMBus we have temperature and voltage monitoring

10:39 < khali> and a driver is supposed to be in progress, but it's a long time
               we didn't hear about it

Thomas,
Any news?


Last test the BUS transport will be the byte write mode.

i2cdump 0 0x2d

Should give you a register dump.

Datasheet is here
http://www.smsc.com/main/tools/discontinued/47m15x.pdf

Now please read the value on offset 0x31 (5V high limit) and add one to it and write it back to chip

i2cset 0 0x2d 0x31 0xyourvall

Readback should match.

Thanks

Regards
Rudolf
