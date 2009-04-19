From: Rudolf Marek <r.marek@assembler.cz>
Date: Sun, 19 Apr 2009 09:11:40 +0000
Subject: Re: [lm-sensors] w83793 related question
Message-Id: <49EAEACC.4050701@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <49E45712.6020906@aei.mpg.de>
In-Reply-To: <49E45712.6020906@aei.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Seems the w83793 chip itself is fine. However someone else want to talk to your 
i2c controller. Try unloading the acpi thermal module. Please send here

cat /proc/acpi/dsdt > dsdt.bin
iasl -d dsdt.bin

Result should be dsdt.dsl (or asl)

Thanks,
Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
