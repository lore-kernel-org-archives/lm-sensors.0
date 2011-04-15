From: Darren Hart <dvhart@linux.intel.com>
Date: Fri, 15 Apr 2011 05:04:58 +0000
Subject: Re: [lm-sensors] w83795 fan control not working
Message-Id: <4DA7D1FA.20602@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110407150007.51dd1c06@endymion.delvare>
In-Reply-To: <20110407150007.51dd1c06@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/08/2011 05:46 AM, Jean Delvare wrote:
> The bottom line is that using the W83795 driver in a multi-master I2C
> setup (and I strongly suspect this is what Supermicro did) is a bad
> hardware design mistake. This hardware monitoring device wasn't
> designed with this use case in mind.

Super Micro responded:
"
        Do you have an extra fan blowing air toward the northbridge
heatsink. The temperature on northbridage heatsink must less than 75
degree. Adding an extra fan which will help solve your issue.
        We are not recommend user using lmsensor on X8DTL-IF. It will
cause system crash due to lmsensor and our IPMI program getting
information from BIOS at the same time and collide on each other. It
won't happen immediately but definitely will happen in random time.
"

It's a bit broken, but it sounds like they are confirming you theory.

As an experiment I removed the CPU2 fan and pointed it directly at the
Intel 5520 chipset (technically not a Northbridge as it turns out...
just ignore that intel.com in my email address, it means nothing ;-) and
while I haven't been able to measure the temp1 reading from the w83795
driver since my return, the fans no longer ramp up to 4k rpm and the
chip is cool to the touch.

I'm seeking the recommended solution from Super Micro, failing that,
I'll have to resort to chassis modding.... I thought that was for the
overclocking-acrylic-window-neon-lights crowd.... sigh.

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
