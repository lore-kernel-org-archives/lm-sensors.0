From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Wed, 03 Dec 2008 19:55:57 +0000
Subject: Re: [lm-sensors] Intel S5000 Server board, Ubuntu 8.10
Message-Id: <20081203195557.GO6539@plum>
List-Id: <lm-sensors.vger.kernel.org>
References: <484CA69D4507624FACB312684B9211F90135189DF3@MAILBOXSERVER.mgsops.net>
In-Reply-To: <484CA69D4507624FACB312684B9211F90135189DF3@MAILBOXSERVER.mgsops.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Dec 03, 2008 at 04:00:10PM +0200, Rolf Bartels wrote:
> Hi,
> 
> I hope someone can help me.
> 
> I am running a Intel Server board S5000 and Ubuntu 8.10.
> When I do my detect and at the end I get this.
> 
> I have install OpenIPMI and ipmitools, but I am still only getting CPU temp and not any fan speed or MB temp.
> 
> #----cut here----
> # You must also install and load the IPMI modules
> ipmi-si
> # Chip drivers
> # Warning: the required module ipmisensors is not currently installed
> # on your system. For status of 2.6 kernel ports check
> # http://www.lm-sensors.org/wiki/Devices. If driver is built
> # into the kernel, or unavailable, comment out the following line.
> ipmisensors

The ipmisensors driver is an out-of-tree patch that's slowly bitrotting.
Your best bet, alas, is to load ipmi-si and ipmi-devintf and use
ipmitool to access the BMC sensors.

(If you're really really keen on coding something, the old patch still
lives here: http://bmcsensors-26.sourceforge.net/ )

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
