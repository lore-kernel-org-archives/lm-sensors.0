From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 06 Apr 2007 18:51:36 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <46169B1E.7050108@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

jk wrote:
> Hans de Goede wrote at about 18:21:10 +0200 on Friday, April 6, 2007:
>  > jk wrote:
>  > >> jk wrote:
>  > >>> I have a p4pe board with the asb_100 sensor running under linux 2.6.20.
>  > >>>
>  > >>> I now notice that the sensors location varies between
>  > >>> /sys/bus/i2c/drivers/asb100/0-002d and /sys/bus/i2c/drivers/asb100/2-002d
>  > >>> between reboots.
>  > >>>
>  > >>> This creates problems for me since I use sensord and a crontab entry to read the
>  > >>> sensors but now the location of the sensors in /sys varies with each boot.
>  > >>>
>  > >>> Is this a bug?
>  > >>> If not is there a way to fix the location of the sensor directory in the /sys
>  > >>> heirarch? (Otherwise, I will need to write some klugey shell script to try to
>  > >>> find the location at boot-up and then automatically change the crontab entry
>  > >>> accordingly.
>  > >>>
>  > >>> Thanks!
>  > >>>
>  > > 
>  > > Agreed.
>  > > 
>  > > Note that I also seem to have an 'extra' layer in that my devices sit
>  > > in an asb100 subdirectory (see below) whereas yours seem to sit right
>  > > in the /sys/i2c/bus/devices directory. So I guess that mine already
>  > > has some 'naming' built in.
>  > > 
>  > > 
>  > > I guess my *practical* questions in the meantime until naming gets
>  > > changed are the following:
>  > > 
>  > > 1. Why does the device number prefix change from '0' to '2' on
>  > >    different boots? Also, why does the sensor jump to 2-002d when
>  > >    there is NO 0-002d or 1-002d sensor? i.e. I would have thought you
>  > >    would only get 2-002d if there were already a (conflicting) 0-002d
>  > >    or 1-002d sensor.
>  > > 
>  > 
>  > The first number is the i2c bus, the second the address on the bus.
> 
> Just to make sure I understand, it then seems that in my current
> config, I have the following:
>         i2c bus #0 (p4pe motherboard): 
>                 asb100 (0-002d)
>                 asb100 subclient (0-0048)
>                 asb100 subclient (0-0049)
>                 eeprom (0-0050)
>                 eeprom (0-0051)
>                 eeprom (0-0052)
>         i2c bus #1: (Winfast 2000XP Deluxe card)
>                 tveeprom (1-0050)
>                 tuner (1-0061)
>         i2c bus #1: (pcHDTV-5500??)
>                 eeprom (2-0050)
> 
>  > >    Note I believe I have only one asb100 sensor (corresponding to my
>  > >    p4pe motherboard) but maybe the numbering gets mixed in with other
>  > >    i2c devices (I have a nVIdia GeForce Ti 4600 graphic board, a
>  > >    Winfast 2000XP Deluxe analog TV card, and a pcHDTV 5500 digital TV
>  > >    card).
>  > > 
>  > > 2. Why did none of this happen in the 2.4 kernels where I just used
>  > >    as99127f-i2c-0-2d all the time?
>  > > 
>  > 
>  > Because modules where loaded there by initscripts / through /etc/modules.conf 
>  > and that tended to happen in a fixed order. Now adays when udev registers 
>  > itself as hotplug handler the kernel starts firing hotplug events for al 
>  > already detected hardware and the drivers get loaded in parrallel, so there is 
>  > no fixed order in the loading of the i2c bus masters, and thus no fixed 
>  > addresses for the asb, as the address consists of busnumber-busaddress
> 
> I am then surprised that many more people are not having this
> problem. It would seem then that this "race condition" would apply to
> anybody who had more than one i2c bus.
> Perhaps though there are not many people who are using sensord/rrd
> though... (however, if you are and set up the crontab as recommended
> then you will get cron email errors mailed to you every 5 minutes :)
> 
>  > > 3. What if anything can I do to 'fix' the sensor to a specific prefix?
>  > >    (Perhaps something analogous to what one does in modprobe.conf with
>  > >    the index=n option or maybe something to force the boot order to be
>  > >    consistent)
>  > > 
>  > 
>  > You could try to disable / blacklist non used i2c masters, but you have atleast 
>  > the smbus controller on your board and one for your tvcard which you both need, 
>  > another hack would be to modprobe the smbus driver from your rc.sysinit script 
>  >   before udev gets started.
>  > 
>  > Regards,
>  > 
>  > Hans
> 
> I believe that I need all 3 i2c masters.
> For the rc.sysinit hack, I assume you mean just insert a statement of
> form:
>         modprobe asb100
> 
> Is that right?
> 

About right, but you need to modprobe the driver for your smbus controller / 
the i2c master on your motherboard, as that is the one jumping from 0 - 2, the 
asb100 is always at 2d

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
