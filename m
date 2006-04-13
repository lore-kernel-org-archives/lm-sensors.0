From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 13 Apr 2006 17:01:56 +0000
Subject: [lm-sensors] lm87 support on Centos 4.3 (kernel 2.6.9-34.EL)
Message-Id: <443E8404.8040203@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <443C3FF8.9080002@sedonanetworks.com>
In-Reply-To: <443C3FF8.9080002@sedonanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Doug - Sedona Networks wrote:
> I have a number of Supermicro P3TDEi daul PIII servers I'm attempting to 
> get lm_sensors working with to poll temps and fans speeds.
> 
> I'm using Centos 4.3 and appears from your website that support for the 
> lm87 chip used on the Suppermicro P3TDEi mb's is only available from 
> kernel 2.6.10 and Centos is currently using 2.6.9-34.

You can try to port the driver to that kernel, maybe it will go without problems.

> Is there any chance that Centos/RHEL will use the 2.6.10 kernel soon or 
> is it final at 2.6.9....?  Just  trying to get an idea if I can wait for 
> an update or not.

You must ask RHEL and Centos not us. Maybe you have paid for the distribution
so you may ask them for support.

> Any other suggestions other than rebuilding the kernel?

No sorry.

Oh exept one. You can try to build the kernel outside the kernel tree. But his implies
you can run make modules_prepare in in the 2.6.9 kernel and you must have proper
configuration file (.config) installed.

Regards
Rudolf

