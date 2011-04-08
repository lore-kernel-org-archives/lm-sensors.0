From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 08 Apr 2011 12:25:41 +0000
Subject: Re: [lm-sensors] [PATCH] Make all it87 drivers SMP safe.
Message-Id: <20110408132541.39042e95@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302038697-28985-1-git-send-email-natg@google.com>
In-Reply-To: <1302038697-28985-1-git-send-email-natg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nat Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org

> attempts to serialize access to the hardware by defining a global spinlock
> it87_io_lock in a file it87_lock.c. This lock has to be acquired by each
> of the it87 drivers before it can access the hardware. We have defined

I think this needs a NAK

The resource handler can do this for you and would ensure proper
behaviour.

See
	IORESOURCE_MUXED


Providing the it87 drivers request the resources (which they need to do
anyway!) and use IORESOURCE_MUXED, it should all work ?

Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
