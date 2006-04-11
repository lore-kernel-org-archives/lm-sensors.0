From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 11 Apr 2006 17:29:15 +0000
Subject: [lm-sensors] ICH7 - no sensors found.
Message-Id: <443BE76B.7090702@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060411043415.6613.qmail@web36806.mail.mud.yahoo.com>
In-Reply-To: <20060411043415.6613.qmail@web36806.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mathew Tebbens wrote:
> Installed everything correctly.
> Did a sensors-detect
> Made the recommended mods
> Loads mods on boot
> But no sensors found!  (see below).
> 
> Attached are outputs from sensors-detect, lsmod, lspci.

> Any suggestions on what I can do to fix this ?

Hmm sounds like unsupported chip to me. (No hwmon devices on i2c bus)
What is your manufacturer and board name?

Can you see some temps in BIOS?

Regards
Rudolf


