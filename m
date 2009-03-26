From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Mar 2009 09:43:56 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-add-hds.patch
Message-Id: <20090326104356.4d1b1b83@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49786E06.1050705@hhs.nl>
In-Reply-To: <49786E06.1050705@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 22 Jan 2009 14:00:54 +0100, Hans de Goede wrote:
> Hi,
> 
> This patch adds support for the Hades to the FSC hwmon driver, this patch
> is to be applied on top of the one adding support for the Syleus.
> Note this patch is untested but it should be ok as the Hades is identical to
> the Heimdall except for the voltage register addresses
> (and I've asked FSC to test it).
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks alright to me, except for the missing update to
drivers/hwmon/Kconfig (ditto for the Syleus patch.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
