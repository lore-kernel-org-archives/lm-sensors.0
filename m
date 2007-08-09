From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 09 Aug 2007 05:58:59 +0000
Subject: Re: [lm-sensors] lm_sensors + max1668
Message-Id: <46BAAD23.4060202@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello Hurky,

Sorry for the delay, please CC the list too. I'm CCing the driver author.

Hurky wrote:
> Hello Rudolf,
> 
> I've two Maxim max1668 temperature sensors on the SMBus and by now
> I cannot read them out under linux. I've searched a lot of time for
> a solution but it seems that there is no finished and running kernel
> module avialable. I've tryed with Christophs module script but I'm
> still novice in the part of compiling and doing this kind of stuff.
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018784.html
> 
> sensors-detect give me this output:
> 
> Driver `max1668' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus nForce2 adapter at 5000'
>     Busdriver `i2c-nforce2', I2C address 0x18
>     Chip `Maxim MAX1668' (confidence: 7)
>   * Bus `SMBus nForce2 adapter at 5000'
>     Busdriver `i2c-nforce2', I2C address 0x19
>     Chip `Maxim MAX1668' (confidence: 7)
> 
> Did YOU have success charging the module and reading out the maxim's ?

Lets try this:

modprobe i2c-dev
i2cdump -l

This should list your busses, take a number from that which corresponds to bus
above. I will take 0 as example

then do:

i2cdump -y 0 0x18
i2cdump -y 0 0x19

And send it back here. We can take a look what is wrong.

> If yes please help me a little bit to get it work.

Yep we will ;)


> Thank you! and regards from Spain,

Greetings from Prague, Czech Republic!

Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGuq0j3J9wPJqZRNURAnWcAKCakca6+TWvA9nspfpjykbrA+LlRQCgvqC4
/6PN9QoDjZ7HgL4efoWiSJ8=lNHk
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
