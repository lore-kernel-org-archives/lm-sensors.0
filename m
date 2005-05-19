From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: RPM spec file patches for i2c and lm_sensors 2.8.1
Message-Id: <20031101120304.4807d0d6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E13FDA5@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E13FDA5@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> The kernel rpms for Fedora Core 1 (labeled as rawhide in the repo)
> already have 2.8.1 support. Userland lm_sensors needs to be updated,
> and I wanted to try building the kernel modules there also (otherwise
> one may miss a few).

True.

> If I make lm_sensors.spec a specfile for kernel modules it will
> probably become unreadable. Any help in packaging is appreciated!

Why would it become unreadable? Modules aren't that different from other
files. They are built the same way, installed the same way. I don't
really see the problem (but this is a long time since I last packaged
files in a RPM, so I might be missing something obvious).

Since lm_sensors' modules don't require patching the kernel source tree,
I sure would build them out of it and propose them as a separate
package. That way you got them all (which isn't the case when patching
the kernel tree) and it's less complicated to update the RPM file IMHO.

> BTW does lm_sensors 2.8.1 (userland & kernel modules) require i2c
> 2.8.1 or is i2c 2.8.0 already adequate? If the latter is true it would
> save me from rebuilding the RH7.3-RH9 kernels.

It requires i2c 2.8.1, because a unified delay function has been
introduced to replace the various separate ones that existed in 2.8.0.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
