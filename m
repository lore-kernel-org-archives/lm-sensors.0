From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Installation report/Feedback
Message-Id: <20031207232808.4f91d5d2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207183312.GA855@GreenHouse.dorchain.net>
In-Reply-To: <20031207183312.GA855@GreenHouse.dorchain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Unknown EEPROM type (0)
> (...)
> Unknown EEPROM type (32)

This is a known bug and is fixed in CVS.

> - On the first try, sensors-detect segfaulted. I tried to reboot,
> which failed because hda had write errors. Only a complete unplug from
> mains for the usual 30s made it boot again. As I used this machine
> for some time before witha wild mix of stock kernel, nvidia and
> lm_sensors modules, I'm not too sure what caused this. After the
> reboot (which definitivly brought kernel sources and running kernel
> in sync) is just works now, so IMHO having sources, config and
> running kernel the same seems to be important.

Yes, it is very important, especially since version 2.8.1, because a
change in the i2c structures make original modules and newly compiled
module incompatible.

> - My bttv card run fine as ever.

Great :)

> - On the sensors output, the fan1 is reported at 3307RPM by the BIOS,
>   CPU Temp as 47 degrees.

Try the following compute line in sensors.conf ("as99127f-*" section):
  compute fan1 @/2, @*2.0

As for temp2, there are three possible formulae in sensors.conf, try the
other ones.

Also, you can probably add ignore lines for fan2, fan3 and temp3.

> - sensors-detect produced a line # no driver for Winbond W83L785TS
> yet, ask us for one! and so I do ;-)

OK, will write a driver if I can find some spare time.

Thanks a lot for providing feedback, this is very appreciated :)

BTW, your chipset isn't really an AS99127F, but an ASB100. We now have a
separate driver for it in CVS, you should give it a try. The i2c patch
you used is OK, you just need to download and install lm_sensors2 CVS:
http://secure.netroedge.com/~lm78/download.html#cvs
We still need to update sensors-detect to reflect that, so don't trust
it when it says you should use the w83781d driver, and use asb100
instead.

Thanks again :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
