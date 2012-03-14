From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 14 Mar 2012 15:46:28 +0000
Subject: Re: [lm-sensors] ERROR: could not insert 'w83627ehf': Device or resource busy
Message-Id: <1331739988.32717.23.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F60A0AA.2050107@gmail.com>
In-Reply-To: <4F60A0AA.2050107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-03-14 at 11:36 -0400, David Kremer wrote:
> I forgot to mention that your diagnostic is excellent.
> 
> The three last lines from dmesg are here :
> 
> [30023.283848] w83627ehf: Found NCT6776F chip at 0x290
> [30023.283867] ACPI: resource w83627ehf [io  0x0295-0x0296] conflicts 
> with ACPI region HWRE [io 0x290-0x299]
> [30023.283869] ACPI: If an ACPI driver is available for this device, you 
> should use it instead of the native driver

Not really ... we see this about once per week ;).

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
