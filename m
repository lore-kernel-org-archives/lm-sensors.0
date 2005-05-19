From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: I2c Bus driver for National Geode
Message-Id: <3CEC0443.4ECF22FE@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CEA50F1.1010301@onair.dk>
In-Reply-To: <3CEA50F1.1010301@onair.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is the latest mail I have on the topic.
We never got any code.
You may wish to contact the national guy,
his email is in the middle.

	Subject: 
           Re: i2c bus for Geode SC1200
       Date: 
           Wed, 11 Oct 2000 21:22:36 -0400
      From: 
           "Mark D. Studebaker" <mds@paradyne.com>
   Reply-To: 
           linux-i2c@tk.uni-linz.ac.at
 Organization: 
           Paradyne Networks, Largo FL
        To: 
           linux-i2c@tk.uni-linz.ac.at
  References: 
           1 , 2 , 3




- Make sure it kinda/sorta works
- Make sure it meets kernel coding standards (see
Documentation/CodingStyle in any kernel)
- Make sure it has standard GPL boilerplate and your name and 
  National Semi in the comments at the top of the file so we know 
  that you and your company are really giving it away
- Write short files for the doc/ directories in i2c and/or lm_sensors
- Send it to us as a patch against the i2c-2.5.3 and/or the lm_sensors
2.5.3 tree
  (presumably you have an access.bus algorithm module for the i2c tree
and
  a 1200/1400 bus driver for the lm_sensors tree)

mds



James Mundenmaney wrote:
> 
> Hi
> I have completed development of this. Currently it
> supports ACCESS.BUS interfaces available in the
> SuperI/O module of Natioanl's Geode SC1200 and
> SC1400. There is no support for any GPIO in this.
> 
> I am interested in donating this code to the linux
> community. I would like to know more on how can i
> donate this code. Do you have any guidelines, general
> requirements, formats, documents, or any other relevent
> information i should know while preparing the code
> to donate.
> Thanks
> -james mundenmaney
> 
> "Mark D. Studebaker" wrote:
> 
> > James Mundenmaney at National Semi. (James.Mundenmaney@nsc.com)
> > is working on a driver for the Geode.
> >
> > chandra shekhar wrote:
> > >
> > > Hello,
> > >
> > > Any idea how i2c bus and GPIO pins are related ? Does this mean GPIO pins
> > > can be
> > > used to connect i2c buses ? Please let me know. Any additional pointers on
> > > this
> > > will be greatly appreciated.
> > >
> > > Thanks
> > > Chandra
> > >
> > > > -----Original Message-----
> > > > From: owner-linux-i2c@tk.uni-linz.ac.at
> > > > [mailto:owner-linux-i2c@tk.uni-linz.ac.at]On Behalf Of chandra shekhar
> > > > Sent: Wednesday, October 11, 2000 1:50 PM
> > > > To: linux-i2c@tk.uni-linz.ac.at
> > > > Subject: RE: i2c bus for Geode SC1200
> > > >
> > > >
> > > >
> > > > Hello,
> > > >
> > > > Can anyone has pointers to best generic i2c driver code which I can
> > > > customize for my
> > > > purpose ? Where can I get it ?
> > > >
> > > > TIA
> > > > Chandra
> > > >
> > > > > -----Original Message-----
> > > > > From: owner-linux-i2c@tk.uni-linz.ac.at
> > > > > [mailto:owner-linux-i2c@tk.uni-linz.ac.at]On Behalf Of Luca Pierantozzi
> > > > > Sent: Wednesday, October 11, 2000 1:25 PM
> > > > > To: linux-i2c@tk.uni-linz.ac.at
> > > > > Subject: i2c bus for Geode SC1200
> > > > >
> > > > >
> > > > > Have anyone allready written an i2c bus driver for Geode SC1200
> > > > > integrated in the kernel 2.2.14 or newer kernel versions?
> > > > >
> > > > >
> > > >
> > > >



phil@netroedge.com wrote:
> 
> I don't think we have any code yet for the Geode systems.  But, since
> they run Linux and are x86 compatible, it shouldn't be too hard if the
> documentation is available (National is pretty good about that).
> 
> I encourage you to start a bus driver for the Geode! :')  It might be
> compatible with an existing driver if the Geode is a close clone to
> something else (like Intel PIIX4), or it may be a bit-banging kind
> which I would suggest you start by copying and modifying another
> existing bit-banging driver.  Lastly, you may need to write a more
> custom driver (most likely).  Take a look through
> lm-sensors/kernel/busses/i2c-* for examples.
> 
> Phil
> 
> On Tue, May 21, 2002 at 03:51:45PM +0200, Thomas Graversen wrote:
> > Hi
> >
> > I need a I2C bus driver for the National Geode.
> > I can see that National is listed as a developer on this driver.
> >
> > Do you have any information about the state of this driver ?
> > Or just a contact within National.
> >
> > I would like to offer my help writing this driver.
> >
> >
> > Thomas Brinkmann Graversen
> >
> >
> 
> --
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
