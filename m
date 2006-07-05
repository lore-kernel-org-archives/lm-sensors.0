From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 05 Jul 2006 20:11:46 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44AC1D02.2070303@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sunil Kumar wrote:
> Hans,
> 
> A related question: gkrellm2 (2.2.9) refuses to see my sensors as reported
> by abit driver, but its able to see bogus sensors reported by w83627hf if I
> modprobe it.  sensors and ksensors, both see the values correctly.
> 
> Why would gkrellm not see them? Is there a configuration setting that
> gkrellm reads which works for w83627hf but not for abituguru.
> 

I became inspired by your mail and have taken a look. I haven't done (I
haven't even started) a full libsensors implementation yet, but if you
compile gkrellm with the attached patch it should work fine with the
uguru and other new drivers which properly represent themselves as
platform devices.

Regards,

Hans


-------------- next part --------------
A non-text attachment was scrubbed...
Name: gkrellm-2.2.9-hwmon.patch
Type: text/x-patch
Size: 1444 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060705/5db6049d/attachment.bin 
