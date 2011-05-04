From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 04 May 2011 09:32:23 +0000
Subject: Re: [lm-sensors] [PATCH v7 0/2] Make all it87 drivers SMP safe
Message-Id: <20110504103223.547dd9e1@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1303153127-11717-1-git-send-email-natg@google.com>
In-Reply-To: <1303153127-11717-1-git-send-email-natg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nat Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org

All looks good to me.

Parport can also be made to behave politely and I'll post a patch for
that.

Acked-by: Alan Cox <alan@linux.intel.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
