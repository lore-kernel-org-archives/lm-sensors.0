From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 09 Mar 2007 19:44:20 +0000
Subject: [lm-sensors] libsensors patch to gkrellm - a report
Message-Id: <45F1B914.6050706@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Rudolf Marek wrote:
> Hello,
> 
> I just compiled latest gkrellm with libsensors and noticed following:
> 

Sorry for the very late reply.

> 1) for k8temp driver it displays temp1-temp4 even when I have only 
> temp1_input
>    (prehaps there must be similar test as it is in "sensors" program)
> 

Actually, the problem is in libsensors / sensors.conf . gkrellm-2.2.10 
(which has my patch integrated) checks
sensors_get_ignored() and only shows non ignored sensors. So there are 2 
errors at the other side here:
1) You should put an ignore tempX for those 3 temps in /etc/sensors.conf
2) since only temp1_input shows up under sysfs, libsensors should return
    0 from sensors_get_ignored() for the other sensors regardless of
    of /etc/sensors.conf, as it simply isn't there

I believe that 2) and then 1) are the right solution here, I've written 
a patch which does a testread of the sensor (attached) and only adds it 
to the list of sensors if the testread succeeds, which fixes this with 
k8temp. But that is not a good idea IMHO, then you're using dynamic data 
for something static as the list of sensors in gkrellm is created upon 
startup and from then on its static. The trial read is dynamic / not 
reliable as sometimes one read can fail for one reason or the other and 
the next read will succeed.

Bill please do NOT apply this patch its for testing only. Rudolf, can 
you give the patch a run, it should fix your k8temp problem and read on ...

> 2) For some reason I have fan1 fan2 fan3 fan5 fan4 in the rows. Maybe 
> because I dont have fan4 (not enabled by driver w83627ehf)
> 

A bit strange this, yes. Probably again you haven't told libsensors to 
ignore fan4 for this chip in /etc/sensors.conf, neither has libsensors 
come up with the idea todo this itself. Can you try that and / or the 
attached patch to see if that helps?

Rudolf + Jean, would it be a good idea to write a patch for libsensors 
to make it automaticly set features not found in sysfs to ignore?

Regards,

Hans
-------------- next part --------------
A non-text attachment was scrubbed...
Name: gkrellm-2.2.10-test-read.patch
Type: text/x-patch
Size: 892 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070309/c46cc062/attachment.bin 
