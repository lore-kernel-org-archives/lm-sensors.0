From: nicolas@boichat.ch (Nicolas Boichat)
Date: Thu, 22 Mar 2007 10:36:43 +0000
Subject: [lm-sensors] [RFC][PATCH] Apple SMC driver (hardware monitoring
Message-Id: <46025C3B.6010702@boichat.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F7C083.7090504@boichat.ch>	<b6c5339f0703191443l5f8c5271pf43ea62e0c79a614@mail.gmail.com> <20070320110818.1b11c406.khali@linux-fr.org>
In-Reply-To: <20070320110818.1b11c406.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Bob Copeland <me@bobcopeland.com>, linux-kernel@hansmi.ch, rlove@rlove.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Jean Delvare wrote:
> On Mon, 19 Mar 2007 17:43:38 -0400, Bob Copeland wrote:
>   
>> I tried out an earlier version of this patch several months ago just to play
>> around with the joystick part of the accelerometer driver on my MacBook, and
>> found that it was backwards in the y-direction compared to what Neverball
>> seemed to want (of course, NB has no way to invert the joystick).  I think
>> I just did something like this in my own copy:
>>
>> +       y = -y;
>>         input_report_abs(applesmc_idev, ABS_X, x - rest_x);
>>         input_report_abs(applesmc_idev, ABS_Y, y - rest_y);
>>
>> I don't claim you necessarily want to change it, but thought I'd pass it
>> along.
>>     
>
> This appears to be a common problem with these devices, the hdaps driver
> (IBM) needs to invert the axis on some models too, and I seem to
> remember something similar for the (not yet merged) HP laptops
> accelerometer driver.
>   
Ok, so let's invert the axis on the input device.

I think the raw x value in sysfs behaves the same way as hdaps (because
tools like hdaps-gl don't need any inversion), so I don't invert it.

Anyone with an IBM laptop could confirm this please?
 - x value gets more positive when you lift the right side on the laptop
(= tilted to the left)
 - y value gets more negative when you tilt the laptop backwards
(simply cat /sys/devices/platform/hdaps/position)

Thanks,

Best regards,

Nicolas

Invert x axis on applesmc input device to make it usable as a joystick.

Signed-off-by: Nicolas Boichat <nicolas at boichat.ch>


---

 drivers/hwmon/applesmc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 4060667..581ed3e 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -349,6 +349,7 @@ static void applesmc_calibrate(void)
 {
 	applesmc_read_motion_sensor(SENSOR_X, &rest_x);
 	applesmc_read_motion_sensor(SENSOR_Y, &rest_y);
+	rest_x = -rest_x;
 }
 
 static void applesmc_mousedev_poll(unsigned long unused)
@@ -366,6 +367,7 @@ static void applesmc_mousedev_poll(unsigned long unused)
 	if (applesmc_read_motion_sensor(SENSOR_Y, &y))
 		goto out;
 
+	x = -x;
 	input_report_abs(applesmc_idev, ABS_X, x - rest_x);
 	input_report_abs(applesmc_idev, ABS_Y, y - rest_y);
 	input_sync(applesmc_idev);



