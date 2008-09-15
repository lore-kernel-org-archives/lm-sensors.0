From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 15 Sep 2008 12:17:17 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors
Message-Id: <48CE524D.1030609@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CCB294.907@hhs.nl>
In-Reply-To: <48CCB294.907@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Can you display a tree of sensors? To sort them by connection to right 
chips. Maybe it would help me the
DSDT of the ACPI.

Please can you post the text file obtained by iasl util.

cd /tmp
cat /proc/acpi/dsdt.bin >dsdt.bin
iasl -d dsdt.bin

It will be called dsdt.asl or dsdt.dsl

Thanks,
Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
