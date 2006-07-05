From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 05 Jul 2006 17:41:10 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44ABF9B6.3050005@hhs.nl>
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

Known problem with gkrellm and newer drivers for ISA chips which
correctly report them self as platform drivers rather then fake I2C drivers.

I've contacted the gkrellm author on this and he is willing to take a
patch both for this issue and for the more general issue of not using
libsensors. Know all that I (any volunteers?) have todo is writ
libsensors support for gkrellm.

Regards,

Hans


