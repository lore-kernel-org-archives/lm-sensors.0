From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <20050310204046.6e317c6a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Patrick,

> Note that while not *identical*, the controller shares a lot of
> similarities with the i810 driver.

I assume i801.

> In SMB_HST_STS (offset 0), bit 6 is "ISUSE_STS", which reads a 0 the
> first time after the device is reset, then a 1 after that. Seems like
> it can be used to check if the deivce is ready to be used after a
> reset..

Thanks for the info. Incidentally it might help me with a problem I have
with the i2c-viapro driver. You would be surprised how many common
points there are between the various SMBus masters found on x86
motherboards.

I guess that this bit is read-only?

According to the source, bit 7 is "DONE". I guess it is read-only as
well, and set after a successful transaction?

If bit 5 used for anything?

> It says that it only happens at address 0x58. Is there a device there?
> If there is, perhaps you could try increasing the timeout?

I would guess that 0x58 is the value of the register, which is 7 bits of
address and 1 bit of R/W. So the device address would rather be 0x44
(0x58 >> 1). It happens that 0x44 is a special address for SMBus 2.0, if
I am not mistaken.

I don't know much more, unfortunately.

Anyway thanks Patrick for the info.

-- 
Jean Delvare
