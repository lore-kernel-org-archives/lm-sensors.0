From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Temperature measure problem
Message-Id: <20030527121225.155c0a76.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030526190059.GA6938@siaco.id.pl>
In-Reply-To: <20030526190059.GA6938@siaco.id.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


> I have lm-sensors installed and configured, but I suppose it does not
> work properly.
>=20
> I have a water-cooled PC. When I turn off the cooling system BIOS
> shows CPU temp. growing starting from 25C with speed 3-4C per minute.=20
>=20
> When I do the same running linux and checking temperature using
> sensors- Temp2/CPU does not change, Temp3 grows, but starting from
> 33C, which(I suppose) is wrong.

Not necessarily. If you consider your Linux system takes approximatively
1 minute to start, and you then have to login and run the program, it
may take up to 1 more minute, which justifies 8 more degrees. One could
argue that it takes much less than 2 minutes, but on the other hand,
chances are it generates much more heat that just sitting in the BIOS
screen and do nothing.

But it also may be wrong, as you suppose. You may try to add a
converstion formula in your sensors.conf file to actually match your
BIOS readings better. Let us know if you come to something interesting.

> My motherboard is Gigabyte GA-60XT Rev. 1.1, chipset Intel I815EP. I'm
> not sure if I'm using correct chip module (it87) (I couldn't find I815
> in doc/chips/*), but that is the only one detected  by sensors-detect.

It seems to be GA-6OXT (o not zero). The docs say it has an Intel
FW82815EP, an Intel 82801BA and an iTE8712. So the modules you loaded
look correct. You may decide not to load the i2c-i801 module though,
since it doesn't add any interesting piece of information.

I saw you added a bus statement to your config file. Why that? Never saw
this used.

As far as the voltages are concerned, the errors you have are known and
there are several comments about how to fix them in the config file, as
mentionned in ticket 923.
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=923

So I think you're not so far from having everything working OK. Some
config file tweaking should do it.

--=20
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
