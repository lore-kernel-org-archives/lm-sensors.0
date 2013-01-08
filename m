From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 08 Jan 2013 15:22:17 +0000
Subject: Re: [lm-sensors] Help to make lm-sensors work with an Asus TUSL2-C
Message-Id: <20130108162217.0bc2dd1b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <50DB2017.8010403@tiscali.it>
In-Reply-To: <50DB2017.8010403@tiscali.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 08 Jan 2013 16:16:12 +0100, Mauro Molinari wrote:
> Il 08/01/2013 14:50, Jean Delvare ha scritto:
> > Very strange, I wouldn't expected an unknown Super-I/O chip on such an
> > old board. Can you find the chip's name by visual inspection of the
> > board or from the documentation?
> 
> The visual inspection on the board confirmed it has an Asus AS99127F 
> chip. I don't think I have any other thermal sensor on the board... I 
> just have a Pentium III 1000EB (Coppermine) CPU, an ancient nVidia Riva 
> TNT AGP card, a Realtek Gigabit LAN card and two Silicon Image 3512 SATA 
> controllers. Any idea on what that Super-I/O chip might be?

It should be a chip of about the same size as the Asus chip, with
"Winbond" written on it. Probably close to the last PCI slot.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
