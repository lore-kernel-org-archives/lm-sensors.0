From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 04 Mar 2009 14:21:47 +0000
Subject: Re: [lm-sensors] Found unknown SMBus adapter 10de:0752 - how can I
Message-Id: <20090304152147.00b0a773@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200903041438.45638.zbiggy@o2.pl>
In-Reply-To: <200903041438.45638.zbiggy@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Zbiggy,

On Wed, 4 Mar 2009 14:38:45 +0100, Zbigniew Luszpinski wrote:
> Hello,
> 
> I have ASRock K10N78FullHD-hSLI 3.0 mainboard.
> lm_sensors 3.1.0->sensors-detect returns this:
> Found unknown SMBus adapter 10de:0752 at 0000:00:01.1.
> Sorry, no supported PCI bus adapters found.
> 
> lspci finds:
> 00:01.1 SMBus [0c05]: nVidia Corporation MCP78S [GeForce 8200] SMBus 
> [10de:0752] (rev a1)
> 
> How can I help supporting it?

Please send the output of "lspci -vv -s 00:01.1".

> I think this might be gpu temperature sensor.

Unlikely. The GPU temperature sensor, if you have any, would rather be
on one of the graphics adapter's I2C buses.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
