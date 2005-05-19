From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: update to ticket 1763
Message-Id: <20040825083521.M45840@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <005601c48a5a$065d6410$6c01a8c0@internal.liaison.com>
In-Reply-To: <005601c48a5a$065d6410$6c01a8c0@internal.liaison.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi there .. some more information about the new ticket 1763
> 
> kvh1 # lspci
> (...)
> 00:0f.0 Host bridge: ServerWorks: Unknown device 0203 (rev a0)
> (...)
> 00:0f.3 ISA bridge: ServerWorks: Unknown device 0227

Looks like a ServerWorks CSB6 to me. This was first supported by the i2c-piix4
driver in lm_sensors 2.8.2 (for 2.4 kernels). For 2.6 kernels, first version
to support it was 2.6.1. There were a number of fixes to the i2c-piix4 driver
after that, so you will want to use the most recent possible versions.

So you first need to ensure that you are using recent enough versions of
lm_sensors and/or the linux 2.6 kernel.

Know however that Dell machines are known to have problems with that driver,
caused by bogus BIOSes (or so we guessed). So you may have the correct version
of the driver and still not get it to work, with no known workaround. You'll
be notified in the system logs if this is the case.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
