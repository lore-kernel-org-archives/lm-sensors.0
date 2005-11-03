From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 03 Nov 2005 16:56:58 +0000
Subject: [lm-sensors] ATI SMBus - new information
Message-Id: <436A3330.1010605@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <435A1BA9.9080009@sh.cvut.cz>
In-Reply-To: <435A1BA9.9080009@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Patrick wrote:
> Rudolf,
>
> Googling around I found your posting at
> >http://lists.lm-sensors.org/pipermail/lm-sensors/2005-October/013946.html
> I have an Acer Ferrari with the ATI Xpress 200 chipset and am interested
> in a module for the ATI SMBus so I can see temps and fan speed with
> gkrellm. In your posting I read the info you require so have attached
> it. If you need anything else please let me know.

Thanks for the information.

You can try the patch
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-October/013962.html

It should work. But I cant give you any warranty that it wont destroy
the notebook. On the other hand we know this works at least in one case ;)

Just load:

modprobe i2c-i801
sensors-detect

Hopefuly it will find some sensors.

Regards
Rudolf
