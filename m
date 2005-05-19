From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: problems with supermicro X6DHE-XG2
Message-Id: <20050330195708.30a3cd66.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1112204227.6784.31.camel@bart>
In-Reply-To: <1112204227.6784.31.camel@bart>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Federico,

> i'm trying to configure lm_sensors on a server with no success. The
> motherboard is a Supermicro X6DHE-XG2
> http://www.supermicro.com/products/motherboard/Xeon800/E7520/X6DHE-XG2.cfm
> and the Linux Distro is a Fedora Core 3 with a custom kernel 2.6.11
> (I2C modules compiled).
> 
> The problem is a lack of hardware support from kernel/lm_sensors? Or
> the configuration need some stange configurations and/or patches?

I can't find the name of the hardware monitoring chips in Supermicro's
docs. Can you please just send the full output of sensors-detect on your
system?

-- 
Jean Delvare
