From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 04 Dec 2006 08:06:02 +0000
Subject: [lm-sensors] testing w83627hf treiber?
Message-Id: <20061204090602.07b8d41b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

(Huh, please don't use URLs as post subjects.)

On Sun, 03 Dec 2006 21:20:01 +0100, Thomas Dohl wrote:
> I've found a strange bug or what ever in the Module. :)
> I'll try to explain it.
> If I boot Linux with the module "w83627hf", everything
> is ok. But if I load the module with the workaround, like
> "modprobe w83627hf reset=1" I get a 23?C higher temperature
> of the second sensor.
> 
> At boottime:
> temp1: 34?C
> temp2: 33?C
> 
> after modprobe with reset=1
> temp1: 34?C
> temp2: 56?C (23?C more than it is)
> 
> This doesn't change after rmmod w83627hf, modprobe w83627hf.
> Only after reboot, the values return to normal.
> 
> What could that be?

Easy. The W83627*F chips have temperature offset registers. The BIOS
must write an offset for the temp2 (CPU?) temperature sensor, to
account for a different thermal diode model for example, or just to
make it look cooler to the user... When the w83627hf driver resets the
chip, the offset is reset to 0 as well, so you get the "raw" reading
again.

See, this is exactly the reason why we don't reset the chip by default:
to preserve BIOS settings.

-- 
Jean Delvare

