From: dsaxena@mvista.com (Deepak Saxena)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: add eeprom i2c driver
Message-Id: <20030325215051.GA25641@xanadu.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E806AC6.30503@portrix.net> <20030325172024.GC15823@kroah.com> <20030325212753.GA21498@xanadu.az.mvista.com> <20030325213206.GD17249@kroah.com>
In-Reply-To: <20030325213206.GD17249@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Deepak Saxena <dsaxena@mvista.com>, Jan Dittmer <j.dittmer@portrix.net>, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Mar 25 2003, at 13:32, Greg KH was caught saying:
> > From my experience in seeing I2C eeproms on embedded systems, most 
> > people end up writing a custom little driver that does just what I 
> > said above: read/write/llseek. The eeprom driver should export the data
> > for each eeprom through /dev/eeprom interfaces This also allows for someone
> > to add a driver for larger EEPROMs (I have 512byte eeproms on some embedded 
> > boards) w/o having to add even more entries to sysfs for the remaining data.
> 
> I think the "one binary file" will work for all of your varied systems,
> right?

Yes. :)

Thanks,
~Deepak

> thanks,
> 
> greg k-h
> 

-- 
Deepak Saxena
MontaVista Software - Powering the Embedded Revolution - www.mvista.com
