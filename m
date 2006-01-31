From: nrapp@usc.edu (Nick Rapp)
Date: Tue, 31 Jan 2006 03:28:08 +0000
Subject: [lm-sensors] ITE8712F-A Chip problems
Message-Id: <35c952d60601301928h51a3cf28v80a40ea4247b2539@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey guys, I just got a new motherboard, and i'm having a strange issue with
the ITE chip. First of all, when sensors-detect is probing, my computer
shuts itself off instantly.
I've tried to narrow it down a little further... I know I have that chip, so
I tried to modprobe the it86 driver manually. The result is the same,
computer just shuts off, so I assume that the initial problem and the ladder
are one in the same.

Any suggestions? The board is a DFI Lanparty nF4 Expert. Thanks!

Nick
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060131/5e8411a9/attachment.html
