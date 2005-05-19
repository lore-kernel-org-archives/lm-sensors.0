From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: [PATCH 2.6] add alternate VCORE calculations for w83627thf and
Message-Id: <40D496CF.5060309@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040606025430.GC10118@jupiter.solarsys.private>
In-Reply-To: <20040606025430.GC10118@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

agreed this is a good idea, and that CPU type absolutely determines VRM type.
The long-term goal should be to do it in-kernel and remove /proc or /sys/.../vrm
files for the various drivers.

Definitive CPU/VRM table surely a challenge but can be built up over time
or just take good guesses.

mds



Jean Delvare wrote:
>>>You seem to suggest that each CPU type can only work with one VRM
>>>version. Are you sure?
>>
>>Well, I wasn't sure at first. But later, I looked at some Intel docs
>>which say that the VID signals come right from the processor package
>>itself (1). So now I'm sure.
> 
> 
> A CPU vs VRM version table would be welcome then.
> 
> 
>>>The CPU type information is also available in kernel-space, maybe
>>>even more easily (no parsing required), and I believe that setting
>>>the VRM from the CPU type belongs to the driver (once, at init
>>>time). I don't see how you are going to do that in "sensors".
>>
>>Actually, "sensors -s".  It wouldn't be hard - I mean, it already sets
>>the VRM based on /etc/sensors.conf.
> 
> 
> My point isn't about how to do it, I can imagine that you'll parse
> /proc/cpuinfo and issue the correct libsensors action.
> 
> My point is about when you will do it. So far, only "set" lines of
> sensors.conf do trigger a write action, and in a very generic way. You
> would have to do something very specific for vrm, possibly conflicting
> with sensors.conf set lines. This is why I'm skeptical about your
> proposal.
> 
> 
>>But you're probably right that it belongs in the driver; perhaps
>>another shared function of the i2c-sensors module.
> 
> 
> It would even belong to i2c-vid.h (in which case we may need to create
> i2c-vid.c and build the i2c_sensor module from i2c-vid.c and
> i2c_sensor.c).
> 
> 
>>Does anyone know how to read CPU id info from kernel space?
> 
> 
> I have no clue and not much time to check right now. Grepping the
> sources for "cpuid" could help. Or you may try to locate where
> /proc/cpuinfo gets it from.
> 
> One may wonder if the change would allow us to get rid of the vrm sysfs
> file entirely. This would be great, but I'm not 100% sure. There are a
> few corner cases I can think of that may require our attention.
> 
> 1* Evaluation boards (or more generaly, cases where the chip doesn't
> belong to the monitoring system). This is uncommon and people doing this
> are expected to know their stuff. VID readings are for comfort, you can
> live without them, especially in experimental context.
> 
> 2* Multi-cpu systems. I'd expect such systems to use a single family of
> chips, and so a single VRM version for all CPUs.
> 
> All in all I'm quite confident that we could get rid of the additional
> interface (if and only if you hypothesis that we can know the VRM
> version from the CPUID is correct). But comments are welcome.
> 
> Thanks.
> 
