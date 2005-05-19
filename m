From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: A question when test W83792D driver on another motherboard
Message-Id: <Pine.LNX.4.58.0502231208590.14130@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Here is Rudolf speaking.
I'm the second person who played with hidden 792D.

I think the function fails because nothing listens on that address.
(Khali/Jean can you confirm?)

you can try:

modprobe i2c-dev
i2cdetect -l

You will see the bus number you will use in next command.

i2cdetect 0

0 Is my bus number.

This command will probe i2c addresses to find all clients.
If you will see XX on that address where should be 792D. Then it is
hidden.

Asus put some simple multiplexer to hide it. We think they use GPIO lines
from superIO. Ask what lines to trigger to unhide it.
(Logical device and what GPIO line from that group)

I hope this helps.

Regards

Rudolf

