From: Helmut Grohne <helmut@subdivi.de>
Date: Wed, 12 Mar 2008 12:24:21 +0000
Subject: Re: [lm-sensors] serious w83627ehf problem stopping cpu fan
Message-Id: <20080312122421.GA1519@alf.mars>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080312011430.GA20751@alf.mars>
In-Reply-To: <20080312011430.GA20751@alf.mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> cd /tmp
> cat /proc/acpi/dsdt  >dsdt.bin
> iasl -d dsdt.bin

Thanks to Jean Delvare for pointing me to
/sys/firmware/acpi/tables/DSDT. This now worked.


> (output will be named dsdt.dsl)

The file can be found at http://subdivi.de/~helmut/dsdt.dsl.

Helmut

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
