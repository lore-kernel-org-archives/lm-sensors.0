From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: 2.8.1
Message-Id: <20031026192601.50f00938.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F6484BA.24E78516@paradyne.com>
In-Reply-To: <3F6484BA.24E78516@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Axel, hi all,

I just uploaded new i2c patches for the Linux 2.4.22 kernel based on the
freshly released 2.8.1 i2c. This patchset will be the base of the patch
I'll post to the LKML for inclusion. It will require some changes to
apply cleanly to 2.4.23-pre8, but basically that's it. Everyone is
welcome to test it. I've myself checked that it would at least compile,
but I can't test everything. Some drivers can only be compiled on
non-x86 systems, so I can't hardly test them. For the rest of the
drivers, I'll test them on the hardware I do have, but I of course don't
have all the required hardware.

So everyone please review, test and comment my patch before I will
submit it to the kernel folks. I'd really like it to be included to
Linux 2.4.23.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
