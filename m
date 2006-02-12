From: brix@gentoo.org (Henrik Brix Andersen)
Date: Sun, 12 Feb 2006 14:06:58 +0000
Subject: [lm-sensors] update for fancontrol
Message-Id: <20060212140658.GA30002@osgiliath.brixandersen.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <200602122300.18074.paul@andreassen.com.au>
In-Reply-To: <200602122300.18074.paul@andreassen.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 12, 2006 at 11:00:17PM +1000, Paul Andreassen wrote:
> Attached is an updated 'fancontrol' file where I've remove the use of awk, cut 
> and cat from the main loop.  I would have done the 'LoadConfig' function but 
> figured that redoing the '/etc/fancontrol' format would be easier.  But that 
> would required changing 'pwmconfig' and everyone rerunning it.

Please provide a unified diff (diff -u) instead.

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
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060212/450b9772/attachment.bin
