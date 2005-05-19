From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: smsc47m1 ported to Linux 2.6
Message-Id: <20040720225853.6f67122b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just finished a preliminary version of the smsc47m1 driver to Linux
2.6. Patch is available here:

http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.8-rc2-i2c-smsc47m1-alpha2.diff

It's basically Gabriele Gorla's version, updated to reflect recent
changes to the kernel and fixes to the 2.4 driver, plus some minor
tweaks. As the name says, it's built against 2.6.8-rc2, but any recent
kernel tree (>=2.6.7) should do too.

Note that the patch is completely untested since I don't own a
compatible device myself. But I felt that the port had been pending for
too long and I know that there is an impatient crowd waiting for this
driver to be part of Linux 2.6, so I tried to complete the existing code
into something people could finally try.

Please test if possible, and tell me how it fails for you ;)

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
