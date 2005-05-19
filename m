From: lepalom@vilma.upc.es (Leopold Palomo Avellaneda)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: Problems with a drivers
Message-Id: <200309261107.40242.lepalom@vilma.upc.es>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

first of all, I'm sorry if I ask a silly question, I'm new in lm-sensors.

I have compiled my own kernel 2.4.21 with two pathes:
- openmosix
- lm_sensor

I'm using debian woody and it's compiled wig gcc 2.95. I'm using the sources 
lm_sensors 2.8 from debian unstable and i2c too.

My own kernel with openmosix and the i2c modules works well, no problems (As I 
known by now). I have only a problem with the driver:
w83781d 

because it's all the time inicialitzating. I have test to do and init=0, too, 
but I had a segmentation fault:
e01:~# modprobe w83781d init=0
Segmentation fault

I'm a bit lost and I don't know what to do. Could you help me please?

Best regards,

Leo
