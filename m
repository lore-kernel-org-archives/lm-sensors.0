From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: sensors on a MSI 915p neo2 platinum don't work
Message-Id: <20050115081136.062a0b58.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41E84F51.2060505@gmail.com>
In-Reply-To: <41E84F51.2060505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tiago,

> Hi, i just upgraded to a MSI 915p neo2 , that has the winbond
> w83627thf.
> kernel: 2.6.10-gentoo-r4
> lm_sensors: 2.9.0
> 
> with the w83627hf  driver in the kernel when i tried to insert the 
> module i would always get "no such device",
> after looking for the problem i found this patch 
> "http://archives.andrew.net.au/lm-sensors/msg28713.html" and applied
> it. the module now loads but i still get the "no sensors found!" from 
> sensors prog.
> 
> here is the lsmod output:
> w83627hf               29352  0
> i2c_isa                 2304  0
> i2c_algo_pcf            7172  0
> i2c_algo_pca            6276  0
> i2c_algo_bit           10120  0
> i2c_sensor              4480  1 w83627hf
> i2c_i801               11148  0

Looks all OK to me (except that you most likely don't really need any of
the algorithm drivers.)

I suspect that you have the same problem as reported here:
http://lkml.org/lkml/2005/1/7/351
and here:
http://bugzilla.kernel.org/show_bug.cgi?id@14

Please check in /proc/ioports if the 0x295-0x296 range is reserved by
pnp. If it is, you would have to remove "Plug and Play ACPI support"
from your kernel and then sensors should be working again.

-- 
Jean Delvare
http://khali.linux-fr.org/
