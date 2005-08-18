From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 18 Aug 2005 00:50:31 +0000
Subject: [lm-sensors] Status of the pcf8591 driver for the 2.6 Kernel
Message-Id: <4303BF10.5010407@aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4303B750.5050402@buholzer.com>
In-Reply-To: <4303B750.5050402@buholzer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

Mirko Buholzer a ?crit :
> I would like to use the pcf8591 driver on a 2.6.8 Debian Linux. What is 
> the current Status?

This chip is supported on this configuration.

> 
> I currently have the following Packages installed, but can't find the 
> driver:

run 'modprobe pcf8591' to load the driver.

Bye,
Aurelien

-- 
   .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
  : :' :  Debian GNU/Linux developer | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
