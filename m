From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Jan 2009 21:58:13 +0000
Subject: Re: [lm-sensors] sensord with rrd
Message-Id: <20090114225813.4781c698@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <gkimcg$46k$1@ger.gmane.org>
In-Reply-To: <gkimcg$46k$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 14 Jan 2009 13:08:27 -0800, Mark E. Hansen wrote:
> On 01/14/09 12:39, Jean Delvare wrote:
> > Alarms are the last piece that has been ported to the standard sysfs
> > interface (which lm-sensors 3 builds on top of.) See
> > http://www.lm-sensors.org/ticket/2261
> > for a list of drivers that have been fixed in recent kernels. So
> > basically for proper alarm support with lm-sensors 3.x you need a
> > recent enough kernel.
> 
> To get the chip in my motherboard working (with either version or lm-sensors)
> I had to get an updated kernel module (the chip is ITE IT8716F). The kernel
> module is 'it87'.
> 
> Is this what you mean, or is there other kernel support (other than the
> it87 module, I mean) which is needed to get the alarms to work?

I mean the it87 module, indeed. But each kernel version has a different
version of that module, it gets improved over time. Alarm support
suitable for lm-sensors 3 was added in kernel 2.6.25.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
