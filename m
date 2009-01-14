From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Wed, 14 Jan 2009 22:12:43 +0000
Subject: Re: [lm-sensors] sensord with rrd
Message-Id: <496E635B.9040400@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <gkimcg$46k$1@ger.gmane.org>
In-Reply-To: <gkimcg$46k$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/14/09 13:58, Jean Delvare wrote:
> On Wed, 14 Jan 2009 13:08:27 -0800, Mark E. Hansen wrote:
>> On 01/14/09 12:39, Jean Delvare wrote:
>> > Alarms are the last piece that has been ported to the standard sysfs
>> > interface (which lm-sensors 3 builds on top of.) See
>> > http://www.lm-sensors.org/ticket/2261
>> > for a list of drivers that have been fixed in recent kernels. So
>> > basically for proper alarm support with lm-sensors 3.x you need a
>> > recent enough kernel.
>> 
>> To get the chip in my motherboard working (with either version or lm-sensors)
>> I had to get an updated kernel module (the chip is ITE IT8716F). The kernel
>> module is 'it87'.
>> 
>> Is this what you mean, or is there other kernel support (other than the
>> it87 module, I mean) which is needed to get the alarms to work?
> 
> I mean the it87 module, indeed. But each kernel version has a different
> version of that module, it gets improved over time. Alarm support
> suitable for lm-sensors 3 was added in kernel 2.6.25.
> 

Well, one of the folks on the CentOS forum said that support for my particular
chip was in the 'upstream' kernel, and he created a kernel module from that
source (I don't know which kernel version it was, specifically). I'll go back
and ask him, then post a new question to this list about whether Alarm support
should be in there.

Thanks, and Sorry Mark for the thread-stepping.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
