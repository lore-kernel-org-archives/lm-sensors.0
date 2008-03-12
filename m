From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 12 Mar 2008 09:15:31 +0000
Subject: Re: [lm-sensors] serious w83627ehf problem stopping cpu fan
Message-Id: <47D79F33.7080906@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080312011430.GA20751@alf.mars>
In-Reply-To: <20080312011430.GA20751@alf.mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

What motherboard it is? Asus A8V-E SE? Can you please send dsdt table here?

cd /tmp
cat /proc/acpi/dsdt  >dsdt.bin
iasl -d dsdt.bin

(output will be named dsdt.dsl)

If you go to BIOS, is Q-fan enabled? What is your settings there?

Thanks,
Rudolf


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
