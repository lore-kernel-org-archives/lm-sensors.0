From: Mauro Molinari <mauromol@tiscali.it>
Date: Tue, 22 Jan 2013 08:29:49 +0000
Subject: Re: [lm-sensors] Help to make lm-sensors work with an Asus TUSL2-C
Message-Id: <50FE4DFD.2030700@tiscali.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <50DB2017.8010403@tiscali.it>
In-Reply-To: <50DB2017.8010403@tiscali.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Il 11/01/2013 21:55, Jean Delvare ha scritto:
> The W83627GF seems to exist as well and it is entirely possible that
> both have the same ID. The lack of "H" in the names indicates the lack
> of hardware monitoring function in these chips.
>
> I have added detection to sensors-detect. Even if the chip has no
> hardware monitoring features, identifying it is good, as it clarifies
> the situation.
>
> Mauro, feel free to try:
> http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>
> It should now detect your Super-I/O chip. But the change is informative
> only, it won't change the driver list for your board.

Hi Jean,
I confirm the detection works with the updated sensors-detect:

Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Winbond W83627SF/GF Super IO'
     (no hardware monitoring capabilities)

Thanks again for your support on this issue.

Mauro.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
