From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 25 Sep 2005 13:00:37 +0000
Subject: [lm-sensors] my soyo syk7vem pro 1.0 shows 127 degrees for cpu
Message-Id: <4336833C.4080906@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43304984.7090309@fcav.unesp.br>
In-Reply-To: <43304984.7090309@fcav.unesp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marcelo Luiz de Laia wrote:
> Dear Marek,

You can call me with my first name, I know this is confusing. I will add you to my internal list of people that
exchanged my name and surname :)

Ok this is telling you to load lm80. But this is not correct.
You have integrated via686a on your board. This chip has no assigned address but you can fix it.
And because you are using old kernel you cant use i2c-viapro and via686a at the same time.

So all you need is todo:

rmmod lm80
rmmod i2c-viapro
modprobe i2c-isa
modprobe via686a force_addr=0x6000
sensors

So all you need to ensure is:
load i2c-isa via686a with force parameter, DO NOT load i2c-viapro

> Thank you very much
no problem :)

Rudolf
