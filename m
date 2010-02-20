From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 20 Feb 2010 17:55:10 +0000
Subject: Re: [lm-sensors] sensors in kernel 2.6.31
Message-Id: <20100220185510.5da9ae84@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B643CC1.2000003@redhat.com>
In-Reply-To: <4B643CC1.2000003@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 20 Feb 2010 17:45:19 +0100 (CET), Otto wrote:
> Hi,
> 
> At the moment my Linux server is running kernel 2.6.31-19 and using the 
> asus_atk0110 kernel module. As I discussed with Hans de Goede in Dutch 
> below, unfortunately the command `sensors` is only functioning on my 
> system when using the 'acpi_enforce_resources=lax' kernel option. Hans 
> advised me to send this email, because I have an Asus motherboard and it's 
> a bad idea to use both the acp_enforce_resources option and the 
> asus_atk0110 driver.

It's not that it's a bad idea... it is simply never needed. You need
the acpi_enforce_resource parameter only if you want to use a native
hwmon driver (e.g. it87 or w83627ehf) instead of asus_atk0110. If you
use the asus_atk0110 driver, you don't need it, by definition: it is an
ACPI driver.

> Ps. More info on my system is attached in the file sysinfo.txt.

> root@tommie:~# strings /dev/mem |grep P5
> P5K-V
> P5K-V
> P5K
> 
> root@tommie:~# strings /dev/mem |grep ASUS
> ASUSTeK Computer INC.
> ASUSTeK Pegasus

These are stupid and potentially dangerous commands. Use dmidecode or
any equivalent command instead.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
