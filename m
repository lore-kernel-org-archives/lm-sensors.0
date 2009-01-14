From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Wed, 14 Jan 2009 21:08:27 +0000
Subject: Re: [lm-sensors] sensord with rrd
Message-Id: <496E544B.80905@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <gkimcg$46k$1@ger.gmane.org>
In-Reply-To: <gkimcg$46k$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/14/09 12:39, Jean Delvare wrote:
> Hi Mark,
> 
> On Wed, 14 Jan 2009 12:26:45 -0800, Mark E. Hansen wrote:
>> FYI: I just installed CentOS 5.2 on a machine here and had to go back
>> to lm-sensors 2.10.6, as the 3.0.3 version would not produce alarms
>> in the sensors output, even when readings were beyond their configured
>> limits. After moving back to 2.10.6, the alarms worked as expected.
>> My motherboard and sensors chip is different than the OP's, so this
>> may not apply to him.
> 
> Nice thread hi-jacking ;)

Sorry, I wasn't trying to hijack. Just wanted to inform the OP of the
issue before he went to the trouble of installing 3.0.3.

> 
>> Note: I did post a question to this list about this issue, but have
>> yet to receive any responses.
> 
> That was during vacation, when not that many developers take the time
> to read the mailing list.

Vacation? What's that? :-)

> 
> Alarms are the last piece that has been ported to the standard sysfs
> interface (which lm-sensors 3 builds on top of.) See
> http://www.lm-sensors.org/ticket/2261
> for a list of drivers that have been fixed in recent kernels. So
> basically for proper alarm support with lm-sensors 3.x you need a
> recent enough kernel.

To get the chip in my motherboard working (with either version or lm-sensors)
I had to get an updated kernel module (the chip is ITE IT8716F). The kernel
module is 'it87'.

Is this what you mean, or is there other kernel support (other than the
it87 module, I mean) which is needed to get the alarms to work?

Thanks,


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
