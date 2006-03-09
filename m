From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 09 Mar 2006 23:16:18 +0000
Subject: [lm-sensors] Memory usage of sysfs files
Message-Id: <4410B742.6070400@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603082311220.3051@Laila>
In-Reply-To: <Pine.LNX.4.63.0603082311220.3051@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've given this some more thought and I've decided against implementing 
my way for a couple of other drivers to be able to really measure the 
difference. I believe we agree my way is somewhat more efficient, but 
that the differences aren't big enough to swing the scales to my way 
only on the efficiency reasons.

Instead of spending more time coding test-cases I'd rather just see a 
decision soon and (if nescessarry) I'll update the uguru driver to match .

There are 2 arguments I would still like to make in favor of my way though:

1) you initially did it this way too for atleast one driver. Remember, 
usually your first hunch is a good one.

2) I've also written support for libsensors and the sensors application 
when doing things my way and that fits nicely. I'm afraid that the many 
files way will be a problem with the current libsensors. I don't want to 
now wath the lib and the progs chips.* will look like. 100+ additional 
entries for the uguru alone! And I don't think the chip specific reading 
and report code in the sensors application will get any pretter too.

Now I know that libsensors is destined to be replaced, but it will be 
around for a while I think.

I've attached a patch adding support for the uguru to both lib and prog 
with alarm reporting to give you an idea how this will look like when 
doing things my way. Please note that this patch needs updating for
2.10 / cvs and thus won't apply.

Regards,

Hans
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-2.9.1-uguru.patch
Type: text/x-patch
Size: 15184 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060310/73c52b90/lm_sensors-2.9.1-uguru-0001.bin
