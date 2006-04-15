From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Sat, 15 Apr 2006 12:41:25 +0000
Subject: [lm-sensors] lm87 support on Centos 4.3 (kernel 2.6.9-34.EL)
Message-Id: <20060415124125.GC26024@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <443C3FF8.9080002@sedonanetworks.com>
In-Reply-To: <443C3FF8.9080002@sedonanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 13, 2006 at 07:01:56PM +0200, Rudolf Marek wrote:
> Doug - Sedona Networks wrote:
> > I'm using Centos 4.3 and appears from your website that support
> > for the lm87 chip used on the Suppermicro P3TDEi mb's is only
> > available from kernel 2.6.10 and Centos is currently using
> > 2.6.9-34.
> 
> > Any other suggestions other than rebuilding the kernel?
> 
> No sorry.
> 
> Oh exept one. You can try to build the kernel outside the kernel tree. But his implies
> you can run make modules_prepare in in the 2.6.9 kernel and you must have proper
> configuration file (.config) installed.

I thought out-of-tree builds were not supported anymore for 2.6
kernels. If they are I could pick them up again and create rpms for
them (kmdls) like for the 2.4 kernels. That would solve Doug's issue,
too, as I package for RHEL4, too.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060415/ef1f5891/attachment.bin
