From: Lucas Stach <dev@lynxeye.de>
Date: Tue, 13 Sep 2011 21:09:50 +0000
Subject: [lm-sensors] General API and documentation discussion
Message-Id: <1315948191.2018.20.camel@tellur>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

weeks ago I proposed a patch to introduce a new hwmon-core interface to
have the sysfs handling centralised and getting a stable in-kernel API
for the hwmon drivers. This should also lead to resolving the now
unclear situation with regard to hwmon/thermal driver cooperation, but
more to this at a later time as it's not the point here.

This old patch I proposed was kind of hacky and I didn't receive a lot
of feedback, but I got some ideas to improve the code. I'm now in the
process of reworking my patch to be more maintainable.

Along the way I noticed some mismatches between the API as presented by
libsensors and the documentation in kernel. One example is the sysfs
entry "fan_max" which is mentioned in the kernel documentation, but is
not seen in the libsensors fan_matches subfeatures table. I think a
hwmon-core with all the sysfs handling is a great place to stabilize the
API between kernel and userspace and to do so I want to know who I
should trust, kernel doc or libsensors code?

Could we please sort this out whether the kernel doc is incorrect and
does not reflect actual interface or if sensors code needs some
additions to reflect API exposed by the kernel? I would really like to
help here and I'm willing to spend some time with stabilizing interface
and documentation, but as a newcomer it is hard to make a sense out of
all this conflicting information. I think a stable API both in and out
of kernel is beneficial to all hwmon drivers and systems interfacing
with them.

On a side note I could not find any API entries in libsensors for
handling trip points which are mentioned in the kernel doc, but I think
this is another issue as we really should handle trip point support as a
cooperation of hwmon and a thermal driver.

Best regards,
--Lucas


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
