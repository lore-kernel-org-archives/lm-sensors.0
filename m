From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 08 Jul 2005 12:28:22 +0000
Subject: [lm-sensors] W83792D & Overtemperature LED on Supermicro
Message-Id: <42CE5527.1050203@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
In-Reply-To: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again.

> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 10: 00 00 64 64 93 00 00 13 00 ff 00 00 05 00 00 b3    ..dd?..?....?..?
> 20: a8 a9 d1 bd 1e c8 d3 2b 25 26 ff af 96 af 96 e2    ???????+%&.?????
> 30: b9 ce a8 2f 13 d9 b1 cc a7 50 4b ed ed ed 1f a6    ???/?????PK?????
> 40: 03 00 20 9f 7f ff ff 33 2f 13 88 80 07 ff 80 5c    ?. ??..3/????.?\
                                   ^^^^
Both subclients are disabled.
It seems our driver

          val = w83792d_read_value(new_client, W83792D_REG_I2C_SUBADDR);
                data->lm75[0]->addr = 0x48 + (val & 0x07);
                data->lm75[1]->addr = 0x48 + ((val >> 4) & 0x07);
        }

Does not expect this.  You must be using force_subclients parameter to get around this?!
Maybe setting the subclients reset the chip.

  if (data->lm75[0]->addr = data->lm75[1]->addr) {
                dev_err(&new_client->dev, "duplicate addresses 0x%x "
                                "for subclients\n", data->lm75[0]->addr);
                err = -ENODEV;
                goto ERROR_SC_2;
        }


Please make sure you are not using force_subclients param,
To allow driver load comment out calling of w83792d_detect_subclients.

Regards

Rudolf
