From: Len Brown <lenb@kernel.org>
Date: Tue, 28 Jul 2009 01:25:54 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] acpi_power_meter: hwmon driver for
Message-Id: <alpine.LFD.2.00.0907272124110.4445@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090725004322.20709.96804.stgit@elm3a70.beaverton.ibm.com>
 <20090725004335.20709.52288.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20090725004335.20709.52288.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

Hi Darrick,
On the system you are planning to run this on...
Are the power meters in the processor, or elsewhere?

If they are the ones in the processor, I'd rather that
Linux use a native model-specific driver to access those
registers and not use ACPI.

thanks,
Len Brown, Intel Open Source Technology Center

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
