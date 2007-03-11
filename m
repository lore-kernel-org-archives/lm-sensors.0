From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Sun, 11 Mar 2007 20:28:46 +0000
Subject: [lm-sensors] libsensors patches
Message-Id: <20070311202846.GB507@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311152104.bd092ff9.khali@linux-fr.org>
In-Reply-To: <20070311152104.bd092ff9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 11, 2007 at 08:53:43PM +0100, Hans de Goede wrote:
> Agreed, thinking about this some more I'm not so sure that dropping 2.4 
> support is a good idea as there is still plenty of 2.4 usage out there. 

I would second keeping 2.4 support if it's not too much pain. Many
RHEL3 users pick i2c/lm_sensors' kernel modules at ATrpms for
supporting their hardware.

But if 2.4 support is slowing down things and developer resources want
to concentrate on 2.6 it will have to go sooner or later.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070311/6ee2ec35/attachment.bin 
