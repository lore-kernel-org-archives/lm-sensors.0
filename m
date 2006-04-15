From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Sat, 15 Apr 2006 17:54:27 +0000
Subject: [lm-sensors] lm87 support on Centos 4.3 (kernel 2.6.9-34.EL) /
Message-Id: <20060415175427.GA655@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <443C3FF8.9080002@sedonanetworks.com>
In-Reply-To: <443C3FF8.9080002@sedonanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Sat, Apr 15, 2006 at 03:40:07PM +0200, Jean Delvare wrote:
> > > Oh exept one. You can try to build the kernel outside the kernel
> > > tree. But his implies you can run make modules_prepare in in the
> > > 2.6.9 kernel and you must have proper configuration file
> > > (.config) installed.
> > 
> > I thought out-of-tree builds were not supported anymore for 2.6
> > kernels. If they are I could pick them up again and create rpms
> > for them (kmdls) like for the 2.4 kernels. That would solve Doug's
> > issue, too, as I package for RHEL4, too.
> 
> But what would you be packaging exactly? Remember that the kernel
> modules in lm_sensors2 CVS are *not* suitable for 2.6 kernels. What
> Rudolf was proposing was to backport one given driver from a recent
> 2.6 kernel to 2.6.9. This would be done on an individual
> basis. There is no out-of-tree set of hardware monitoring drivers
> working for every 2.6 kernel, like we had for 2.4 kernels.

Ah, OK, I misunderstood Rudolf's advice, I thought that maybe
out-of-tree builds had been reintroduced for 2.6. and I didn't notice.

Then wrt the original issue: It is very unlikely that RHEL4 will ever
upgrade to something else than 2.6.9, but backports are very
likely. Doug, you could try bugzilla.redhat.com to file a request. I
guess since you're using CentOS you don't have a customer relation to
Red Hat, but they may still consider it.

Also note that there are development kernels for the next RHEL4 update
where you can check whether any support you need has already happened:

http://people.redhat.com/~jbaron/rhel4/

-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060415/5dbac2b8/attachment.bin
