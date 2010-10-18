From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Mon, 18 Oct 2010 20:49:12 +0000
Subject: Re: [lm-sensors] Writing a .conf for Supermicro X8DTH-6F board
Message-Id: <20101018204911.GE32031@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=7hV6DxhkeMUF9Bu87g78uRUsdPuL1RCQxiYY9@mail.gmail.com>
In-Reply-To: <AANLkTi=7hV6DxhkeMUF9Bu87g78uRUsdPuL1RCQxiYY9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 18 Oct 2010, Kristleifur Da=F0ason wrote:
> Looking at the config for the C7X58 board, the overall setup seems to be
> different.

Yes, but the scaling is the same.  Just copy (and adjust the input number if
required) the lines for the +5V and +12V scaling from the C7X58 file.  You
don't need any scaling for the fans and for the other voltages, the kernel
driver already does it.

You can find a map for the chip register (the number in the docs supplied by
supermicro support) <-> sysfs in# in the driver source, I don't have it
handy right now.

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
