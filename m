From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sun, 18 Sep 2005 23:34:54 +0000
Subject: [lm-sensors] read()ing an i2c node results in errno=ENOSYS
Message-Id: <20050918213441.GB6263@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <b4e191e7050915035768c521ef@mail.gmail.com>
In-Reply-To: <b4e191e7050915035768c521ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, David:

* Jean Delvare <khali@linux-fr.org> [2005-09-18 09:22:53 +0200]:
> Note that a client chip can only support one of the two kinds of block
> reads at any register address ("command byte" in the SMBus
> specification), as there is no way to distinguish between both commands
> from the client's point of view. It's up to the master (PC) to use the
> correct one depending on what the client implements.

Actually: SMBus read byte data, SMBus read word data, and SMBus block read
*all* have the same setup:

	S Addr Wr [A] Comm [A] S Addr Rd [A] (...)

As Jean mentions: you'll need to decide how your slave device responds on
each register address (comm), and then program the master accordingly.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

