From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 21 Nov 2005 22:05:03 +0000
Subject: [lm-sensors] +5V line... and Stdby fixable?
Message-Id: <4382367C.2030809@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <ea9ff50b0511180346s58c38f67p465b9e2adad74bc@mail.gmail.com>
In-Reply-To: <ea9ff50b0511180346s58c38f67p465b9e2adad74bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Filip Tsachev wrote:
> Hello,
> 
> I'd like to ask just one question about my +5V line.
> 
> so I made the following modification for my it8712 chip on GB-7N400E-l
> board (AMD k7 TB 2GHz):
> 1. I uncommented compute in2( 3.3V was x2)
> 2. set sensor 1 2,
> set sensor 2 3
> 3. I need to fix my +5V line, please any help will be really appreciated!
> 
> I have a fortron 300W (390W p.m.p.o.) so my+ 5V should be really stable ~
> 
> This are the results: (pretty sharp except for +5V and - lines...)

Hi sorry for the delay,

It seems we are all busy theese days.
> +5V:       +4.22 V  (min =  +4.76 V, max =  +5.24 V)   ALARM

Hmm perhaps you need better formula. Without asking MB manufacturer is it hard to get one. (There is nearly no chance for answer)

Jean any suggestions?

I'm quite busy but maybe next weekend if you drop me a mail I can try to reverse engineer the BIOS
and see how it is computed. (You can find me on IRC channel #linux-sensors on freenode.net)

> how can I exclude from monitoring the following:
> eeprom-i2c-0-51
> Adapter: SMBus nForce2 adapter at 1c00
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       512

This will be dropped soon or maybe is in CVS version.

> also I would like to have hddtemp? inside sensors? right now I use a
> separate tool "hddtemp"
> looks like this: /dev/hda: HDT722516DLAT80:  37?C (Hitachi 160GB 7200rpm PATA)

You can write your own hwmon driver for it and submit it here.

regards
Rudolf
