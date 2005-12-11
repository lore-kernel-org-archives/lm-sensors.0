From: hidden@paradise.net.nz (Volker Kuhlmann)
Date: Sun, 11 Dec 2005 23:27:32 +0000
Subject: [lm-sensors] lm_sensors and nvidia graphic
Message-Id: <20051211232732.GD6764@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <439C3D15.6020207@sh.cvut.cz>
In-Reply-To: <439C3D15.6020207@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[nvidia graphics card temp monitoring]

> You can try:
> 1) load i2c-rivatv (or whatever driver for the i2c nvidia bus)

i2c-nvidia2 is loaded automatically, but sensors-detect only finds 2
dimm eeproms and the mobo's it8712. However, it finds two adapters, but
no success on the first: 

Next adapter: SMBus nForce2 adapter at 1c40
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x08
Client found at address 0x4e
[all failed]

Next adapter: SMBus nForce2 adapter at 1c00
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x08
Client found at address 0x50
[2 eeproms found]

What kernel module should I load exactly? Google doesn't know anything
about i2c-rivatv.

> Run sensors detect it  should find he w83785

modprobe w83l785ts is fine. No change with sensors-detect though.

Being able to get the temp of the geforce 6600 chip would be cool, as I
have a temp problem with it. What else could I try?

Thanks,

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.

