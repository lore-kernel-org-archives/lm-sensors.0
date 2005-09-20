From: ben@fluff.org.uk (Ben Dooks)
Date: Tue, 20 Sep 2005 12:59:37 +0000
Subject: [lm-sensors] eeprom write!
Message-Id: <20050920105719.GE1810@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050920095254.29043.qmail@web15709.mail.cnb.yahoo.com>
In-Reply-To: <20050920095254.29043.qmail@web15709.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 20, 2005 at 05:52:54PM +0800, junping feng wrote:
> Hi,
>   My cpu is PowerPC8250.I2C device is eeprom AT24C01.
> I want to access the eeprom,read from the eeprom and
> write to it.
>   I have read the file
> /lm_sensors-2.5.0/kernel/chips/eeprom.c,but this file
> can't achieve writing function and only can read 128
> bytes.
>   How can i complete the writing functions and read
> total the chip (1024 bytes).

The chip is only 128 bytes big. You are confusing the
_bit_ size (which is 1024bits).

I have no actual experience of this chip, but the
data-sheet implies it is only capable of page-write
of 4 bytes at a time, so it could be the eeprom
driver is trying to write too much data in one go.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
