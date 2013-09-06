From: Phil Perry <phil@elrepo.org>
Date: Fri, 06 Sep 2013 20:55:56 +0000
Subject: Re: [lm-sensors] Backporting updated lm85 on RHEL5
Message-Id: <522A415C.2080305@elrepo.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5229DE5D.7060104@elrepo.org>
In-Reply-To: <5229DE5D.7060104@elrepo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/09/13 16:03, Jean Delvare wrote:
> Hi Phil,
>
> On Fri, 06 Sep 2013 14:53:33 +0100, Phil Perry wrote:
>> I'm trying to backport an updated lm85 driver on RHEL5 to provide
>> support for an EMC6D103 hardware monitoring chip.
>>
>> Backporting from more recent kernels fails around the patch "Convert to
>> a new-style i2c driver" from 2008-10-17 on RHEL5 and I'm unsure how to
>> fix that.
>>
>> Then I remembered Jean's stand alone drivers:
>>
>> http://khali.linux-fr.org/devel/lm-sensors/drivers/lm85/
>>
>> which appear to potentially support RHEL5 but unfortunately I'm still
>> experiencing problems compiling that code on RHEL5 (see below).
>>
>> I'd really appreciate any assistance getting a more updated driver
>> available for RHEL5.
>
> We'll try to get you there, no problem.
>
> My stand-alone driver above has two issues. Firstly it is over two and
> a half years old, so it is missing a lot of the recent development.
> Thankfully these seem to be mostly cleanups. I should be able to update
> the driver to match what is in kernel 3.11.
>
> Secondly, it was only tested down to kernel version 2.6.32. Anything
> older than that may break, and that's what is happening to you I
> presume. Please let me know which exact kernel version you have to use
> and I'll try to add the missing compatibility glue.
>

Many thanks Jean.

I'm trying to backport to RHEL5. The original RHEL5 kernel was based on 
kernel-2.6.18, but as you are probably aware Red Hat backport all sorts 
of functionality into their kernel over the 10 year lifetime of the 
product so it's not really possible to refer to the RHEL kernel as being 
of a particular version number. As far as I can tell, the kernel in RHEL 
5.5 received a hwmon update and the complete hwmon tree was pulled in 
(backported) from around kernel-2.6.26. I believe this was the last 
major update of hwmon stuff in the RHEL5 kernel, so it's probably best 
to assume this as the base we are working from.

The main issue I have when pulling the lm85 code from longterm kernels 
3.0.x or 3.2.x, or the more recent 3.10.10 kernel and trying to compile 
against the RHEL kernel is caused by the update to a new-style i2c 
driver [Patch 2008-10-17 Convert to a new-style i2c driver]. I can 
probably fix other issues but I don't know how best to work around/fix 
that. I assume the RHEL kernel does not have some updated i2c 
functionality hence that particular patch causing issues. Your 
standalone driver code was giving errors around the same section of code.

My initial thought was to try reverting that patch and see if I can then 
fix other remaining build issues by backporting the relevant 
functionality. Does this sound viable or a non-starter?

If you'd like to take a look for yourself I can probably arrange remote 
access to our RHEL build systems for you, or I'm happy to copy and paste 
build log errors here so you can see where it's failing.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
