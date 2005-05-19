From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: [RFC PATCH 2.6.12-rc2-mm2 0/2] i2c: new sysfs class "hwmon"
Message-Id: <d120d50005041309342a0ad6d5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050411044427.GA4963@jupiter.solarsys.private>
In-Reply-To: <20050411044427.GA4963@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
Sorry for breaking the thread (I was not subscribed to this list)...
I think that just simply linking current i2c device attributes intoclass structure is not the best thing to do. Since userspace needs tobe changed anyway (to a certain extent) we should evaluate whether itwould be beneficial to change layout too.
I would like to see something like this:
sys/class/sensors---fan---0---(min,in,div)                  |     |                  |     --1---(min,in,div)                  |                  |-temp---0---(type,min,max,hyst?)                  |      |                  |      --1---(type,min,max,hyst..)                  |                  --curr----0---(min,max,in)
This of course depends on Greg adding support for nested classes tothe driver code (how is it going, Greg?). Alternatively we couldflatten a tree a bit doingfan%d, temp%d...
We would have: sensors_register_fan, sensors_register_temp,sensors_register_curr, sensors_register_generic...
struct sensor_fan_dev {	char name[MAX_SENSOR_NAME]	int min, div;	struct class_device class_dev;
	int (*read)(struct sensor_temp_dev *);	int  (*start)(struct sensor_temp_dev *, int speed)};
struct sensor_temp_dev {	char name[MAX_SENSOR_NAME]	int type, min, max, hyst;	struct class_device class_dev;
	int (*read)(struct sensor_temp_dev *);};
This way every sensor input is registered as an independent classdevice, all their attributes are kept together, names are muchsimplier and there are less chances of clashes and I believe they areeasier to maintain. Other subsystems should also be able to add to thehierarchy without knowing anything about i2c internals.
What do you think?
-- Dmitry
