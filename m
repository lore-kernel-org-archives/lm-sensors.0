From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Sep 2012 20:43:22 +0000
Subject: Re: [lm-sensors] No such subfeature known when sensors -s
Message-Id: <20120917204322.GA3258@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5051971B.7030608@iol.ie>
In-Reply-To: <5051971B.7030608@iol.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 17, 2012 at 06:19:34PM +0100, MrNice wrote:
[ ... ]

> I had a look on the NCT5577D datasheet but it's not for me ;-)
> So I tried your commands in a file named cpufan:
> #!/bin/bash
> isaset -y -f 0x2e 0x87
> isaset -y -f 0x2e 0x87
> isaset -y 0x2e 0x2f 0x7 0x8
> isaset -y 0x2e 0x2f 0xf0 0xb2
> isaset -y 0x2e 0x2f 0xf1 0xf2
> 
> I have this error
> sudo ./cpufan
> Data mismatch, wrote 0x87, read 0xff back.
> Data mismatch, wrote 0x87, read 0x09 back.
> 
> Nothing more with sensors
> What can I do?

I am out of ideas. At this point I would need a board to be able to play with
it. Reboot and live with it...

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
