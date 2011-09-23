From: Josu Lazkano <josu.lazkano@gmail.com>
Date: Fri, 23 Sep 2011 11:28:48 +0000
Subject: [lm-sensors] Zotac ION ITX-G Synergy Edition
Message-Id: <CAL9G6WVbiEnRtAoA0Wzf7TLn0hXj3AQMtQrzSbC7keLFN795ow@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello all, this is my first post on the list. I am searching for some
help to check my board sensors. I have a ZOTAC ION ITX-G Synergy
Edition board with Debian Squeeze (2.6.32), it has MCP79 and it is
supported by lm-sensors.

I have some problems with my board voltage and I want to check all
sensors available. When I execute "sensors" this is the output:

# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +27.0=B0C  (crit =3D +90.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +29.0=B0C  (crit =3D +90.0=B0C)

This is just CPU temperature. Is it possible to get more info about my boar=
d?

I read some forums and I found this interesting things:

# modprobe i2c-dev
# modprobe i2c-nforce2
# echo "10de 0aa2" > /sys/bus/pci/drivers/nForce2_smbus/new_id
# i2cdetect -l
i2c-0	smbus     	SMBus nForce2 adapter at 4d00   	SMBus adapter
i2c-1	i2c       	cx23885[0]                      	I2C adapter
i2c-2	i2c       	cx23885[0]                      	I2C adapter
i2c-3	i2c       	cx23885[0]                      	I2C adapter
i2c-4	i2c       	NVIDIA i2c adapter 0 at 3:00.0  	I2C adapter
i2c-5	i2c       	NVIDIA i2c adapter 2 at 3:00.0  	I2C adapter
i2c-6	i2c       	NVIDIA i2c adapter 3 at 3:00.0  	I2C adapter

I don't know what I am doing with the echo command, but it looks like
it found some i2c devices.

I will appreciate any help on this, I read lots of webs but I don't
understand kernel/module compiling.

Thanks and best regards.

--=20
Josu Lazkano

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
