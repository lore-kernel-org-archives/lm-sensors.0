From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: A question when test W83792D driver on another motherboard
Message-Id: <d4DlFYfJ.1109579696.0808150.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> When it has been confirmed that it is ASUS motherboard, write the value
> 0x08 into the port 0x04b9.
> (...)
> Then, do you have any idea on how to solve the problem we meet?
> If do, please tell me, I'd like to test it on this motherboard.

Just try "isaset -y -f 0x4b9 0x08". That should do the trick Asus
recommends.

If you confirm that the W83792D then appears on the SMBus (as probed by
sensors-detect or i2cdetect) then we'll have to integrate the trick.
For 2.6 there is a place dedicated to this (pci/quirks.c). For 2.4 there
is none so we'll just document the fact that isaset must be run prior
to loading the smbus driver, or integrate the operation into the smbus
driver itself (shouldn't be too hard).

I still wonder what device is at 0x4b9. According to the snapshot of
/proc/ioports you sent, your linux system doesn't know about it.

Thanks,
--
Jean Delvare
