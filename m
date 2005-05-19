From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors on Itanium
Message-Id: <20040302223222.1101f46a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Step 1: find if you do have a SMBus PCI device. "/sbin/lspci | grep
> > -i smbus" should help.
> 
> Nope:
> 
> [root@gb0010 lm_sensors-2.8.4]# lspci|grep -i smbus
> [root@gb0010 lm_sensors-2.8.4]# lspci
> 00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 02)
> 00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 02)
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
> 00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
> 00:1f.1 IDE interface: Intel Corp. 82801DB IDE U100 (rev 02)

That one (82801DB) is known for its hability to hide itself. Give a try
to the p4b_smbus driver (look in lm_sensors2/prog/hotplug), it might be
what you need.

If it works, you'll need to run sensors-detect again after loading the
module (IIRC).

> > My guess goes to a SMSC 47B27x. It isn't a full hardware monitoring
> > chip, but has Fan control capabilities.
> 
> You win the prize!  Looking on the board, I saw SMSC LPC47B272, ADM
> 1026, and ADM 211 chips.  I didn't recognize any others, but that
> doesn't mean there weren't any.

The ADM1026 is your monitoring chip. It is I2C-only, so it has to be on
the supposedly hidden 82801 SMBus.

> Yes, I'm willing to try the updated version.  What more information do
> you need?

Get it from here:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect

chmod +x and give it a try :)

> Here's what I got from sensors-detect after I solved the i2c-dev
> problem:

i2c-dev is needed to probe I2C busses. Since you don't have any detected
yet, it doesn't change anything. But it will if the p4b_smbus module
works.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
