From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 08 Nov 2005 16:47:49 +0000
Subject: [lm-sensors] i2c -dev and i2c bus driver
Message-Id: <4370C89C.5090309@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
In-Reply-To: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> yes, that's what I loaded after booing and using i2c-dev driver to talk to
> our i2c device, for the devices connnected to the ACB 2 of superIO from the
> microporcessor, every thing works. however, for the device, connected to
> ACB 1 of superIO, I won't be able to talk to them.

Hmm bad is that I dont know the hardware.
But from the driver i can see:


         for (i = 0; i < MAX_DEVICES; ++i) {
                if (base[i] > 0)
                        rc = scx200_acb_create(base[i], i);
        }

And there are two base defined.
So this could create two busses.

When you modprobe i2c-dev and the scx driver you should see
in

i2cdump -l

Listed two ACB busses
Do you see them?

If so I would suggest:

1) plug your device to ACB 2 where it works
   do: i2cdetect (put acb2 bus number here)
       i2cdump (put acb2 bus number here) 0xyourdeviceaddr

2) repeat with plugged to ACB1

Please post results here. Also, please point me to some documenattion of ACCESS bus... I'm really very short with my time...

Thanks
Regards
Rudolf
