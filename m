From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 11 Nov 2008 09:13:17 +0000
Subject: [lm-sensors] PATCH: add watchdog support to the fschmd driver [0/2]
Message-Id: <49194CAD.6000408@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean (and all),

Here is a new version of the fschmd watchdog patch, intended for 2.6.29, 
learning from my just too late experience with my 2.6.28 patches I'm trying to 
get this one queued in plenty og time for 2.6.29, Jean can you re-review it please.

All issues from the review of the previous version have either been commented 
upon why I didn't fix them (see reply to the review) or have been fixed.

In addition I've added reference counting for the data-structure, as it can 
still be used by the watchdog driver after the i2c-client has been removed 
(when some process still has /dev/watchdogX open)

I've split this into 2 patches, 1 with some small cleanups and 1 with the 
actual new watchdog code.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
