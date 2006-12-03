From: Thomas.Dohl@gmx.de (Thomas Dohl)
Date: Sun, 03 Dec 2006 20:20:01 +0000
Subject: [lm-sensors]
Message-Id: <45733171.9020903@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Udo,

I've found a strange bug or what ever in the Module. :)
I'll try to explain it.
If I boot Linux with the module "w83627hf", everything
is ok. But if I load the module with the workaround, like
"modprobe w83627hf reset=1" I get a 23?C higher temperature
of the second sensor.

At boottime:
temp1: 34?C
temp2: 33?C

after modprobe with reset=1
temp1: 34?C
temp2: 56?C (23?C more than it is)

This doesn't change after rmmod w83627hf, modprobe w83627hf.
Only after reboot, the values return to normal.

What could that be?

Regards
Thomas Dohl
(from Germany)


Udo van den Heuvel schrieb:
> in modprobe.conf:
> 
> options w83627hf reset=1
> 
> 
> I have a VIA EK8000 which has a similar problem. This is a workaround.
> Please post if it works.
> 

