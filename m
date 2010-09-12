From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 12 Sep 2010 16:32:11 +0000
Subject: Re: [lm-sensors] ECS H55H-I Support (Suspected IT8721F Chipset)
Message-Id: <20100912163211.GD29905@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=Bp+JJm8GoSG14X-b7BuCP_NwnxP2=nTeWWpXD@mail.gmail.com>
In-Reply-To: <AANLkTi=Bp+JJm8GoSG14X-b7BuCP_NwnxP2=nTeWWpXD@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 08, 2010 at 04:15:09PM -0400, Virgil Gheorghiu wrote:
> Good afternoon, Jae, Jean,
> 
> >>> Rumor says that there's a chip named IT8758E with device ID 0x8721.
> This is true. See a message about "Kernel support for ITE8758E" from a few  
> days back.
> This motherboard is a Shuttle SX58; rrd output from my hacked it87.ko and  
> sensors.conf can be seen here:
> http://sensors.cs.uchicago.edu/cgi-bin/kailash.rrdcgi
> 
> Attached are patches to it87.c (vs linux-2.6.35.4), sensors-detect (vs  
> lm-sensors-3.1.2), and a sensors.conf for this motherboard.

I am not sure about the patch itself. It doesn't sound like a good idea
to just add it to the code blindly without datasheet.

Adding chip detection to sensors-detect should be ok, though. 
Jean, any comments ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
