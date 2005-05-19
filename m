From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: w83627hf module
Message-Id: <Pine.LNX.4.58.0407212142170.182@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407201955.33362.cezarym@pf.pl>
In-Reply-To: <200407201955.33362.cezarym@pf.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I think I know your problem.

You should use  lm_sensors 2.8.5 for Kernels 2.6.3-rc2 to 2.6.4.
As it is written here: http://secure.netroedge.com/~lm78/kernel26.html

Get the 2.8.5 version of lm_sensors.

Also I suspect that you dont have /sys mounted. It is "similar" to /proc
in 2.6 kernels.

Add as root this line to /etc/fstab

sysfs /sys sysfs rw 0 0

than just write

mount /sys

If it complains that directory does not exists just create it (mkdir /sys)
and repeat :)

Please dont forget to CC to mailing list.

I hope this helps

regards

Rudolf
