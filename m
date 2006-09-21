From: paul.aviles@nickelnetworks.com (Paul Aviles)
Date: Thu, 21 Sep 2006 19:36:00 +0000
Subject: [lm-sensors] Sensors questions - Can't get
Message-Id: <200609211936.k8LJa5AR017558@www.palei.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200609200234.k8K2Y63n013063@www.palei.com>
In-Reply-To: <200609200234.k8K2Y63n013063@www.palei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean, both the sysfsu and the dev packages are installed, that is the part
that I can't explain. I did the regular make clear first. Let me try a
second round and will update the list.

Thanks

Paul Aviles 

-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Thursday, September 21, 2006 3:31 PM
To: Paul Aviles
Cc: 'LM Sensors'; r.marek at sh.cvut.cz
Subject: Re: [lm-sensors] Sensors questions - Can't get

Hi Paul,

> make: *** No rule to make target `sysfs/libsysfs.h', needed by 
> `lib/sysfs.ad'.
> 
> When I am trying to do a make user.  I already have sysfsutils installed.
> Any ideas?

First of all, do "make clean" before running "make user" again.
Sometimes it helps. If it doesn't, it might be that you have the sysfsutils
package installed from your distro but not the sysfsutils-devel package,
which typically contains the header files.
Install it, make clean, make user.

--
Jean Delvare




