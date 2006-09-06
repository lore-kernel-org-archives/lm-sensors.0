From: bchang@atipa.com (Brady Chang)
Date: Wed, 06 Sep 2006 18:19:23 +0000
Subject: [lm-sensors] i2c_nforce2 on ASUS K8N-DRE
Message-Id: <E7EB4A8D5B2C8F498A269F0963C8BB8E038328@mail.atipa.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,
 
I have the K8N-DRE running redhat 4 update 3
Kernel 2.6.9-34.0.2ELsmp , sensors version 2.8.7
 
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 8162
        Flags: 66Mhz, fast devsel, IRQ 177
        I/O ports at fc00 [size2]
        I/O ports at 4c00 [sized]
        I/O ports at 4c40 [sized]
        Capabilities: [44] Power Management version 2

 
Appreciated if anyone knows what  PCI ID's I should add to the nForce2_smbus
 
In the past,  I used 
echo "10de 0052" > /sys/bus/pci/drivers/nForce2_smbus/new_id on the Tyans, and it seems to work.
 
thanks in advance for your assistance.
 
-Brady
 
 
 
 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060906/bb87b898/attachment.html 
