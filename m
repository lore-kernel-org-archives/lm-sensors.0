From: synaptical@linuxquestions.net (synaptical)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: no sensors found! with 2.6.0 kernel
Message-Id: <20040109233642.2A98D3945@sitemail.everyone.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040109220819.F0E2E3945@sitemail.everyone.net>
In-Reply-To: <20040109220819.F0E2E3945@sitemail.everyone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the quick reply. i patched the kernel to 2.6.1 and recompiled it, and now w83781d is detected and loads, but still the sensors do not work. 

root@homer:/home/sero # lsmod
Module                  Size  Used by
w83781d                33984  0 
i2c_sensor              3392  1 w83781d
i2c_dev                10944  0 
i2c_nforce2             5952  0 
i2c_core               25992  4 w83781d,i2c_sensor,i2c_dev,i2c_nforce2
cs46xx                 68940  2 
ac97_codec             19276  1 cs46xx
root@homer:/home/sero # sensors
No sensors found!
root@homer:/home/sero # modprobe w83627hf
FATAL: Module w83627hf not found.
root@homer:/home/sero # mount -t sysfs /sys /sys
mount: /sys already mounted or /sys busy
mount: according to mtab, /sys is already mounted on /sys

very puzzling... thanks for any input. 


--- Jean Delvare <khali@linux-fr.org> wrote:

2* The detection problem in w83781d is supposed to be fixed in kernel
2.6.1. If it isn't, let us know.



_____________________________________________________________
Thank you for choosing LinuxQuestions.
http://www.linuxquestions.org
