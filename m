From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Thu, 25 Dec 2008 21:06:41 +0000
Subject: [lm-sensors] Sensors 3.0.3 on CentOS 5.2 (kernel 2.6.18) shows
Message-Id: <4953F5E1.8050906@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Some time ago, I upgraded my Linux machine to use a new motherboard:

  ASUS M2NPV-VM

At that time, I was told (on this list) that my CentOS Linux kernel was
too old for the 3.0.X version of the lm_sensors package. I've now upgraded
the machine to CentOS 5.2, which includes the Linux kernel 2.6.18.

I downloaded lm_sensors-3.0.3 from http://www.lm-sensors.org/wiki/Download
and built/installed successfully. This included some changes to the system's
ld.so.conf to include /usr/local/lib on the system LD path.

When I ran sensors-detect, it found the following:

  It said it found 'ITE IT8716F Super IO Sensors', address 0x290,
  driver 'it87'.

  It also said it found an AMD K8 thermal sensor embedded with the CPU
  (driver 'k8temp').

I had it create the /etc/sysconfig/lm_sensors file, which looks like
this (sans the comments):

  MODULE_0=it87
  MODULE_1=k8temp

I then created the /etc/init.d/lm_sensors file (as per the instructions)
and started the service.

I ran sensors -s (as root), but when I run sensors, the only output
I get is this:

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +33.0°C
Core1 Temp:  +37.0°C

Well, this appears to be showing me good CPU temps, but where is
the rest of the it87 chip data? Did I miss a step?

Thanks for any help.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
