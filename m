From: roger@planbit.co.uk (Roger Lucas)
Date: Thu, 01 Jun 2006 12:54:25 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded
Message-Id: <20060601125243.CE77E12ED4@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark M. Hoffman [mailto:mhoffman at lightlink.com]
> Sent: 01 June 2006 13:12
> To: Roger Lucas
> Cc: 'Hans de Goede'; 'LM Sensors'
> Subject: Re: [lm-sensors] LM Sensors autoconfig tool project awarded as
> google SOC project
> 
> Hi Roger:
> 
> * Roger Lucas <roger at planbit.co.uk> [2006-05-31 15:58:49 +0100]:
> > We use "sensors" as a back-end system for a GUI.  We didn't need to pick
> > this exact naming convention, but the example names in the sensors.conf
> file
> > were not consistent and we needed to pick a standard.  We didn't want to
> > have to re-write the GUI if we suddenly had a motherboard with an extra
> fan
> > input, so we needed a way for the sensor names to make sense to the GUI
> so
> > that it could adapt its display accordingly.  What I posted was our
> solution
> > to the problem.
> >
> > There are many other solutions, but that was the one that we chose.  As
> a
> > general comment, however, in the *nix world, pretty much any utility
> that
> > only runs on the command line has to consider itself as a source of data
> for
> > other tools and should really try to make some effort to offer output
> (or at
> > least an optional output mode) which makes parsing its output by other
> > scripts easy.  All the LVM tools, for example, offer such modes as do
> tools
> > like dmidecode.  On the other hand, some of the SAMBA tools such as
> > smbstatus do not, and their output is very hard to reliably parse under
> > certain conditions.  I know which style of tools I prefer to work
> with...
> >
> > I admit that the command-line mode is widely used in Linux, but so are
> > KDE/Gnome/xxxx-window-manager GUIs.  As I understand it, "sensors" is
> the
> > recommended tool for access to the lm-sensors subsystem, then its output
> > should be parseable so that the GUI can re-structure it as required.  As
> it
> 
> Really, you should use libsensors directly if that's your goal.  We're not
> in the habit of making gratuitous changes to the output of sensors(1), but
> AFAIK it's not considered a requirement.
> 

If you are writing C code then yes, and for the KDE/Gnome/XXX example I gave
this is true.  We also use web monitoring pages, however, and these are
generated from PHP and shell scripts.  I don't know how to directly access
libsensors from PHP or a bash script.

> BTW: the output of 'sensors -u' might be easier for you to parse.

Definitely much easier to parse than the plain "sensors" output.  But
according to the man page, the "-u" treats all chips as unknown.  The output
from "sensors -u", however, correctly identifies the chips and uses the
correct sensors.conf section, so I think the man page needs an update here
to more clearly describe what the "-u" option does.

> 
> > currently stands, there are a range of different description strings in
> > sensors.conf.  At the very least, if a centralised archive of
> sensors.conf
> > files is to be created then we need a naming convention for the sensor
> > values in just the same way that the sensor names themselves follow a
> > standard.  If we don't then anyone "downstream" of sensors will have a
> > horrible job trying to work out exactly what sensors they have and how
> to
> > display them.  If we want, we could have a short machine-style version
> and a
> > longer human style version.  I really don't mind, but for my needs, I
> need a
> > name that can be parsed easily and which is consistent across all the
> > motherboards that I am using (or may use in the future).
> 
> The autoconfigurator will still allow custom /etc/sensors.conf I'm sure.
> Is
> there something else you need?

Is there a spec anywhere for this autoconfigurator?  Han's early link is
still very thin on the details and the Google SOC doesn't list this sensors
project that I can see.


> 
> Regards,
> 
> --
> Mark M. Hoffman
> mhoffman at lightlink.com

Thanks,

Roger


