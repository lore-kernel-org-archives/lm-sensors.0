From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 Jan 2014 02:00:15 +0000
Subject: Re: [lm-sensors] [GIT PULL] Thermal management updates for v3.14-rc1
Message-Id: <CA+55aFyPGdJEP3fpZxVqQNp_BtJ3vqqq_0xst_3H8Pf9QV627Q@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390534568.12771.58.camel@rzhang1-mobl4>
In-Reply-To: <1390534568.12771.58.camel@rzhang1-mobl4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-devicetree <devicetree@vger.kernel.org>, linux-lmsensor <lm-sensors@lm-sensors.org>

On Thu, Jan 23, 2014 at 7:36 PM, Zhang Rui <rui.zhang@intel.com> wrote:
>
> Please pull from the git repository at
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next
>
> to receive Thermal management updates for v3.14-rc1

This annoys me _enormously_:

  CONFIG_ACPI_INT3403_THERMAL:

  This driver uses ACPI INT3403 device objects. If present, it will
  register each INT3403 thermal sensor as a thermal zone.

This is the "help" text for the new ACPI thermal driver.

WTF?

Really, whoever wrote that "help" text wasn't thinking of helping
users. What the f*ck is an INT3403 device object? Is is common? Where?
Is it a standard? Is it something normal people should expect?

              Linus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
