From: michaelnel@comcast.net (Michael Nelson)
Date: Wed, 06 Sep 2006 13:43:19 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060906134318.GA16925@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 06, 2006 at 05:15:09AM -0700, Michael Nelson wrote:

> I tried it, and although the 2.6.18-rc4 kernel and modules compiled OK, the
> kernel segfaults and dies during boot (well before any lm-sensors stuff
> happens).  I am looking into that now.

I have tried recompiling the kernel & modules several times now, with less
and less stuff being included in the .config... but the kernel still
segfaults just before trying to load the jbd and ext3 modules.  

Honestly, for the past few years I have been using production, rpm-based
kernels, and although years ago I used to build every kernel that came out,
I am way out of practice.

I am not sure how to troubleshoot this.  The segfault and associated error
messages happens pretty early in the kernel load, after scsi and ata drivers
are loaded... but then it scrolls almost all the way off screen and I can't
see what the beginning of the error was.

Michael

-- 

San Francisco, CA

