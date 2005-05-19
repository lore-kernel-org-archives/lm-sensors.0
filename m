From: marcelo.tosatti@cyclades.com (Marcelo Tosatti)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: Linux 2.4.28 breaks lm_sensors
Message-Id: <20041121210111.GC23689@logos.cnet>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041120114141.3e0f5f47.khali@linux-fr.org>
In-Reply-To: <20041120114141.3e0f5f47.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>
Cc: Len Brown <len.brown@intel.com>, David Shaohua <shaohua.li@intel.com>, LKML <linux-kernel@vger.kernel.org>

Hi,

On Sat, Nov 20, 2004 at 11:41:41AM +0100, Jean Delvare wrote:
> Hi Marcelo, hi all,
> 
> We have been having reports that recent changes in the ACPI subsystem of
> the Linux 2.4 kernel are breaking lm_sensors on a fairly large number of
> systems. In particular, 2.4.28 is affected.
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket61
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket19
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket20
> 
> I did not report earlier because I thought the problem would be fixed by
> the ACPI folks before 2.4.28 would be released. Unfortunately it wasn't.

Ouch :(

> The problem is already known, was reported for 2.6 kernels 4 months ago
> and fixed there by David Shaohua. See this kernel bug report for the
> detail of symptoms and the solution:
> http://bugzilla.kernel.org/show_bug.cgi?id049
> 
> Applying the proposed patch to a 2.4.28 kernel make lm_sensors work
> again on affected systems, while not causing trouble to unaffected ones
> as far as I can tell.
> 
> Len, David, any reason not to apply the same fix to the 2.4 tree?

It looks like this should come through the acpi BK tree. Len, David?
