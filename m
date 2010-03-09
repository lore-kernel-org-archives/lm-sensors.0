From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Mar 2010 08:45:05 +0000
Subject: Re: [lm-sensors] Upgraded my old Debian box's Kernel from 2.6.30 to
Message-Id: <20100309094505.58e5549b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100305222015.GR11436@alpha.zimage.com>
In-Reply-To: <20100305222015.GR11436@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Luca,

On Mon, 8 Mar 2010 22:34:49 +0100, Luca Tettamanti wrote:
> Would it be totally horrible to use acpi_ex_{enter,exit}_interpreter
> inside hwmon code to serialize execution?

I would be totally in favor of it if it solves actual problems (or any
functionally equivalent solution). I guess it can't be bullet-proof, as
both the native driver and ACPI can assume state conservation between
device accesses, which is no longer guaranteed with someone else
accessing the device, but it should indeed help solve at least the most
critical problems.

Can you please prepare a patch and send it to both the ACPI folks and
the lm-sensors list?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
