From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 03 Aug 2009 20:58:12 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] acpi_power_meter: hwmon driver for
Message-Id: <20090803205812.GC14694@plum>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090725004322.20709.96804.stgit@elm3a70.beaverton.ibm.com> <20090725004335.20709.52288.stgit@elm3a70.beaverton.ibm.com> <alpine.LFD.2.00.0907272124110.4445@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0907272124110.4445@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

On Mon, Jul 27, 2009 at 09:25:54PM -0400, Len Brown wrote:
> Hi Darrick,
> On the system you are planning to run this on...
> Are the power meters in the processor, or elsewhere?
> 
> If they are the ones in the processor, I'd rather that
> Linux use a native model-specific driver to access those
> registers and not use ACPI.

They're not in the processor.  Right now we're simulating the meters in kvm
until we get real hardware, though it could be a mechanism to report per-VM
power use.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
