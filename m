From: olegg@ukrpack.net (Oleg Gritsinevich)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: Problems with Intel SDS2 server board
Message-Id: <20040322083749.GA1879@kunashir.ukrpack.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040318142540.GA1450@kunashir.ukrpack.net>
In-Reply-To: <20040318142540.GA1450@kunashir.ukrpack.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 20, 2004 at 05:40:26PM -0500, Mark Studebaker wrote:
> Be sure you have IPMI enabled in the kernel,
> then load it, and load our i2c-ipmi driver, then bmcsensors should
> return useful information.
> 
	Mark, thank you very much! I loaded with 'modprobe' following
modules: ipmi_msghandler, ipmi_devintf, ipmi_kcs_drv, ipmi_watchdog,
i2c-ipmi. Then I run '/etc/init.d/lm_sensors start', it loaded modules
found by 'sensors-detect' and all start to work!
	Now bmcsensors gives me data from 3 temp, 10 volt, 0 current,
6 fan sensors. I'm happy :-)

	Maybe maintainers of 'sensors-detect' will find it usefull to
add dependency bmcsensors->{ipmi_msghandler,ipmi_devintf,ipmi_kcs_drv,
ipmi_watchdog,i2c-ipmi} into 'sensors-detect'. I think it will help some
people.
-- 
With best regards, Oleg Gritsinevich
