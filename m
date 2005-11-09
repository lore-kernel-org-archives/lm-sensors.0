From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 09 Nov 2005 12:25:18 +0000
Subject: [lm-sensors] iwill versus w83627thf
Message-Id: <4371DC81.10505@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <c3d94a2d0511090110i70b4d1d9s4287080d5dc429f4@mail.gmail.com>
In-Reply-To: <c3d94a2d0511090110i70b4d1d9s4287080d5dc429f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Just a quick note:

This has been written by Jean and I think it is your case too:

It's caused by PNPACPI since 2.6.10,
and has been fixed recently. See bug #4014 for additional information:
  http://bugzilla.kernel.org/show_bug.cgi?id@14
If you don't want to upgrade kernels, the workaround is to disable
PNPACPI, either when configuring your kernel or on the boot command line
(pnpacpi=off).

Let me know if you have any (other) problems,

Regards
Rudolf
