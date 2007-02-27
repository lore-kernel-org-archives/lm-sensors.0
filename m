From: matejken@gmail.com (Matej Kenda)
Date: Tue, 27 Feb 2007 16:29:59 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <df4ec9600702270829j509c65f4tbb5c96d07ecfa8e9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2007/2/27, Jean Delvare <khali at linux-fr.org>:
> > * define i2c driver ID in the include/i2c-id.h
>
> Even better, don't set an ID if you don't need it.

Most of the hwmon drivers set the id. Were they set by inertia or do
some of the drivers actually need it?

> The files should actually be named fan1_input to fan4_input (for
> measured values.)

I've modified the names like this:

static DEVICE_ATTR(fan1_input, S_IRUGO, get_fan1, NULL);
static DEVICE_ATTR(fan2_input, S_IRUGO, get_fan2, NULL);
static DEVICE_ATTR(fan3_input, S_IRUGO, get_fan3, NULL);
static DEVICE_ATTR(fan4_input, S_IRUGO, get_fan4, NULL);
static DEVICE_ATTR(count, S_IRUGO, get_count, NULL);
static DEVICE_ATTR(config, S_IRUGO, get_config, NULL);
static DEVICE_ATTR(speed, S_IWUSR | S_IRUGO, get_speed, set_speed);

Other driver usually have _min and _div files.

Do the count, speed and config also have to be modified to follow a convention?

Matej

-- 
Matej Kenda, Senior Software Engineer
HERMES SoftLab d.d. (www.hermes-softlab.com), Slovenia

