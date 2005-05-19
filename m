From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: as99127f bug?
Message-Id: <20031130182028.60668193.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031130134504.142f7cde.khali@linux-fr.org>
In-Reply-To: <20031130134504.142f7cde.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> You're right. Make user_install installed /etc/sensors.conf
> I reviewed the config file.
> As stated for the a7n8x-deluxe motherboard, the a7n8x-x needs:

Ha ha, that's funny. I think I'me the one who added this note some
months ago, and I wouldn't remember that now. I've added the A7N8X-X to
the list.

> What I don't understand is why you don't make smaller config files
> based on motherboards instead of one huge config file with all the
> chipsets configured. As more than one motherboard can use a chipset
> differently, this only huge config file will be surely wrong for some
> users
> 
> Having a 30 line sensors.asus_a7n8x-x.conf nicely preconfigured is
> better than a -probably wrong for my motherboard- 400 lines
> sensors.conf Also, this would incourage users to submit more config
> files

You're perfectly right. Everybody agrees on that. What not everybody
agrees on is how to solve the problem. Attempts have been made to set a
database up, where people could submit their configuration files, but
these projects never got completed.

You must understand that if we were to distribute individual
configuration files, we would soon be flooded by people sending their
configuration file or wanting us to update them. There are about 150
different motherboards available in my country at the moment. What's
more, the configuration does not only depend on the motherboard name. It
depends on the motherboard revision, additional thermal sensors, and
fans. We just can't handle that many configuration files in our main
package. When we add or modify a feature for a given chipset, we don't
want to have twenty different files to modify. I think this is why the
solution of a database was prefered, but that too requires time and
hardware.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
