From: ymu@winbond.com (Yuan Mu)
Date: Fri, 14 Jul 2006 05:08:03 +0000
Subject: [lm-sensors] Linux 2.6.16 kernel and "Can't access
Message-Id: <44B726B3.9030704@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Keith,
> I've installed lm_sensors v2.10.0 on a Linux system running a 2.16.6
> kernel. That's a Debian kernel, but I've also tried with a 2.6.17.4
> vanilla kernel.
> 
> lm_sensors builds and installs fine, and sensors-detect runs and detects
> i2c-i801. The 'sensors' command gives 'Can't access procfs/sysfs file'.
> The FAQ suggests ensuring that /sys is mounted and populated (it is),
> and that i2c-proc is loaded. That module is not loaded, but it doesn't
> seem to be in the 2.16.6 kernels.
> 
> Should I have an i2c-proc module? If not, any further suggestions would
> be welcome - thanks.
Can you give the output of sensors-detect and output of `ls /sys/bus/i2c/drivers/*`.
I think it may because it has not find any hwmon chips OR library linked to "sensors"
is not the right one.

-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

