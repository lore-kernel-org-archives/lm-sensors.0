From: brix@gentoo.org (Henrik Brix Andersen)
Date: Sun, 22 Jan 2006 11:48:31 +0000
Subject: [lm-sensors] scx200_acb compilation breakage
Message-Id: <20060122114831.GB29407@osgiliath.brixandersen.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060120210612.6bcb6e8e.khali@linux-fr.org>
In-Reply-To: <20060120210612.6bcb6e8e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 22, 2006 at 11:42:40AM +0100, Jean Delvare wrote:
> Basically it adds a dependency on SCX200 rather than X86. It's more
> specific so I would tend to prefer it.

An alternative would be to make it depend on MGEODEGX1, but I don't
know if that covers all Geode based boards. It's what I use for my
Soekris units, though.

Regards,
Brix
-- 
Henrik Brix Andersen <brix at gentoo.org>
Gentoo Metadistribution | Mobile computing herd
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 211 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060122/8c430202/attachment.bin
