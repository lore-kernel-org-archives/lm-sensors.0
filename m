From: jeffreydm@sbcglobal.net (Jeffrey Mitchell)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: portability issue?
Message-Id: <20040926162038.31076.qmail@web80302.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040926153810.85135.qmail@web80314.mail.yahoo.com>
In-Reply-To: <20040926153810.85135.qmail@web80314.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thank you so much for the explanation and I agree that it is a GREAT eaxample of why orpen source is preferable. I myself would make the switch to linux 100% if it wasn't for the fact that it still doesn't fully support anti-virus and cd/dvd rw type functions. 
Keep up the good work and thank you for a great product!

Jean Delvare <khali@linux-fr.org> wrote:
> is there any chance you will be developing a Windows version of the
> sensors package?

Zero chance. Most of the code is part of the Linux kernel, it cannot
work outside of Linux. It's more than a code portability issue, it's a
design issue.

> Motherboard monitor is no longer being developed and
> I am hoping for something as reliable in windows.

Blame the manufacturers for having requested Alex to sign NDAs against
information. This is what prevents him from releasing his code to the
public in the hope someone would continue his work.

Hopefully, people will now realize that using a closed-source program
means that you are dependent on the person or company developing it.
It's sad that people have to learn that the hard way.

This also explains why we do not sign NDAs.

Note that nothing prevents you or anyone to start a GPL hardware
monitoring project for Windows based on our code. We are just not going
to do it. And at any rate, it would be about copying knowledge, not
code. All the code relies on Linux internals.

> Please consider the possibility. If not, can you refer me to some
> other product or site that will help me?

There are several other hardware monitoring solutions for Windows,
either MBM replacements (most notably SpeedFan) or vendor-suplied,
hardware-specific solutions (such as AsusProbe). None of these equate
the quality of MBM though.

-- 
Jean Delvare
http://khali.linux-fr.org/
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040926/a51e70b8/attachment.html
