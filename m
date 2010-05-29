From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 29 May 2010 19:40:35 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] hwmon: (ltc4245) expose all GPIO
Message-Id: <20100529214035.23ce0a59@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1274975804-13254-1-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1274975804-13254-1-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

On Thu, 27 May 2010 08:56:44 -0700, Ira W. Snyder wrote:
> Add support for exposing all GPIO pins as analog voltages. Though this is
> not an ideal use of the chip, some hardware engineers may decide that the
> LTC4245 meets their design requirements when studying the datasheet.
> 
> The GPIO pins are sampled in round-robin fashion, meaning that a slow
> reader will see stale data. A userspace application can detect this,
> because it will get -EAGAIN when reading from a sysfs file which contains
> stale data.
> 
> Users can choose to use this feature on a per-chip basis by using either
> platform data or the OF device tree (where applicable).
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
