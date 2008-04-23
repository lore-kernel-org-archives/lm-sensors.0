From: Gabriel C <crazy@frugalware.org>
Date: Wed, 23 Apr 2008 09:03:14 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <480EFB52.9040203@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Hi Gabriel,
> 
> Please send us a dsdt table. You can use following commands:
> 
> cat /proc/acpi/dsdt > /tmp/dsdt.bin
> cd /tmp
> iasl -d dsdt.bin
> 
> To obtain a text based table (dsdt.asl/dsl)

Sorry for the lag.

There the dsl file :

http://frugalware.org/~crazy/ASUS_P5E-VM_DO/dsdt.dsl

> 
> Thanks,
> Rudolf


Gabriel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
