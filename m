From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 05 Jun 2005 18:14:02 +0000
Subject: [lm-sensors] HP VL400 sensors
Message-Id: <42A324A9.30501@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <42A21474.6030105@free.fr>
In-Reply-To: <42A21474.6030105@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> I have an HP VL400 (SF : small factor). I only manager to get the fan
> speeds using the pc87360 driver.

Yes we have driver for this chip.

> Can anyone help me get other informations from the system (temperatures,
> voltages)?

Yes you can try to autodetect the sensors chips.

What you need is to install lm_sensors package on your system.
The steps neccessary to proceed differes for linux-2.4 and linux-2.6 kernels

To know if you have 2.4.x or 2.6.x kernel run following command:
uname -a

for 2.4.x:
Download i2c and lm_sensors package from our webpage or get those as packages for your distribution.
Follow instructions how to install them.

for 2.6.x
Get either linux dirstribution package or download lm_sensors archive from our download page.
(for 2.6.x compilation: make user_install is enough)

When you have package(s) installed you need to run script called:
sensors-detect
It will try to detect chips used for monitoring.

If it find only pc87360 you can try to email us full output of the detection command I may help to find out what chips
you have.

You can get output to a file by this command:
sensors-detect > /tmp/sensors_output

(you wont see anything but all you need to press y key to let the detection proceed)

If any troubles, just ask.
I hope this help.

Regards
Rudolf
