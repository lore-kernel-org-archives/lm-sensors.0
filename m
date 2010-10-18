From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Mon, 18 Oct 2010 18:55:43 +0000
Subject: Re: [lm-sensors] Writing a .conf for Supermicro X8DTH-6F board
Message-Id: <20101018185542.GC32031@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=7hV6DxhkeMUF9Bu87g78uRUsdPuL1RCQxiYY9@mail.gmail.com>
In-Reply-To: <AANLkTi=7hV6DxhkeMUF9Bu87g78uRUsdPuL1RCQxiYY9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Mon, 18 Oct 2010, Kristleifur Daðason wrote:
> I am trying to get fan control running on a Supermicro X8DTH-6F
> motherboard[*]. Supermicro tech support provided me with a specification
> file for the hardware monitor chip, a Winbond W83795AG. I have built and
> installed lm-sensors 3.2.0. I'm trying to understand how to convert the
> specifications into a good lm-sensors config file.
> 
> Here's an excerpt from the specifications file:
> 
> —
> Windbond W83795AG, Slave Address=0x2f (0x5E in 8-Bit format)
> ==============================> Fan1 Fan Speed, Offset 0x2e           RPM = 84375/Data
> CPU1 Voltage, Offset 0x10             Voltage = Data* 0.008
> CPU2 Voltage, Offset 0x11             Voltage = Data* 0.008
> +5V Voltage, Offset 0x1f              Voltage = Data* 0.008 * (40/10)

Looks like the one for the C7X58 I recently asked to be added to the
lm-sensors' wiki.

http://www.lm-sensors.org/wiki/Configurations/SuperMicro/C7X58

You may need to adjust the labels, as you have two CPU packages on that
board.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
