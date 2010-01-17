From: Andre Prendel <andre.prendel@gmx.de>
Date: Sun, 17 Jan 2010 19:14:06 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/1] Add the sensors-config tool
Message-Id: <20100117191406.GA1936@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100113205443.GA1856@andre-laptop>
In-Reply-To: <20100113205443.GA1856@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 17, 2010 at 05:30:36PM +0100, Hans de Goede wrote:
> Hi,

Hello Hans,

> >
> >What do you mean with this /etc/sensors-mb.conf? I don't know such a
> >config file. My plan was to copy the file to the /etc/sensors.d
> >directory. Configs in this directory overwrites the default
> >sensors.conf config file.
> >
> 
> Ah cool, yes that is pretty much the mechanism I had in mind, although
> I believe the file should be renamed to motherboard.conf on copy-ing, see
> below.

Ok.

> >I don't think we have to copy the file on every startup. It should be
> >enough to do this while installing lm-sensors or if an update is
> >available, right? But it's right, we need an trigger for the dmi-based
> >configuration. This could be done from 'make install'.
> 
> Erm most people won't be doing make install, but will be installing
> packages from a distro. Also think about cases like a livecd /
> live usb stick, where the hardware must be discovered automatically
> each boot, as it might be completely different.
> 
> An other scenario is the user swapping motherboard. So, just like
> the rest of a modern Linux distributions dynamically discovers
> all hardware each boot (swapping a video card or a motherboard
> does not require making any configuration files now a days), lm_sensors
> should dynamically discover and configure sensors (where possible).
> 
> So I disagree with "I don't think we have to copy the file on every startup."
> this is also why the file should have a standard name like
> /etc/sensors.d/auto-motherboard.conf
> 
> And I would even go as far as to say, that if no valid config was
> found that file should be removed.

Ok, you've totally convinced me. So I will add (or extend the
existing?) initscript to do this discovery.

> >>>What can you do with this tool?
> >>>
> >>>1. Download config files from lm-sensors.org and build an archive
> >>
> >>Hmm, I see it currently has a hardcoded list of config files, it would
> >>be good if it could discover the config files dynamically based on
> >>what is available on lm-sensors.org
> >
> >That's right. We could maintain a file similar to the format generated
> >by the wiki.
> >
> >   http://lm-sensors.org/wiki/Configurations
> >
> >Such a file is easy to parse and might contain only confirmed
> >configurations. Or do you know a way to scan remote directories via
> >HTTP?
> >
> 
> No not really, you could parse the index page(s), but
> having an easier to parse index file somewhere on lm-sensors.org is
> fine.

Ok.

> >>>2. Install this archive into the file system (the path is hard-coded
> >>>so far)
> >>
> >>I think the path should be under /var/lib, as the contents can
> >>change by running the same version of the tool again (if the
> >>wiki is updated).
> >
> >>
> >>I see currently this assumes that the name as on the wiki (in
> >>the url on the wiki), is the same as in the dmi info, this is
> >>not necessarily true.
> >
> >The names don't have to exactly match. The lookup is case-insensitiv
> >and the "wiki name" have to be part of the "dmi name". I did some test
> >with the data Rudolf Marek sent in the first thread.
> >
> >   http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018982.html
> >
> 
> Ok, the problem with this approach is that renaming wiki pages is not
> trivial AFAIK. So if the wiki page name is poorly chosen (or atleast
> chosen in such a way it does not match the DMI name), we are in trouble
> I really believe we need a way to embed the DMI strings to search
> for inside the configuration files.

Ok, I will will read some more about the sensors4mobo project and then
we can discuss an approach.

> >>There was a project similar to yours a
> >>while ago, which added magic comments to the config files
> >>to state for which dmi strings the config was valid. note
> >>that one config could be valid for multiple boards.
> >
> >Yes, one config for multiple boards doesn't work at the
> >moment. Probably we have to introduce some meta data for this
> >issue. Maybe we could support single boards for now and add this
> >feature later on!?
> >
> 
> If the one config file multiple boards case was the only problem, sure,
> but see above.
> 
> About all this also see:
> http://sensors4mobo.eberian.com/
> 
> Which is something similar to what you were doing now, but which was
> created as a project for private use and never got any bigger then that.
> 
> I'll forward you the announcement mail of this project.

> Regards,
> 
> Hans
> 

Thanks,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
