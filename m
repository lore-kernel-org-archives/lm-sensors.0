From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: support needed
Message-Id: <20020805172410.L21034@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Humm.  Well, if the /proc directory is missing, then you either don't
have /proc file system support enabled in the kernel or it simply
isn't mounted.  If /proc/sys/dev is missing, then you are missing
sysctl support in the kernel.  If you have that, but are missing
/proc/sys/dev/sensors, then you are missing i2c /proc system support.  
If there isn't anything in /proc/sys/dev/sensors/ then you don't have 
any i2c/lm_sensors chip modules installed which have found supported 
hardware (in which you will need the appropriate bus drivers as well).


Phil

On Mon, Aug 05, 2002 at 11:25:27PM +0200, Sebesty?n Zolt?n wrote:
> I've done everything according to INSTALL files, but the
> /proc/sys/dev/sensors were missing (I've realised that before sending
> the previous emial but couldn't find why). Now I tried to install by RPM
> as described in i2c-2.6.4/RPM. This way I get some modprobe error but it
> could install 2 sensors in the/proc/sys/dev/sensors directory. The lm80
> and max1617. Running 'sensors-detect' gave succes for max1617, eeprom,
> via686a and lm80. Running 'sensors' I get some info: lm80 showed most of
> the voltages in the right way, fans and temp were some garbage. (I have
> no fans plugged to the mobo, the temp was something like -128). The
> max1617 sensor gave 0 everywhere. I couldn't figure out yet how to
> configure the /etc/sensors.conf file.
> The question is how could I add the via686a sensor driver to
> /proc/sys/dev/sensors . I think it could give me the right values when
> reading it.
> 
> 
> 
> phil@netroedge.com irta:
> 
> > 
> > You'll need to make sure you have things properly installed.  The 
> > /prof files are here: /proc/sys/dev/sensors   If those are missing, 
> > then you are missing some key kernel modules (i2-core, i2c-proc, 
> > driver modules, etc.)
> > 
> > There are some KDE and Gnome frontends to sensors, although we don't 
> > make them.  You can find them by search at www.freshmeat.net
> > 
> > Good luck!
> > 
> > 
> > Phil
> > 
> > On Mon, Aug 05, 2002 at 05:52:38PM +0200, Sebesty?n Zolt?n wrote:
> > > Dear Mr. Edelbrock!
> > > 
> > > I'm a new entry in this all Linux stuff, but I decided to learn it.
> > A
> > > few days ago I've installed SuSE7.2. Because my PC is overklocked a
> > > "little bit" I decided to install a hardware sensor monitoring
> > software.
> > > I've found lm sensors.
> > > I managed to install all the softwares needed (glib, pango, atk,
> > gtk+),
> > > I've patched into kernel (not module mode) the i2c drivers
> > (i2c-viapro)
> > > and wanted to do the same with lm sensors driver too. (I don't know
> > if
> > > it was succesfull).
> > > The i2c driver seems to work. After running the detect and probe I
> > get
> > > the chip according to the ones on my mainboard (Abit KT7A-VIA
> > > chipset-VT82C686B south bridge)
> > > When trying to run "sensors -c" I allways get the "Can't access
> > /proc
> > > file" error message. I've red all the Install guides and FAQs but
> > > couldn't find the solution.
> > > Please help me get out this stuck.
> > > Thank you in advance.
> > > An other question: Is there any grafical application for reading the
> > > temperatures that can be run automatically when KDE starts up?
> > > 
> > > Yours faithfully,
> > > 
> > > Z. SEBESTYEN
> > 
> > -- 
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> > 
> > 
> > 
> 
> 

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
