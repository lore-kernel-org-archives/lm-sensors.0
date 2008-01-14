From: Steve Hardy <steve@linuxrealtime.co.uk>
Date: Mon, 14 Jan 2008 22:28:51 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] : hwmon - new chip driver for TI
Message-Id: <20080114222849.GA7279@toshiba-lt>
List-Id: <lm-sensors.vger.kernel.org>
References: <477D50CC.6020504@linuxrealtime.co.uk> <20080104073439.GA22033@toshiba-lt> <20080110141934.1266ee39@hyperion.delvare>
In-Reply-To: <20080110141934.1266ee39@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


> As far as I know boolean parameters take values 0 and 1, not N and Y.

Not on the systems I am testing on (2.6.24-rc6) - the sysfs interface
displays boolean parameters as Y/N, and will accept boot parameters as
either Y/N or 0/1.  Below is a snippet from a test proving this point :

test@shtest:~$ cat /sys/module/ads7828/parameters/se_input
Y
test@shtest:~$ cat /sys/module/ads7828/parameters/int_vref
Y

after appending the ads7828.int_vref=N parameter to the kernel
command-line :

Linux 2.6.24-rc6 (shtest) (16:53 on Saturday, 05 January 2002)

login: test
test@shtest:~$ cat /sys/module/ads7828/parameters/int_vref
N

Is it more "correct" to refer to 1/0 in the documentation?
I just naturally used the same syntax provided by the sysfs nodes


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
