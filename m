From: matejken@gmail.com (Matej Kenda)
Date: Mon, 12 Mar 2007 08:09:59 +0000
Subject: [lm-sensors] Patch to fix attaching HWMON devices on I2C-PXA adapter
Message-Id: <df4ec9600703120109j6cb1c848q54cc7c286b3dfaeb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

During my attempts to use HWMON drivers attached to the PXA I2C
adapter (XScale PXA 255, ARM architecture) I have found a bug in the
i2x-pxa driver that prevented using HWMON devices in that adapter at
all.

I have fixed the problem and posted the patch to ARM Linux patch database.

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?idB46/1

Regards,

Matej

-- 
Matej Kenda, Senior Software Engineer
HERMES SoftLab d.d. (www.hermes-softlab.com), Slovenia

