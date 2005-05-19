From: zayets@comcast.net (Rob)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: Please list which file to etc/rc* file modiify
Message-Id: <1100735082.2625.10.camel@Oneniisama>
List-Id: <lm-sensors.vger.kernel.org>
References: <1100659621.2956.12.camel@Oneniisama>
In-Reply-To: <1100659621.2956.12.camel@Oneniisama>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2004-11-17 at 00:36, Jean Delvare wrote:
> [please reply to the list, not to me]
> 
> Hi Rob,
> 
> > sensors works when i tell it sensors in the terminal, but the values are
> > off (double), Per the FAQ it tells me to modify the conf file.  I have
> > an asus A7N8XE-deluxe, which i know uses the asb100 file. When I modify
> > the file in that area, cut the fan info to divide by 2, and swap the
> > labels for CPU and Motherboard.  Save, then do sensors-s then rebooted,
> > and none of my changes to effect.
> 
> This is expected, because rebooting will reset the hardware monitoring
> chip configuration. "sensors -s" needs to be run after each boot.

Tried this again, upon reboot typed sensors -s then ran sensors, still
no change.  This appears to be an issue that many are having, in a
webforum i particpate in, we are all encountering sensors not responding
to changes in the conf file.  One user even deleted the conf file and
replaced it with a dummy file, and sensors still worked.  As of now, we
still cant find out how to talk to sensors and modify its output and
computations.
> 

Have now removed all sensors additions to files, and sensors still loads
and works, even at system boot, it tells me loading module lm sensors. 
So sensors will work without having information in other files (ie you
dont need to modify any rc files to get it to work), but there is still
the issue of how do you talk to lm sensors if its not reading the conf
file?

Rob
> > asb100-i2c-1-2d
> > (...)
> > M/B Temp: +52?C (high = +0?C, hyst = +0?C)<------really is cpu temp
> > CPU Temp (Intel):
> > +40?C (high = +45?C, hyst = +40?C) <----40 is likely the mobo temp
> > Power Temp:
> > +127?C (high = +0?C, hyst = +0?C)
> > CPU Temp (AMD):
> > +25?C (high = +80?C, hyst = +75?C)
> >
> > I dont know what the intel and amd  temps are. I have an AMD processor,
> > and it runs about 55 degrees.
> 
> I think you are correct. temp1 is CPU temp, temp2 is motherboard temp,
> and temp3 and temp4 are not used. You can hide them by using the
> following lines in /etc/sensors.conf:
>   ignore temp3
>   ignore temp4
> Make sure to add these in the asb100-* section.
> 
> > To load everything that is needed, add this to some /etc/rc* file:
> >
> > Which file? there are many folders and files.
> >
> > #----cut here----
> > # I2C adapter drivers
> > modprobe i2c-nforce2
> > # I2C chip drivers
> > modprobe asb100
> > modprobe smbus-arp
> > modprobe eeprom
> > # sleep 2 # optional
> > /usr/local/bin/sensors -s # recommended
> > #----cut here----
> >
> >
> > I think that this may be why its not recognizing my changes, becuase it
> > doesnt know where in the conf file to look?  The etc/rc additions
> > perhaps tell it where to look in the conf file, but I dont know which
> > etc/rc file to add too, there are rc1-6 folders, and each has many
> > files.  Which folder and file do I add too?
> 
> The exact thing to do depends on the distribution, which is why
> sensors-detect cannot give more details.
> 
> If your distribution has a file named /etc/rc.d/rc.local, the most simple
> solution is to put the lines there. That's what I do.
> 
> Else, if your distribution has an /etc/sysconfig directory, then you
> should let sensors-detect write its configuration file here (it should
> ask you), then get the lm_sensors.init script in lm_sensors2/prog/init
> and copy it to /etc/rc.d/init.d. Then you should be able to enable the
> execution at boot time by using the chkconfig command of Mandrake.
> 
> This only holds if you installed lm_sensors manually. If you installed it
> from Mandrake packages, then the init script should already be present
> in /etc/rc.d/init.d, and all you need to do is create the config file
> with sensors-detect, and maybe activate the script by using chkconfig.
> Check the manual page of chkconfig for details about how you need to run
> it to enable services at boot time.
> 
> I cannot tell more since I am not using a Mandrake or a similar
> distribution myself. Hopefully you'll figure out the rest by yourself.
> 
> Jean
