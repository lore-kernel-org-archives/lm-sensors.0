From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 11 May 2006 12:50:19 +0000
Subject: [lm-sensors] failed detection
Message-Id: <20060511145019.a1b0f23b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200605091804.16997.mmodem00@netvisao.pt>
In-Reply-To: <200605091804.16997.mmodem00@netvisao.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Z?,

> I have installed kernel-2.6.14 and build lm_sensors revision 1.424 but i do 
> continue getting problems when running sensors-detect:
> 
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no): y
> Probing for PCI bus adapters...
> Use driver `i2c-piix4' for device 00:14.0: ATI Technologies Inc ATI SMBus
> Probe succesfully concluded.
> 
> We will now try to load each adapter module in turn.
> Load `i2c-piix4' (say NO if built into your kernel)? (YES/no):
> Module loaded succesfully.

Support for the ATI chips was only added recently. It's not even in
mainline yet. You would need to use -mm kernels, or to pick and apply
the patch by yourself:
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-02-i2c/i2c-piix4-add-ati-smbus-support.patch

But if you aren't familiar with kernel compilation, it's easier to add
the device ID dynamically. Try (as root):

modprobe i2c-piix4
echo "1002 4353" > /sys/bus/pci/drivers/piix4_smbus/new_id
echo "1002 4363" > /sys/bus/pci/drivers/piix4_smbus/new_id
echo "1002 4372" > /sys/bus/pci/drivers/piix4_smbus/new_id

Then sensors-detect should be able to probe your SMBus. There may or
may not be chips connected to it.

The rest of the detections show no hardware monitoring chips, so this
is your last hope. If there is no hardware monitoring chip on the SMBus
either, try ACPI.

-- 
Jean Delvare

