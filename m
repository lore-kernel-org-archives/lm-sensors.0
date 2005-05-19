From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Issues with lm_sensors on Intel SE7501cw2
Message-Id: <3F973A45.400C1998@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

agreed. if sensors-detect finds it at 0x290,
then w83781d should find it at 0x290. Don't know what's wrong here.

As I said earlier, if it isn't at 0x290, w83781d won't find it.

Jean Delvare wrote:
> 
> > I agree that Super I/O detection is quite reliable and that the
> > confidence for these should be increased to 9.
> > Khali, feel free to do it if you get to it before I do.
> 
> Done.
> 
> That said, shoudln't the w83781d driver handle the ISA Winbond W83627HF?
> That's not the first report of it being detected but not working,
> although it works OK with the w83627hf driver. I know that the w83627hf
> driver is prefered in that case, still we have to be consistent. If
> sensors-detect says the w83781d driver can be used, it has to work.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
