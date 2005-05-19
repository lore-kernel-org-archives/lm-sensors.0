From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: MPX2/LM90 switching discussion
Message-Id: <20040717090418.49b53e8d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40F6F2A2.50503@synque.com>
In-Reply-To: <40F6F2A2.50503@synque.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This sounds like a specific issue of a generic problem that has come
> up recently on this list.  That is, i2c bus MUX's and additional
> busses.
>
> This GPIO pin is probably controlling a MUX that chooses between two 
> different busses.

For the sake of information exactitude, Alex analyzed the MPX2's
behavior as a *diode* switching, not SMBus switching. This is something
different, so it may or may not fit into the discussion about muxing I2C
busses (and at first sight, I would think it doesn't).

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
