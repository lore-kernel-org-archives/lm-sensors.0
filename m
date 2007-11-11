From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 11 Nov 2007 22:25:39 +0000
Subject: Re: [lm-sensors] 2.10.5 on 2.4 kernel requires sysfs/libsysfs.h?
Message-Id: <20071111232539.6613ce67@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071110095638.GA29181@puariko.nirvana>
In-Reply-To: <20071110095638.GA29181@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

On Sat, 10 Nov 2007 11:56:38 +0200, Axel Thimm wrote:
> up to 2.10.4 sysfsutils was only required for 2.6 kernels. Now the
> build fails on 2.4 kernel system w/o sysfsutils with
> 
> make: *** No rule to make target `sysfs/libsysfs.h', needed by `lib/sysfs.ad'.
> 
> Is that a bug in the Makefiles or is sysfsutils now really required
> for 2.4. kernels as well?
> 
> (I hit this while building rpms for RHEL3).

No, sysfsutils is still not required for 2.4 kernels.

The only change in 2.10.5 that could cause this problem is this one:
http://www.lm-sensors.org/changeset/4738

But I tested this with a 2.4 kernel and it works as intended.

Hmmm, maybe I see what's going on. Are you cross-building the RHEL3
package, on a system itself running a 2.6 kernel? And how are you
pointing the build system to the right kernel tree to build against in
this case?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
