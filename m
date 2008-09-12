From: Marco Chiappero <marco@absence.it>
Date: Fri, 12 Sep 2008 12:09:41 +0000
Subject: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <48CA5C05.8040307@absence.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everyone,
I recently bought an Asus Maximus II Formula mainboard which provides 
lots of temperature and voltage readings (and a total of 8 fan header), 
as you can see here using the Asus utility under Windows:
http://i38.tinypic.com/2gt109c.jpg
It's quite similar to the previous Maximus Formula board that, 
accordingly with this site
http://linux-eyecandy.org/misc/howtos/asus-maximus-formula/amf_sensors.shtml, 
comes with these sensors chips:

- Winbond W83627DHG
- Winbond W83791D
- Analog Devices ADT7475

Now, in this board the first one has been replaced by the new Winbond
W83667HG and it works thank to the trick of loading the w83627ehf driver
with the force_id=0x8860 option (but a its own driver is on the way,
right?). Starting from kernel 2.6.26 the coretemp driver works fine, but
my cpu isn't recognized by sensors-detect ("Sorry, no sensors were
detected", with lm-sensors 3.0.0) probably because I own a brand new
E8600 Intel CPU which is a E0 revision. I haven't tried lm-sensors 3.0.2
though.
For what concerns the other two sensors chips I can modprobe the
w83781, w83791d, w83792d, w83793 and adt7473 modules but running sensors
or sensors-detect shows no new sensors at all. Unfortunately adt7475
driver is not the upstream kernels yet.

Thank you for paying attention, here I am if you need some testing.


Marco Chiappero



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
