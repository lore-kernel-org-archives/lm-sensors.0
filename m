From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 23 Feb 2015 19:52:47 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Add support for additional IDT temperature sensors
Message-Id: <20150223205247.5f645450@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423769172-13519-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1423769172-13519-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Sorry for the late review.

On Thu, 12 Feb 2015 11:26:12 -0800, Guenter Roeck wrote:
> TS3000GB0 has a new device ID (0x2913). Since IDT's datasheets suggest
> that the upper 8 bit of the device ID reflect the chip ID and the lower
> 8 bit reflect the version number, modify the code to accept all chips
> with ID 0x29xx.

You did that for all other IDT chips as well. While this is in
accordance with the datasheets, this might lead to some false
positives, as the driver probes 8 popular I2C addressed and the
detection code doesn't check for that many bits anymore.

That being said I don't have a strong feeling about it. We can leave it
this way for now and revisit it later if false positives are actually
reported.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

What I would like though is that the detection code in sensors-detect
is updated to be in line with what the driver does now. It gets
confusing if sensors-detect finds a chip which the driver rejects or
misses a chip which the driver would support.

> Also add support for TS3001 and TSE2004.

That needs to be done in sensors-detect as well.

All these chips could be added to the Devices page in the wiki too.

> Some of the datasheets for older chips are no longer available from
> the IDT web site, so replace explicit links in the documentation with
> a generic note.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/jc42 |  8 +++-----
>  drivers/hwmon/Kconfig    |  2 +-
>  drivers/hwmon/jc42.c     | 16 ++++++++++------
>  3 files changed, 14 insertions(+), 12 deletions(-)
> (...)

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
