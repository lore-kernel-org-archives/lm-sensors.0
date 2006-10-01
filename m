From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Sun, 01 Oct 2006 00:40:08 +0000
Subject: [lm-sensors] 2.10.1: No rule to make target `asm/io.h',
Message-Id: <20061001004008.GA24173@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060926135555.GH10410@neu.nirvana>
In-Reply-To: <20060926135555.GH10410@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 30, 2006 at 07:17:36PM +0200, Axel Thimm wrote:
> On Tue, Sep 26, 2006 at 10:17:03PM +0200, Jean Delvare wrote:
> > > On Tue, Sep 26, 2006 at 08:56:48PM +0200, Jean Delvare wrote:
> > > > > > No, it looks like /usr/include/asm/io.h was recently dropped.
> 
> > > > So it should look for sys/io.h rather than asm/io.h. It does for me.
> 
> Well, on second look even sys/io.h is now missing. And this is for
> both FC6 and RHEL5. :(

And on third look it looks like the headers were reshuffled throughout
the packages w/o fixing the lm_sensors package. So the headers do
exist and source builds work fine but the vendor packages are
broken. I'll respin packages for ATrpms.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061001/789281f4/attachment.bin 
