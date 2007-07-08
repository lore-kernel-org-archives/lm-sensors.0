From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Jul 2007 17:33:57 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fscher-individual-alarm-files-v3.patch
Message-Id: <20070708193357.2040251d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <468A3045.1010307@hhs.nl>
In-Reply-To: <468A3045.1010307@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 06 Jul 2007 17:17:41 +0200, Hans de Goede wrote:
> This is version 3 (non incremental) of the patch adding individual alarm and
> fault files to the fscher driver. This version automatically clears alarms
> when the condition for them is gone, and adds tempX_max sysfs atrributes.

Hmm, your patch actually does 4 different things:
* Add the individual alarm files.
* Add the tempX_max sysfs atrributes.
* Add (disabled) auto fan speed control trip points.
* Use arrays to reference register addresses.

That's a bit too much for a single patch. For easier review and faster
acceptance, you should split it into logical steps, each doing only one
thing. See what I did recently for the w83627ehf and lm85 drivers. 

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
