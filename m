From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [2.6 patch] drivers/w1/: possible cleanups
Message-Id: <1113920787.29655.11.camel@uganda>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050417233145.GX3625@stusta.de>
In-Reply-To: <20050417233145.GX3625@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 01:31 +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - #if 0 unused functions
> - remove unused EXPORT_SYMBOL's
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thank you for your patch, I will apply the most of it,
but I have some points against
1. removing ->get(), while having ->put() methods.
2. removing some w1_read/write* methods() since they are used for test
cases.

I will push it after Greg applied current pending patchset.

-- 
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050419/0517f188/attachment.bin
