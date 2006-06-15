From: david.c.hubbard@gmail.com (David Hubbard)
Date: Thu, 15 Jun 2006 14:55:12 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <4dfa50520606150755r5084e395m2cb6f2f06753d34f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

+		for (i = 0; i < 4; i++) {
+			int pwmcfg, tolerance;
+			if (i != 1) {
+				pwmcfg = w83627ehf_read_value(client,
+						W83627EHF_REG_PWM_ENABLE[i]);

Can we put a comment here explaining the if condition? Suggestion:
/* W83627EHF_REG_PWM_ENABLE[1] = W83627EHF_REG_PWM_ENABLE[0]. The
values of pwmcfg and tolerance are not changed from i=0 to i=1 */


+store_pwm_enable(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83627ehf_data *data = i2c_get_clientdata(client);
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 3);
+	u16 reg;
+
+	if (!val)	/* pwm off not supported */
+		return -EINVAL;

We return -EINVAL in store_pwm_mode() if val is invalid. We shouldn't
use SENSORS_LIMIT here either. Can we return -EINVAL instead? Also,
these are the PWM modes the driver currently supports:
1 - manual PWM control
2 - thermal cruise

These PWM modes will soon be supported:
3 - RPM cruise
4 - Smart Fan III

So should val be limited to 1, 2, 3, or should val be limited to 1, 2?

Suggested change:
	u32 val = simple_strtoul(buf, NULL, 10);
	if (!val || val > 3)	/* mode 0 (disabled) not supported */
		return -EINVAL;

I'm testing it on my system right now. I will let you know if there
are problems.

Thanks,
David

On 6/14/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
> Hi all,
>
> Here is some updated version for the test. It fixes the stuff Jean found. I want
> to read it once again I'm not falling asleep while reading it. It works for me
> and I think it should work for you all too.

