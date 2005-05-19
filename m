From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc4 14/15]
Message-Id: <253818670505171959f5cecb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051703463587a54@mail.gmail.com>
In-Reply-To: <2538186705051703463587a54@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Oops..I caught this simple typo while compile testing the adm1026
patch with everything, but it looks like I forgot to update the patch,
here is the corrected version (just adding the missing '=' ):

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

Yani

On 5/17/05, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> This patch creates a new header with a potential standard i2c sensor
> attribute type (which simply includes an int representing the sensor
> number/index) and the associated macros, SENSOR_DEVICE_ATTR to define
> a static attribute and to_sensor_dev_attr to get a
> sensor_device_attribute reference from an embedded device_attribute
> reference.
> 
> Please see the next patch to see how these can be used.
> 
> Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
> 
> ---
> 
> 
>
-------------- next part --------------
 i2c-sysfs.h |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-i2c.diff
Type: text/x-patch
Size: 1767 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050517/c69e957d/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-i2c.bin
-------------- next part --------------
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
