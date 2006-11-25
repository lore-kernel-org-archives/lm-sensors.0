From: r.marek@assembler.cz (Rudolf Marek)
Date: Sat, 25 Nov 2006 12:48:01 +0000
Subject: [lm-sensors] Tyan S2877 CPU Temp Erratic
Message-Id: <45683B81.5080706@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1163375222.4557b2764fc69@mail.third-rock.net>
In-Reply-To: <1163375222.4557b2764fc69@mail.third-rock.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> Thanks Rudolf,

Heh good ;)

> I now use K8-temp and it seems to work.
> 
> k8temp-pci-00c3
> Adapter: PCI adapter
> CPU#0 Core1: +54?C
> CPU#0 Core2: +59?C
> 
> I am using a sensors.conf of:
> 
> chip "k8temp-*"
>         label temp1 "CPU#0 Core1"
>         label temp3 "CPU#0 Core2"
>         label temp2 "CPU#1 Core1"
>         label temp4 "CPU#1 Core2"
> 
> Is this correct?
> I get no reading on temp2 or temp4, which is right as I only have
> one dual core Opteron in this two socket board.

Theoretically there could be 4 temps for one physical CPU. Two for each core * 2 
= 4. And because your CPU is dualcore, and your CPU supports only 1 
temperature/core so you see two of them ;) I hope I clarified that.

So all in all, this works fine. Lets check the i2c bus related problem. And wait 
for some logs from you ;)

Regards
Rudolf

