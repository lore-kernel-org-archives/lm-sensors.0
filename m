From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 02 Jun 2009 09:12:48 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/1] hwmon: added support for the
Message-Id: <20090602111248.32058e9b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090602081426.6131bdc5@frequentis.com>
In-Reply-To: <20090602081426.6131bdc5@frequentis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2 Jun 2009 08:14:26 +0200, Christian Engelmayer wrote:
> From: Christian Engelmayer <christian.engelmayer@frequentis.com>
> 
> Exported the alarm stati provided by the MAX6650/MAX6651 fan-speed regulator
> and monitor chips via sysfs.
> 
> Signed-off-by: Christian Engelmayer <christian.engelmayer@frequentis.com>
> ---
> Tested with the MAX6651 chip. This obsoletes the previously proposed patch
> 'support for the max6650 GPIO and alarm features' after discussion on sane
> gpio handling.
> 
> Revised after remarks by Hans de Goede. Changed the alarm attributes to sensor
> device attributes thus eliminating the need for pointer comparison in show
> function get_alarm(). Left the alarm behaviour unchanged. In case the sysfs
> interface does not prefer 'real time' over 'latched' alarms I prefer to keep
> the style used by the device.
> 
> Incorporated additional remarks by Hans de Goede. Changed a temporary variable
> from 'u8' to 'int'. Changed the order of alarms within the code from MSB first
> to LSB first as occuring within the registers.
> 
> Incorporated additional remarks by Jean Delvare. Using attr->index for
> directly passing alarm masks. Resending the patch as it was previously
> corrupted by the mail client.
> 
> Incorporated additional remarks on coding style by Jean Delvare. Removed an
> unused preprocessor definition. Reduced comparison operations within an
> infrequently used function.

Applied, thanks! Patch is queued for 2.6.31.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
