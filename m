From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: gs10
Message-Id: <20041004115444.M60659@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041003231641.M43741@palei.com>
In-Reply-To: <20041003231641.M43741@palei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 4 Oct 2004 07:45:21 -0400, Paul Aviles wrote
> yes, the detection is done on the secondary super io. So, patch 
> pc87360.c, recompile and try again correct?

Yes, that's it. From within the kernel/chips subdirectory,
patch -p0 < pc87360.c.diff

Note that I could not verify it even compiles yet, will do this evening. The
changes are relatively simple though, so I have good hope.

The pc87360 driver is quite new, so please let me know how it works for you.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
