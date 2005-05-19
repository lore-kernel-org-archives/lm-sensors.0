From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:59 +0000
Subject: it87 pwm patch for 2.6.6
Message-Id: <20040522125339.26467da0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516205100.GA9996@nemo.sby.abo.fi>
In-Reply-To: <20040516205100.GA9996@nemo.sby.abo.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonas,

I finished reviewing your patch.

> 1. I wrote this reading the it8705f datasheet. I got the impression
> the other it87* chips work in the same way, but I haven't actually
> checked this.

I checked your code against the IT8712F datasheet and it seems to match.

> 2. The fan controllers can be in three different states, changes in
> settings effecting other states than the current one are rejected. An
> alternative would be to save them and write them to the it87 after a
> state change.

Yes, I think you save them instead. The way it is in your patch, the
user has to enable a mode first, and configure it after that. The
natural order is obviously to program the mode first and enable it after
that.

> 3. There are a lot of tunable settings files... The sysfs directory
> becomes quite cluttered. And the it87.c contains a lot of
> adminstrative overhead to set up all those files.

Some files could (and should) be removed. fanN_enable and
fanN_auto_enable are not needed.

fanN_enable is ambiguous, it could either mean "enable fanN monitoring"
or "enable fanN". We'll have 2.6 driver which can individually disable
temperature or voltage channels, through files named tempN_enable and
inN_enable. Your proposal for "fanN_enable" doesn't match this plan.

Fortunately, you don't really need this file. fanN_enable = 1 is
actually fanN_pwm_enable = 0, and fanN_enable = 0 is fanN_pwm_enable = 1
and fanN_pwm = 0. So the interface as defined now is already OK. You are
free to physically disable PWM mode when the user writes 0 to fanN_pwm 0 (much like audio mixers have hardware mute).

fanN_auto_enable = 0 can be replaced by fanN_auto_temp_channel = 0 as
well.

I have some proposals to rework the proposed interface. I'll do this is
a different post.

About your patch now. I'll start with general comments about choices you
made when I don't agree.

1* You don't cache auto fan speed register values. They are physically
accessed on every read. This is not correct, since any user can read
these files. This opens the door to attacks (continuously reading from
the chip may prevent it to trigger alarms, start fans etc...). Please
treat these registers exactly like any other. They must be read in the
device update function, and stored in the private data structure.

2* I'm skeptical about your it87_pwm_mode function. Wherever you call
it, you never really need to know the mode. Instead, you want to know if
the mode is (or is not) one given mode. Your approach is quite expensive
IMHO. What about defining the following macros instead:

#define pwm_is_off(data,nr) (!((data)->fan_main_ctrl & (1 << (nr))))
#define pwm_is_software(data,nr) (((data)->fan_main_ctrl & (1 << (nr))) \
                                  && !(data)->pwm_mode[nr])
#define pwm_is_automatic(data,nr) (((data)->fan_main_ctrl & (1 << (nr))) \
                                   && (data)->pwm_mode[nr])

I think it would be more efficient (both in terms of code size and
speed).

3* Why do you force PWM output to active high? People which have their
fans physically set up for active low won't be able to use the driver.
The BIOS is supposed to have configured this correctly, there's no need
to change that. If you're worried about the fact that resetting the chip
will lose this information, well, too bad. Resetting the chip is a bad
idea and should never be done IMHO. What you may consider is preserving
that configuration bit on reset - but heh it's no more a reset if we
start preserving stuff ;) Or you may allow the user to chose a polarity
through the init parameter value (or another one). But do *not*
arbitrarily change that configuration bit by default.

A few technical comments about your actual code now. You are free to
decide when I'm right and whan I'm not.

+static ssize_t show_fan_pwm_enable (struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf, "%d\n", (data->fan_main_ctrl & (1 << nr)) != 0);
+}

Can be written: (data->fan_main_ctrl >> nr) & 1, which should be more
efficient.

+static ssize_t show_fan_enable (struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf, "%d\n", (data->fan_ctl & (1 << nr)) != 0);
+}

Ditto.

+static ssize_t show_fan_auto_temp_channel (struct device *dev, char *buf, int nr)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf, "%d\n", data->pwm_tmpin[nr] ? (data->pwm_tmpin[nr] << 1) : 1 );
+}

No extra space before closing parenthesis please.

Why do you default to 1? 0 would seem more sensible.

+static ssize_t set_fan_pwm(struct device *dev, const char *buf,
+		 size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (it87_pwm_mode(data, nr) != PWM_SOFTWARE)
+		return -1;
+	if (val < 0 || val > 255)
+		return -1;
+	data->pwm_value[nr] = PWM_TO_REG(val);
+	it87_write_value(client, IT87_REG_PWM(nr), data->pwm_value[nr]);
+	return count;
+}

Return -EINVAL on error, not just -1. Same for all other "set_fan"
functions you introduced.

+static ssize_t set_fan_auto_pwm_max (struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	int val = simple_strtol(buf, NULL, 10);
+
+	if (val != 255)
+		return -1;
+	return count;
+}

Mwaaahaha. You're kidding, right?

If that value cannot be changed, then make the file read-only.

+	/* Check poloarity of FAN_CTL3-1 registers (which are low active after a reset) */

s/poloarity/polarity/
s/low active/active low/

Your patch doesn't look bad all in all, except the few design issues I
mentioned above.

Sorry for the delay again.

-- 
Jean Delvare
http://khali.linux-fr.org/
