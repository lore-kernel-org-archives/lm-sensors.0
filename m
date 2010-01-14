From: Karl Newman <siliconfiend@gmail.com>
Date: Thu, 14 Jan 2010 14:56:34 +0000
Subject: [lm-sensors] ATK0110 on older Asus board
Message-Id: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6604587808825479513=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6604587808825479513==
Content-Type: multipart/alternative; boundary=0016367b6b36dfc00e047d2117ae

--0016367b6b36dfc00e047d2117ae
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I have a 4-year-old Asus A8N-VM CSM motherboard, which has a W83627EHG chip
for hardware monitoring. I recently upgraded to kernel 2.6.31 and ran into
the "Device or Resource busy" error when trying to load my existing
w83627ehf module. After some research, I discovered that I should use the
asus_atk0110 module instead. So, I updated my kernel config to build that
module and it will load with no problem, but "sensors" is ignoring it. When
I modprobe the module, it silently succeeds (it's listed in lsmod) but there
are no messages in dmesg or the syslog to indicate any activity from the
module, which makes me suspect that my board is not currently supported by
this module. I did confirm that it has the atk0110 chip (ls
/sys/bus/acpi/devices shows a ATK0110:00 entry). Am I doing something wrong,
or do you need a DSDT dump to support my motherboard, or...?

Thanks,

Karl Newman

--0016367b6b36dfc00e047d2117ae
Content-Type: text/html; charset=ISO-8859-1

Hello,<br><br>I have a 4-year-old Asus A8N-VM CSM motherboard, which
has a W83627EHG chip for hardware monitoring. I recently upgraded to
kernel 2.6.31 and ran into the &quot;Device or Resource busy&quot; error when
trying to load my existing w83627ehf module. After some research, I
discovered that I should use the asus_atk0110 module instead. So, I
updated my kernel config to build that module and it will load with no
problem, but &quot;sensors&quot; is ignoring it. When I modprobe the module, it
silently succeeds (it&#39;s listed in lsmod) but there are no messages in
dmesg or the syslog to indicate any activity from the module, which
makes me suspect that my board is not currently supported by this
module. I did confirm that it has the atk0110 chip (ls
/sys/bus/acpi/devices shows a ATK0110:00 entry). Am I doing something
wrong, or do you need a DSDT dump to support my motherboard, or...?<br>

<br>Thanks,<br><br>Karl Newman

--0016367b6b36dfc00e047d2117ae--


--===============6604587808825479513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6604587808825479513==--
