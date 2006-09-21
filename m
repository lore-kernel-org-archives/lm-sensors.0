From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 21 Sep 2006 19:30:52 +0000
Subject: [lm-sensors] Sensors questions - Can't get
Message-Id: <20060921213052.5c560298.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200609200234.k8K2Y63n013063@www.palei.com>
In-Reply-To: <200609200234.k8K2Y63n013063@www.palei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

> make: *** No rule to make target `sysfs/libsysfs.h', needed by
> `lib/sysfs.ad'. 
> 
> When I am trying to do a make user.  I already have sysfsutils installed.
> Any ideas?

First of all, do "make clean" before running "make user" again.
Sometimes it helps. If it doesn't, it might be that you have the
sysfsutils package installed from your distro but not the
sysfsutils-devel package, which typically contains the header files.
Install it, make clean, make user.

-- 
Jean Delvare

