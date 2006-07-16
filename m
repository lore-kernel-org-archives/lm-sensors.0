From: com.ea@tinet.org (com.ea)
Date: Sun, 16 Jul 2006 17:24:08 +0000
Subject: [lm-sensors] Looking for testers
Message-Id: <7askb297uvn6b7mo7tt48t0a9km8ipusbc@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

I am looking for testers of a fan/temperature control application.
This application allows the user to set a safe range of temperature and fan speed.

The application has been widely tested because it was written 2 years ago, 
but it used its own driver to read/write the hardware monitor (w83697hf).

I rewrote it to make use of libsensors and lm-sensors drivers. The idea is to
support all the chips able to provide 'changeable' pwm or dc output.

At the moment I have done the needed code for the kernel driver and libsensors 
to support the chips in the "w83627hf.c" driver (for 2.4 and 2.6 kernels)

I would like to find people with any of the following hardware monitors,

w83627hf
w83627thf
w83637hf
w83687thf
w83697hf <--- i got this one so no testing needed here

Testers interested should contact me at com.ea at tinet.org ,
I will supply the patches for libsensors / kernel drivers and the control application.

I will upload the new patches to the list as soon as they have been tested.

Regards
Carlos

