From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: ATXP1 kernel patch
Message-Id: <20050206110338.14dff97c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D821D9.5030003@hasw.net>
In-Reply-To: <41D821D9.5030003@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sebastian,

First of all, sorry for the long delay. I have been really busy with
various other stuff these last two weeks.

Your latest version of the driver looks very good. I've only found these
minor things you could fix/improve:

I think that Greg will ask you to remove the inline history of the
driver. We don't much care about what happened to the driver before in
was committed into the kernel tree, and after that bitkeeper is the best
source for tracing changes.

> MODULE_LICENSE("GPL");
> MODULE_DESCRIPTION("System voltages control via Attansic ATXP1");
> MODULE_VERSION("0.5");

No MODULE_AUTHOR?

> static unsigned short normal_i2c[]= { 0x37, 0x4e, I2C_CLIENT_END };
> static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };

Missing space before "=". You would also move the call to
SENSORS_INSMOD_1 right below these lines, to make it clearer that the
array definitions are there for it.

> static int atxp1_write(struct i2c_client *client, unsigned char addr, unsigned char data) 
> {
> 	i2c_smbus_write_byte_data(client, addr, data);
> 	
> 	return 0;
> }

Why not return whatever i2c_smbus_write_byte_data returned instead? It
*can* return an error. I see little interest in this function overall,
it seems to just slow down the process by adding one more function call.

> 	if ((err = i2c_attach_client(new_client)))
> 	{

Coding style!

> 	dev_info(&new_client->dev, "Detected on %s. Using VRM: %d.%d\n", 
> 			 adapter->name, data->vrm / 10, data->vrm % 10);

dev_info will already give the id of the i2c adapter used, so the
"Detected on %s." is probably redundant.

That left apart I'm quite happy with your code. Feel free to send it to
Greg KH as a proper patch against 2.6.11-rc3-mm1. The patch should
include the required changes to drivers/i2c/chips/{Makefile,Kconfig}.

Thanks,
--  
Jean Delvare
