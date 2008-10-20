From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Oct 2008 13:43:27 +0000
Subject: Re: [lm-sensors] PATCH: f71882fg-sensor_attr2.patch [1/2]
Message-Id: <20081020154327.4c7acbc0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FC4F60.8030003@redhat.com>
In-Reply-To: <48FC4F60.8030003@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 20 Oct 2008 11:28:38 +0200, Hans de Goede wrote:
> From: Mark van Doesburg <mark.vandoesburg@hetnet.nl>
> 
> Hi Jean (and all),
> 
> Convert f71882fg driver from SENSOR_ATTR to SENSOR_ATTR2 use, this is a
> preparation patch for adding pwm support, which is broken out to make what
> changes really in the pwm support patch clear.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Note: Signed-off-by supersedes Reviewed-by.

> CC: Mark van Doesburg <mark.vandoesburg@hetnet.nl>
> 
> Regards,

Applied, thanks.

For future patches, please come up with better subjects. For this
one I've used:

hwmon: (f71882fg) Use sensor_device_attribute_2

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
