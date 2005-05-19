From: Eric.Brunet@lps.ens.fr (=?iso-8859-1?Q?=C9ric?= Brunet)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: shuttle and sensors on a 2.5.70
Message-Id: <20030605181335.GA5044@lps.ens.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have a shuttle XPC SB51G with only one fan. In the bios, you can set
this fan to run in ``Autoguardian mode'': it is running at 2000 rpm below
a certain temperature or at 3000 noisy rpm above. The computer never
reached this critical temperature so I am always working with the nearly
silent 2000 rpm mode. However, it is not silent enough, and my plan is to
shut down completely this fan and set the processor to run at one tenth
of its frequency. Most of the time (for instance at night), it would be
enough and extremely silent.

I have tried to shut down the fan with acpi, but to no avail. Recently,
I have compiled a 2.5.70 kernel with sensors modules. 

The funny thing is that the mere fact of loading the modules (chip it87,
bus i2c_i801) set my fan in the noisy mode: it gets immediatly to 3000
rpm when the modprobe returns.

I have looked at the files in the /sys filesystem. I have:

fan_div1  2
fan_div2  2
fan_div3  2
fan_input1  0
fan_input2  0
fan_input3  3668
fan_min1  3000
fan_min2  3000
fan_min3  3000

I can set fan_min3 to a lower value, but the fan won't slow down.
Removing the modules won't do anything either. I was disapointed that no
pwm[1-3] files (as advertised in <kernel source>/Documentation/i2c/sysfs-interface)  show up in the sysfs.

So my questions are:

	is it normal that just loading a module change my fan's behaviour ?
is it a bug ? Can I prevent it ?
	once loaded, can I go back to the previous nearly-silent mode at
2000 rpm ? Right now, the only way seems to reboot...
	can I more generally set an arbitrary fan speed and eventually
shut down completely the fan ?

Thank you for your help.

	?ric Brunet
