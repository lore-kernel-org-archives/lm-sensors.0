From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Sat, 30 Sep 2006 17:17:36 +0000
Subject: [lm-sensors] 2.10.1: No rule to make target `asm/io.h',
Message-Id: <20060930171736.GA15743@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060926135555.GH10410@neu.nirvana>
In-Reply-To: <20060926135555.GH10410@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 26, 2006 at 10:17:03PM +0200, Jean Delvare wrote:
> > On Tue, Sep 26, 2006 at 08:56:48PM +0200, Jean Delvare wrote:
> > > > > No, it looks like /usr/include/asm/io.h was recently dropped.

> > > So it should look for sys/io.h rather than asm/io.h. It does for me.

Well, on second look even sys/io.h is now missing. And this is for
both FC6 and RHEL5. :(
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060930/c6b967d6/attachment.bin 
