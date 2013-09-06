From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 06 Sep 2013 15:03:14 +0000
Subject: Re: [lm-sensors] Backporting updated lm85 on RHEL5
Message-Id: <20130906170314.57b0a0c0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5229DE5D.7060104@elrepo.org>
In-Reply-To: <5229DE5D.7060104@elrepo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

On Fri, 06 Sep 2013 14:53:33 +0100, Phil Perry wrote:
> I'm trying to backport an updated lm85 driver on RHEL5 to provide 
> support for an EMC6D103 hardware monitoring chip.
> 
> Backporting from more recent kernels fails around the patch "Convert to 
> a new-style i2c driver" from 2008-10-17 on RHEL5 and I'm unsure how to 
> fix that.
> 
> Then I remembered Jean's stand alone drivers:
> 
> http://khali.linux-fr.org/devel/lm-sensors/drivers/lm85/
> 
> which appear to potentially support RHEL5 but unfortunately I'm still 
> experiencing problems compiling that code on RHEL5 (see below).
> 
> I'd really appreciate any assistance getting a more updated driver 
> available for RHEL5.

We'll try to get you there, no problem.

My stand-alone driver above has two issues. Firstly it is over two and
a half years old, so it is missing a lot of the recent development.
Thankfully these seem to be mostly cleanups. I should be able to update
the driver to match what is in kernel 3.11.

Secondly, it was only tested down to kernel version 2.6.32. Anything
older than that may break, and that's what is happening to you I
presume. Please let me know which exact kernel version you have to use
and I'll try to add the missing compatibility glue.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
