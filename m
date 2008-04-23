From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Apr 2008 11:03:28 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <20080423130328.4c7ef86a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 23 Apr 2008 11:03:14 +0200, Gabriel C wrote:
> Rudolf Marek wrote:
> > Hi Gabriel,
> > 
> > Please send us a dsdt table. You can use following commands:
> > 
> > cat /proc/acpi/dsdt > /tmp/dsdt.bin
> > cd /tmp
> > iasl -d dsdt.bin
> > 
> > To obtain a text based table (dsdt.asl/dsl)
> 
> Sorry for the lag.
> 
> There the dsl file :
> 
> http://frugalware.org/~crazy/ASUS_P5E-VM_DO/dsdt.dsl

Lots of hardware monitoring-related code in there. I suggest that you
do not load the w83627ehf driver on this machine. The ACPI BIOS is
supposed to take care about your hardware.

Maybe we could write an ACPI driver for your motherboard... I see the
ATK0110 ID, I seem to remember someone had written an experimental
driver for it. Rudolf should know more.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
