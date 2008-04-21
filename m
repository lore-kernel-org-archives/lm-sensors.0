From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 21 Apr 2008 07:53:37 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <480C4801.8000106@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gabriel,

Please send us a dsdt table. You can use following commands:

cat /proc/acpi/dsdt > /tmp/dsdt.bin
cd /tmp
iasl -d dsdt.bin

To obtain a text based table (dsdt.asl/dsl)

Thanks,
Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
