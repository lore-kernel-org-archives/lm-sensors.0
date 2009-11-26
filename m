From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 26 Nov 2009 04:10:47 +0000
Subject: Re: [lm-sensors] [PATCH v2] [loongson] yeeloong2f: add platform
Message-Id: <20091126041047.GC23244@core.coreip.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <9ef5a0038ec5e9b584be8c960693c434a323620a.1258803311.git.wuzhangjin@gmail.com> <9ef5a0038ec5e9b584be8c960693c434a323620a.1258803311.git.wuzhangjin@gmail.com>
In-Reply-To: <9ef5a0038ec5e9b584be8c960693c434a323620a.1258803311.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Richard Purdie <rpurdie@rpsys.net>, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-laptop@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, sfr@linuxcare.com, linux-kernel@vger.kernel.org

Hi Wu,

Overall impression - several drivers crammed into one module, I wonder
if it could be split somewhat. Some input-related concerns below.

On Sat, Nov 21, 2009 at 08:08:40PM +0800, Wu Zhangjin wrote:
> +
> +/* hotkey input subdriver */
> +
> +static struct input_dev *yeeloong_hotkey_dev;
> +static int event, status;
> +
> +struct key_entry {
> +	char type;		/* See KE_* below */
> +	int event;		/* event from SCI */
> +	u16 keycode;		/* KEY_* or SW_* */
> +};
> +
> +enum { KE_KEY, KE_SW, KE_END };

I am going to post the sparse keymap library shortly, this driver could
use it too...

> +
> +static struct key_entry yeeloong_keymap[] = {
> +	{KE_SW, EVENT_LID, SW_LID},
> +	/* SW_VIDEOOUT_INSERT? not included in hald-addon-input! */
> +	{KE_KEY, EVENT_CRT_DETECT, KEY_PROG1},
> +	/* Seems battery subdriver should report it */
> +	{KE_KEY, EVENT_OVERTEMP, KEY_PROG2},

Does not seem to be an input event?

> +	/*{KE_KEY, EVENT_AC_BAT, KEY_BATTERY},*/
> +	{KE_KEY, EVENT_CAMERA, KEY_CAMERA},	/* Fn + ESC */
> +	{KE_KEY, EVENT_SLEEP, KEY_SLEEP},	/* Fn + F1 */
> +	/* Seems not clear? not included in hald-addon-input! */
> +	{KE_KEY, EVENT_BLACK_SCREEN, KEY_PROG3},	/* Fn + F2 */

Do you mean "lock screen"?

> +	{KE_KEY, EVENT_DISPLAY_TOGGLE, KEY_SWITCHVIDEOMODE},	/* Fn + F3 */
> +	{KE_KEY, EVENT_AUDIO_MUTE, KEY_MUTE},	/* Fn + F4 */
> +	{KE_KEY, EVENT_WLAN, KEY_WLAN},	/* Fn + F5 */
> +	{KE_KEY, EVENT_DISPLAY_BRIGHTNESS, KEY_BRIGHTNESSUP},	/* Fn + up */
> +	{KE_KEY, EVENT_DISPLAY_BRIGHTNESS, KEY_BRIGHTNESSDOWN},	/* Fn + down */
> +	{KE_KEY, EVENT_AUDIO_VOLUME, KEY_VOLUMEUP},	/* Fn + right */
> +	{KE_KEY, EVENT_AUDIO_VOLUME, KEY_VOLUMEDOWN},	/* Fn + left */
> +	{KE_END, 0}
> +};
> +

...

> +
> +static ssize_t
> +ignore_store(struct device *dev,
> +	     struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	return count;
> +}
> +
> +static ssize_t
> +show_hotkeystate(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d %d\n", event, status);
> +}
> +
> +static DEVICE_ATTR(state, 0444, show_hotkeystate, ignore_store);

Why do you need "ignore_store" and not just use NULL? Also why do you
need to export the state at all?

> +
> +static struct attribute *hotkey_attributes[] = {
> +	&dev_attr_state.attr,
> +	NULL
> +};
> +
> +static struct attribute_group hotkey_attribute_group = {
> +	.attrs = hotkey_attributes
> +};
> +
> +static int camera_set(int status)
> +{
> +	int value;
> +	static int camera_status;
> +
> +	if (status = 2)
> +		/* resume the old camera status */
> +		camera_set(camera_status);
> +	else if (status = 3) {
> +		/* revert the camera status */
> +		value = ec_read(REG_CAMERA_CONTROL);
> +		ec_write(REG_CAMERA_CONTROL, value | (1 << 1));
> +	} else {/* status = 0 or status = 1 */
> +		status = !!status;
> +		camera_status = ec_read(REG_CAMERA_STATUS);
> +		if (status != camera_status)
> +			camera_set(3);
> +	}
> +	return ec_read(REG_CAMERA_STATUS);
> +}
> +
> +#define I8042_STATUS_REG	0x64
> +#define I8042_DATA_REG		0x60
> +#define i8042_read_status() inb(I8042_STATUS_REG)
> +#define i8042_read_data() inb(I8042_DATA_REG)
> +#define I8042_STR_OBF		0x01
> +#define I8042_BUFFER_SIZE	16
> +
> +static void i8042_flush(void)
> +{
> +	int i;
> +
> +	while ((i8042_read_status() & I8042_STR_OBF)
> +		&& (i < I8042_BUFFER_SIZE)) {
> +		udelay(50);
> +		i8042_read_data();
> +		i++;
> +	}
> +}
> +
> +static int yeeloong_hotkey_init(struct device *dev)
> +{
> +	int ret;
> +	struct key_entry *key;
> +
> +	/* flush the buffer of keyboard */
> +	i8042_flush();

Why??? Why does this driver tries to touch stuff that does not belong to
it?

> +
> +	/* setup the system control interface */
> +	setup_sci();

No failures?

> +
> +	yeeloong_hotkey_dev = input_allocate_device();
> +
> +	if (!yeeloong_hotkey_dev)
> +		return -ENOMEM;

Error unwinding?

> +
> +	yeeloong_hotkey_dev->name = "HotKeys";
> +	yeeloong_hotkey_dev->phys = "button/input0";
> +	yeeloong_hotkey_dev->id.bustype = BUS_HOST;
> +	yeeloong_hotkey_dev->dev.parent = dev;
> +
> +	for (key = yeeloong_keymap; key->type != KE_END; key++) {
> +		switch (key->type) {
> +		case KE_KEY:
> +			set_bit(EV_KEY, yeeloong_hotkey_dev->evbit);
> +			set_bit(key->keycode, yeeloong_hotkey_dev->keybit);
> +			break;
> +		case KE_SW:
> +			set_bit(EV_SW, yeeloong_hotkey_dev->evbit);
> +			set_bit(key->keycode, yeeloong_hotkey_dev->swbit);
> +			break;
> +		}
> +	}
> +
> +	ret = input_register_device(yeeloong_hotkey_dev);
> +	if (ret) {
> +		input_free_device(yeeloong_hotkey_dev);
> +		return ret;
> +	}
-- 
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
