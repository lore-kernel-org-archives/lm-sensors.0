From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 25 Sep 2011 17:08:18 +0000
Subject: Re: [lm-sensors] Zotac ION ITX-G Synergy Edition
Message-Id: <20110925170818.GA1944@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAL9G6WVbiEnRtAoA0Wzf7TLn0hXj3AQMtQrzSbC7keLFN795ow@mail.gmail.com>
In-Reply-To: <CAL9G6WVbiEnRtAoA0Wzf7TLn0hXj3AQMtQrzSbC7keLFN795ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Sep 25, 2011 at 12:27:48PM -0400, Josu Lazkano wrote:
[ ... ]
> 
> Thanks for your reply, I have loaded the lm90 module:
> 
> $ lsmod | grep lm90
> lm90                    7728  0
> i2c_core               12795  9
> i2c_dev,lm90,ds3000,cx23885,v4l2_common,videodev,nvidia,tveeprom,i2c_nforce2
> 
> Sorry, but I have no idea how to compile the driver for my kernel.
> Could you help with some steps?
> 
Download all files from http://khali.linux-fr.org/devel/misc/lm90 into some directory,
then run
	make
	sudo make install
	sudo modprobe -r lm90
	sudo modprobe lm90

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
