From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 02 Jan 2006 10:01:54 +0000
Subject: [lm-sensors] hwmon-sensor-attr-array-2.patch
Message-Id: <20060102110154.258f920d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43B306FB.9040301@gmail.com>
In-Reply-To: <43B306FB.9040301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

Jim Cromie wrote:
> This patch refactors SENSOR_DEVICE_ATTR_2 macro, following pattern set by
> SENSOR_ATTR.  First it creates a new macro SENSOR_ATTR_2() which expands 
> to an initialization expression, then it uses that in SENSOR_DEVICE_ATTR_2, 
> which declares and initializes a struct sensor_device_attribute_2.

Looks OK to me, consider it applied. I won't push it until I am also
able to push a driver which uses it though (but that should happen soon
enough.)

We should probably think of this part of the code and see what can be
done to improve it. struct sensor_device_attribute is currently
*larger* than struct sensor_device_attribute_2, which makes one wonder
if we shouldn't use sensor_device_attribute_2 everywhere even when we
don't actually need the second parameter. Also, the field names "index"
and "nr" are too generic IMHO and this might get confusing in the long
run. I was thinking of "channel" instead of "index". No idea for "nr"
though. Or maybe we are generic on purpose for reusability, but then
"index" and "nr" should be "nr0" and "nr1" or something equally
symmetrical. Thoughts?

Thanks,
-- 
Jean Delvare

