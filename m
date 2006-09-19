From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 19 Sep 2006 07:46:42 +0000
Subject: [lm-sensors] issue with clearing alarms
Message-Id: <20060919094642.912a6a7b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <450312F6.4030500@gmail.com>
In-Reply-To: <450312F6.4030500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> bit 7 is an RW1C bit, which means that the code you quoted above should 
> clear it,
> esp when I do: cat in8*; cat in8*
> oddly, it does not reset the bit.

I think it does, but given that the PC87366 samples values faster than
the driver allows you to read them (due to the register cache) you
can't see it. You'd need to add some code to the driver or poke the
registers directly from user-space (using isaset and isadump) to see
the bit being actually reset.

But anyway, we don't care about this bit at all.

-- 
Jean Delvare

