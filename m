From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: Linux 2.4.28 breaks lm_sensors
Message-Id: <20041120114141.3e0f5f47.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Len Brown <len.brown@intel.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, David Shaohua <shaohua.li@intel.com>, LKML <linux-kernel@vger.kernel.org>

Hi Marcelo, hi all,

We have been having reports that recent changes in the ACPI subsystem of
the Linux 2.4 kernel are breaking lm_sensors on a fairly large number of
systems. In particular, 2.4.28 is affected.
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket61
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket19
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket20

I did not report earlier because I thought the problem would be fixed by
the ACPI folks before 2.4.28 would be released. Unfortunately it wasn't.

The problem is already known, was reported for 2.6 kernels 4 months ago
and fixed there by David Shaohua. See this kernel bug report for the
detail of symptoms and the solution:
http://bugzilla.kernel.org/show_bug.cgi?id049

Applying the proposed patch to a 2.4.28 kernel make lm_sensors work
again on affected systems, while not causing trouble to unaffected ones
as far as I can tell.

Len, David, any reason not to apply the same fix to the 2.4 tree?

Thanks,

-- 
Jean Delvare
http://khali.linux-fr.org/
