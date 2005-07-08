From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 08 Jul 2005 09:42:14 +0000
Subject: [lm-sensors] W83792D & Overtemperature LED on Supermicro
Message-Id: <42CE2E40.9050609@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
In-Reply-To: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Something in our driver triggers the whole chip reset. We are not touching the reset bit so it must be
something else. You have revision 13 of the chip and we have datasheet of 12 revision.

I would suggest following:

static int
w83792d_write_value(struct i2c_client *client, u8 reg, u8 value)
{
        i2c_smbus_write_byte_data(client, reg,  value);
        return 0;
}

remove this funcs and replace with this one:

static int
wrt(struct i2c_client *client, u8 reg, u8 value)
{
        i2c_smbus_write_byte_data(client, reg,  value);
	if (i2c_smbus_read_byte_data(client, 0x40)!=3) {
	printk("Chip RESET occured when written %x to %x reg\n",value,reg);
	}

        return 0;
}

And add to top of this file:

#define w83792d_write_value(a,b,c)  { printk("write called from line %d\n",__LINE__); wrt(a,b,c) }

So we can track what call it was.

Proposed funcs were not tested but I think you get the idea. Register 0x40 is master config reg. After reset it defaults to value 0x1 and it is before 0x3.
Lets hope the chip will reset when writing into it and not reading by some odd reason.

Regards

Rudolf
