From: Mauro Molinari <mauromol@tiscali.it>
Date: Tue, 08 Jan 2013 15:16:12 +0000
Subject: Re: [lm-sensors] Help to make lm-sensors work with an Asus TUSL2-C
Message-Id: <50EC383C.2050501@tiscali.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <50DB2017.8010403@tiscali.it>
In-Reply-To: <50DB2017.8010403@tiscali.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Il 08/01/2013 14:50, Jean Delvare ha scritto:
>> Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
>> Found unknown chip with ID 0x5953
>>       (logical device 9 has address 0x290, could be sensors)
>
> Very strange, I wouldn't expected an unknown Super-I/O chip on such an
> old board. Can you find the chip's name by visual inspection of the
> board or from the documentation?

The visual inspection on the board confirmed it has an Asus AS99127F 
chip. I don't think I have any other thermal sensor on the board... I 
just have a Pentium III 1000EB (Coppermine) CPU, an ancient nVidia Riva 
TNT AGP card, a Realtek Gigabit LAN card and two Silicon Image 3512 SATA 
controllers. Any idea on what that Super-I/O chip might be?

Mauro.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
