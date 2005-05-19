From: len.brown@intel.com (Len Brown)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: [BKPATCH] ACPI for 2.4
Message-Id: <1101191641.20006.454.camel@d845pe>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, LM Sensors <sensors@stimpy.netroedge.com>

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/24-latest-release

	This should address the "Linux 2.4.28 breaks lm_sensors"
	issue.  It is an exact bkimport from 2.6.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/24-latest-release/acpi-20040326-24-latest-release.diff.gz

This will update the following files:

 drivers/acpi/motherboard.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/11/22 1.1458.1.8)
   [ACPI] BIOS workaround allowing devices to use reserved IO ports
   Author: David Shaohua Li
   http://bugzilla.kernel.org/show_bug.cgi?id049



