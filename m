From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 31 Jan 2006 07:09:45 +0000
Subject: [lm-sensors] ITE8712F-A Chip problems
Message-Id: <Ofo4qdi3.1138691385.8119070.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <35c952d60601301928h51a3cf28v80a40ea4247b2539@mail.gmail.com>
In-Reply-To: <35c952d60601301928h51a3cf28v80a40ea4247b2539@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Nick,

On 2005-01-31, Nick Rapp wrote:
> Hey guys, I just got a new motherboard, and i'm having a strange issue
> with the ITE chip. First of all, when sensors-detect is probing, my
> computer shuts itself off instantly.
> I've tried to narrow it down a little further... I know I have that chip,
> so I tried to modprobe the it86 driver manually. The result is the same,
> computer just shuts off, so I assume that the initial problem and the
> ladder are one in the same.
>
> Any suggestions? The board is a DFI Lanparty nF4 Expert. Thanks!

We had one similar report for that board (or a very similar one) a few
days ago :
  http://bugzilla.kernel.org/show_bug.cgi?idX89

Long story short: there is a mysterious chip on this motherboard's SMBus
which shuts down the system when probed.

Workaround for sensors-detect: when asked to probe the nForce2 bus,
choose "selectively" and enter the value "0x2e" as not being probed.

Fix for the it87 driver: this patch:
  http://bugzilla.kernel.org/attachment.cgi?idp32&action=view
It is present in -mm since 2.6.16-rc1-mm2, but hasn't been merged in
mainline yet. It should be merged soon now (before 2.6.16 is released,
at the very least) and might be backported to 2.6.15 and lm_sensors CVS
(for Linux 2.4) as well.

If you don't feel comfortable with patching your kernel, you can try
adding the following line to /etc/modprobe.conf instead:
  modprobe it87 ignore=1,0x2e
It should work equally well.

--
Jean Delvare

