From: paul@astropaul.com (Paul Reilly)
Date: Sat, 25 Nov 2006 10:02:16 +0000
Subject: [lm-sensors] Tyan S2877 CPU Temp Erratic
Message-Id: <1164448936.456814a8a4730@mail.third-rock.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1163375222.4557b2764fc69@mail.third-rock.net>
In-Reply-To: <1163375222.4557b2764fc69@mail.third-rock.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Thanks Rudolf,

I now use K8-temp and it seems to work.

k8temp-pci-00c3
Adapter: PCI adapter
CPU#0 Core1: +54?C
CPU#0 Core2: +59?C

I am using a sensors.conf of:

chip "k8temp-*"
        label temp1 "CPU#0 Core1"
        label temp3 "CPU#0 Core2"
        label temp2 "CPU#1 Core1"
        label temp4 "CPU#1 Core2"

Is this correct?
I get no reading on temp2 or temp4, which is right as I only have
one dual core Opteron in this two socket board.

Thanks,
Paul

