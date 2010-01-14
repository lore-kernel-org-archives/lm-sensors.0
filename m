From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Jan 2010 15:19:55 +0000
Subject: Re: [lm-sensors] ATK0110 on older Asus board
Message-Id: <20100114161955.37379ad9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
In-Reply-To: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Karl,

On Thu, 14 Jan 2010 06:56:34 -0800, Karl Newman wrote:
> I have a 4-year-old Asus A8N-VM CSM motherboard, which has a W83627EHG chip
> for hardware monitoring. I recently upgraded to kernel 2.6.31 and ran into
> the "Device or Resource busy" error when trying to load my existing
> w83627ehf module. After some research, I discovered that I should use the
> asus_atk0110 module instead. So, I updated my kernel config to build that
> module and it will load with no problem, but "sensors" is ignoring it. When
> I modprobe the module, it silently succeeds (it's listed in lsmod) but there
> are no messages in dmesg or the syslog to indicate any activity from the
> module, which makes me suspect that my board is not currently supported by
> this module. I did confirm that it has the atk0110 chip (ls
> /sys/bus/acpi/devices shows a ATK0110:00 entry). Am I doing something wrong,
> or do you need a DSDT dump to support my motherboard, or...?

Which version of lm-sensors are you running? "sensors -v" will tell
you. Minimum version for asus_atk0110 support is 3.1.0, as documented
on:
  http://www.lm-sensors.org/wiki/Devices

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
