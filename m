From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Wed, 02 Sep 2009 18:33:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1031) Add sysfs files
Message-Id: <20090902183322.GF2328@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 30, 2009 at 11:39:18AM -0700, Ira Snyder wrote:
> The ADM1030/ADM1031 chips have temperature offset registers, for both the
> local and remote temperature sensors. Following the example set forth in
> the LM90/ADM1032 driver, expose the offset registers to userspace.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> 
> I have tested this with an adm1031 chip, and I see the offsets as
> expected. I do not have any other compatible chips to test with, however
> I read the adm1030 datasheet, and everything should work fine.
> 
> On the adm1031, the datasheet claims the offset registers can be used to
> add/subtract 15 degC from the temperature reading. I have found that it
> is actually possible to add 15 degC and subtract 16 degC. Following the
> data sheet, I clamped the value to +- 15 degC, just in case other chips
> are not compatible.
> 
>  drivers/hwmon/adm1031.c |   40 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
> 

Any comments on this? Can it be merged for 2.6.32?

Thanks,
Ira

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
