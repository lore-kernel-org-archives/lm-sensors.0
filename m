From: Rudolf Marek <r.marek@assembler.cz>
Date: Sun, 05 Aug 2007 08:43:52 +0000
Subject: Re: [lm-sensors] Hardware monitoring on Asus A6JM laptop
Message-Id: <46B58DC8.3040809@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B395DF.30504@free.fr>
In-Reply-To: <46B395DF.30504@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please can you send a dsdt.bin

cat /proc/acpi/dsdt > /tmp/dsdt.bin

and also cat /proc/ioports
(when SMBus driver is loaded)

Thanks,

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
