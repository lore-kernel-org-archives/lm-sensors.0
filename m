From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 26 May 2006 12:10:31 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <20060526141031.7774b25a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <446DF157.80805@t-online.de>
In-Reply-To: <446DF157.80805@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Harald,

Harald Dunkel wrote:
> The datasheet of the F75387 doesn't say anything about Packet
> Error Checking, but I am not sure whether this is a feature of
> the bus. Is it?
> 
> Can something bad happen if I don't support PEC?

PEC is an optional protocol extension, it can be used only when both
the master and the slave support it.

The Fintek F75387 datasheet doesn't mention PEC, so I would assume it
doesn't support it. Chips supporting PEC are the exception rather than
the rule, only the ADM1032 chip (lm90 driver) supports it in our whole
driver set. So just forget about PEC, and everything will be fine.

-- 
Jean Delvare

