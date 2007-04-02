From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Apr 2007 07:54:23 +0000
Subject: Re: [lm-sensors] FW: nforce2 mcp55
Message-Id: <20070402095423.d437d857.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Brady,

On Fri, 30 Mar 2007 14:39:24 -0500, brady wrote:
> I try to get sensors working for this.
>
> modprobe i2c_nforce2
> 
> identify the pci_vendor_id and 
> 
> echo "10de:0368 "> /sys/bus/pci/drivers/nForce2_smbus/new_id
> 
> error in the log:

You got the syntax wrong. The correct syntax is:

echo "10de 0368 "> /sys/bus/pci/drivers/nForce2_smbus/new_id

Note the white space instead of the colon.

> [root@compute-0-0 ~]# uname -r 
> 
> 2.6.9-42.0.10.ELsmp

On top of that, the nForce MCP51 and up use different registers for
the I/O base address, and the i2c-nforce2 driver in 2.6.9 doesn't
support that, so unless Red Hat backported that change, the new_id
trick won't work for this device/kernel version combination.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
