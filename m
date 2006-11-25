From: r.marek@assembler.cz (Rudolf Marek)
Date: Sat, 25 Nov 2006 10:07:56 +0000
Subject: [lm-sensors] Tyan S2877 CPU Temp Erratic
Message-Id: <456815FC.8060109@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1163375222.4557b2764fc69@mail.third-rock.net>
In-Reply-To: <1163375222.4557b2764fc69@mail.third-rock.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> OK, I have patched my kernel 2.6.16.30  with support for K8 Temp
> and
> 
> [*] AMD K8 processor sensor
> [*] National Semiconductor LM85 and compatibles

Good.

> I will not be able to reboot as is is a production machine.
> We can reboot over the weekend only.

Ok.

> Do you have an example sensors.conf  entry for the K8
> sensor to get the temperature values? It looks like there
> 2 sensors per core, so I should be able to monitor 4 temp
> with my Opteron? Great!

If your opteron supports 2 temps/core then yes ;)

Yes please check this page: 
http://www.lm-sensors.org/browser/lm-sensors/trunk/etc/sensors.conf.eg

hip "k8temp-*"

    label temp1 "Core0 Temp"
    label temp2 "Core0 Temp"
    label temp3 "Core1 Temp"
    label temp4 "Core1 Temp"

Rudolf

