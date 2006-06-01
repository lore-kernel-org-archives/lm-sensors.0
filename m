From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 01 Jun 2006 12:11:51 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded
Message-Id: <20060601121151.GE5739@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger:

* Roger Lucas <roger at planbit.co.uk> [2006-05-31 15:58:49 +0100]:
> We use "sensors" as a back-end system for a GUI.  We didn't need to pick
> this exact naming convention, but the example names in the sensors.conf file
> were not consistent and we needed to pick a standard.  We didn't want to
> have to re-write the GUI if we suddenly had a motherboard with an extra fan
> input, so we needed a way for the sensor names to make sense to the GUI so
> that it could adapt its display accordingly.  What I posted was our solution
> to the problem.
> 
> There are many other solutions, but that was the one that we chose.  As a
> general comment, however, in the *nix world, pretty much any utility that
> only runs on the command line has to consider itself as a source of data for
> other tools and should really try to make some effort to offer output (or at
> least an optional output mode) which makes parsing its output by other
> scripts easy.  All the LVM tools, for example, offer such modes as do tools
> like dmidecode.  On the other hand, some of the SAMBA tools such as
> smbstatus do not, and their output is very hard to reliably parse under
> certain conditions.  I know which style of tools I prefer to work with...
> 
> I admit that the command-line mode is widely used in Linux, but so are
> KDE/Gnome/xxxx-window-manager GUIs.  As I understand it, "sensors" is the
> recommended tool for access to the lm-sensors subsystem, then its output
> should be parseable so that the GUI can re-structure it as required.  As it

Really, you should use libsensors directly if that's your goal.  We're not
in the habit of making gratuitous changes to the output of sensors(1), but
AFAIK it's not considered a requirement.

BTW: the output of 'sensors -u' might be easier for you to parse.

> currently stands, there are a range of different description strings in
> sensors.conf.  At the very least, if a centralised archive of sensors.conf
> files is to be created then we need a naming convention for the sensor
> values in just the same way that the sensor names themselves follow a
> standard.  If we don't then anyone "downstream" of sensors will have a
> horrible job trying to work out exactly what sensors they have and how to
> display them.  If we want, we could have a short machine-style version and a
> longer human style version.  I really don't mind, but for my needs, I need a
> name that can be parsed easily and which is consistent across all the
> motherboards that I am using (or may use in the future).

The autoconfigurator will still allow custom /etc/sensors.conf I'm sure.  Is
there something else you need?

> > -----Original Message-----
> > From: Hans de Goede [mailto:j.w.r.degoede at hhs.nl]
> > Sent: 31 May 2006 15:36
> > To: Roger Lucas
> > Subject: Re: [lm-sensors] LM Sensors autoconfig tool project awarded as
> > google SOC project
> > 
> > Roger Lucas wrote:
> > > Hi All,
> > >
> > 
> > Hi,
> > 
> > Thanks for the config files, maybe its an idea to add them to the wiki?
> > 
> > >
> > > We picked a naming convention for the sensors based on a prefix of:
> > > 	V_	voltage sensor
> > > 	T_	temperature sensor
> > > 	F_	Fan sensor
> > >
> > > There then followed a unique identifier string - if it was a voltage
> > rail
> > > described as a target voltage (e.g. 3.3v rail) then we followed a
> > typical
> > > engineering practice of removing the "." and replacing it with "V" for
> > > voltages.  A suffix of "P" indicated a positive voltage and "N" a
> > negative
> > > voltage - again common practice in schematics and similar.  If there
> > were
> > > multiple sensors reading the same type of parameter (e.g. multiple CPUs)
> > > then a suffix of _0, _1, _2, ... was added.  This made the parser
> > extremely
> > > simple.
> > >
> > 
> > I'm not sure I would want togo this way, I don't find the resulting
> > names very pretty, with the Abit uGuru driver I've tried to match the
> > names in sensors.conf to the BIOS names I think that that is what a less
> > experienced user would expect.
> > 
> > Whats the advantage of this, why would you want to parse the output with
> > a script?
> > 
> > Regards,
> > 
> > Hans

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


