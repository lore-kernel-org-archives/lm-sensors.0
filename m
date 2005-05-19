From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Ask for some information about motherboard ASUS NCLV-D
Message-Id: <NZbSb55r.1113379944.7968710.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf, hi Chunhao,

> You see one eeprom dissapeared, your device appeared but 0x55 remained for
> some reason. But in fact nothing left there. Without information from ASUS
> I cant tell you what happened there.

Your assumption that the EEPROM at 0x55 might be wrong. The device at
0x55 might be a different one after the SMBus as been switched. In fact,
I think it is.

From the early days, we assumed that Asus was merely trying to hide their
hardware monitoring chip. This is probably true, but nevertheless what
they are doing is SMBus switching. They might as well be doing that for
other reasons, such as the need to have different chips at the same I2C
address. Think of the Tyan S4882 example.

So it sounds like a more proper approach of the problem would be to hack
the SMBus driver in the same way I did for i2c-amd756, and add proper
bus multiplexing. (And yes, we would need to integrate the multiplexing
deeper in i2c-core in Linux 2.6, but I have not yet taken the time to
look at how this can be done cleanly.)

> I expected this to show up. Again I cant tell what happened in bus because
> I dont know what the multiplexer really did with the bus.

Chunhao, could you please ask Asus for a complete diagram or description
of the SMBus on this board? We need to know which devices are on each
branch of the multiplexer. Looks like memory module EEPROMs are on
branch 1, and the W83792D is on branch 2, but there seems to be other
EEPROMs on branch 2 as well. If we could have a picture or detailed
explanation of the SMBus use on this board, we could modify the kernel
code accordingly.

Thanks,
--
Jean Delvare
