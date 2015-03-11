From: Craig MacFarlane <camacfarl@gmail.com>
Date: Wed, 11 Mar 2015 18:36:28 +0000
Subject: [lm-sensors] 3.x i2c-mux-pca954x vs 2.6.x i2c-pca954x
Message-Id: <CAPQE1b92dT-MqOBBpNBtCuDYKJE1M5iQSyWO67ZOb7MsXMJD3A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Folks, I'm trying to migrate to the 3.x kernel and I have
some software that wants to instantiate the virtual
bus driver for pca954x devices.

I used to do this as so...

  modprobe i2c-pca954x force_pca9548=0,0x77

That no longer works as the force parameter has
gone away.  Fair enough.  But I can't seem to find
the magic incantation to make this work in the
new_device mechanism.

I've tried many variations

  modprobe i2c-mux-pca954x
  echo i2c-mux-pca954x 0x77 > /sys/bus/i2c/devices/i2c-0/new_device

and

  modprobe i2c-mux-pca954x
  echo i2c-mux-pca9548 0x77 > /sys/bus/i2c/devices/i2c-0/new_device

and

  echo i2c-mux-pca954x 0x77 > /sys/bus/i2c/devices/i2c-0/new_device
  modprobe i2c-mux-pca954x

and

  echo i2c-mux-pca9548 0x77 > /sys/bus/i2c/devices/i2c-0/new_device
  modprobe i2c-mux-pca954x

I do have the i2c-dev module loaded when all of this is attempted.

Example lsmod

[RP_0:~]$ lsmod
Module                  Size  Used by
i2c_mux_pca954x         2592  0
i2c_dev                 6427  0
i2c_i801                8794  0

Nothing above creates the /dev nodes for i2c-1 through 8.

I have instrumented the i2c_mux_pca954x driver to show if it's probe
is ever being called and the answer is no and trying to work back through
the chain of calls from i2c_sysfs_new_device() to an actual device probe
is eluding me.

Anyone have any idea how to make this work?

Thanks,
Craig
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
