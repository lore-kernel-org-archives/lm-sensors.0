From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 18 Aug 2007 15:05:12 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <20070818170512.1d3f33b2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 17 Aug 2007 21:44:50 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Support more bus types (part 1 of 2). Originally libsensors was very
> > i2c-centric. Make it more neutral so that we can cleanly support
> > additional bus types such as SPI or One-Wire.
> > 
> > This first part introduces sensors_bus_id, and updates
> > sensors_chip_name to use it.
> 
> Looks good to me, can you commit these to svn before the end of the weekend, 
> monday I'll be back at work and there I have several machines to test with, so 
> if you can get all your changes into svn before monday then I can give svn a 
> good testing with various setups @ work.

Sure, I plan to commit them on Saturday evening or Sunday morning,
unless someone finds problem before then.

If possible, your testing should include passing funky chip names on the
sensors' command line, and/or using a configuration file with tricky
bus and chip statements.

BTW, thanks a lot for reviewing and testing my libsensors4 patches,
this is very much appreciated.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
