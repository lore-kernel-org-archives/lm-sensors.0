From: Andre Prendel <andre.prendel@gmx.de>
Date: Fri, 15 Jan 2010 20:14:05 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/1] Add the sensors-config tool
Message-Id: <20100115201405.GA1908@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100113205443.GA1856@andre-laptop>
In-Reply-To: <20100113205443.GA1856@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 14, 2010 at 11:35:33AM +0100, Hans de Goede wrote:
> Hi Andre,

Hi Hans,

Thanks for your feedback :)

> Thanks for working on this!
> 
> On 01/13/2010 09:56 PM, Andre Prendel wrote:
> >Hello Jean, Hans,
> >
> >a long time ago we've spoken about "DMI-based
> >configuration". Unfortunately the last half year I only had a very
> >reduced amount of time. But today I send my first proposal (patch) for
> >this issue :)
> >
> >A few words...
> >
> >The tool is written in Python. I hope you can live with
> >this although this is another language in the lm-sensors project. I like
> >the object oriented modules of Python and IMHO Python should be
> >installed on every machine in a default installation.
> >
> 
> Hmm, I don't mind the archive download and building tool being written
> in python. But eventually there should also be a bash script which
> can be run from the systems initscript which will automatically
> find a config based on dmi and if found copy it to /etc/sensors-mb.conf
> (which can then be included from the regular sensors.conf). I don't
> think this part should be in python as on most systems none of the
> other initscripts use python.

What do you mean with this /etc/sensors-mb.conf? I don't know such a
config file. My plan was to copy the file to the /etc/sensors.d
directory. Configs in this directory overwrites the default
sensors.conf config file.

I don't think we have to copy the file on every startup. It should be
enough to do this while installing lm-sensors or if an update is
available, right? But it's right, we need an trigger for the dmi-based
configuration. This could be done from 'make install'.

Just a few words about my intention how to use the config-tool.

The fetching and archive building part is only for config maintainers
(e.g. you, Jean or me). If a new config is available or something
changed a maintainer builds a new archive. This archive should be
provided via lm-sensors.org.

User can download the archive and use the config-tool the install
it. We could improve the tool to inform the user for new updates and
download the archive automatically.

> >What can you do with this tool?
> >
> >1. Download config files from lm-sensors.org and build an archive
> 
> Hmm, I see it currently has a hardcoded list of config files, it would
> be good if it could discover the config files dynamically based on
> what is available on lm-sensors.org

That's right. We could maintain a file similar to the format generated
by the wiki.

  http://lm-sensors.org/wiki/Configurations

Such a file is easy to parse and might contain only confirmed
configurations. Or do you know a way to scan remote directories via
HTTP?

> >2. Install this archive into the file system (the path is hard-coded
> >so far)
> 
> I think the path should be under /var/lib, as the contents can
> change by running the same version of the tool again (if the
> wiki is updated).

It seems you're right again. The FHS says data in /usr/share must be
purely static data. I will change the path.

> >3. List the vendors off the available configs
> >4. List the board configs of a vendor
> >5. Install a config by vendor and board name
> >6. Show your systems' DMI data
> >7. Search a config based on the DMI data and install them
> 
> I see currently this assumes that the name as on the wiki (in
> the url on the wiki), is the same as in the dmi info, this is
> not necessarily true.

The names don't have to exactly match. The lookup is case-insensitiv
and the "wiki name" have to be part of the "dmi name". I did some test
with the data Rudolf Marek sent in the first thread.

  http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018982.html

> There was a project similar to yours a
> while ago, which added magic comments to the config files
> to state for which dmi strings the config was valid. note
> that one config could be valid for multiple boards.

Yes, one config for multiple boards doesn't work at the
moment. Probably we have to introduce some meta data for this
issue. Maybe we could support single boards for now and add this
feature later on!?

> >8. Remove the configs from the file system
> >
> >NOTE: This is an early version. There are plenty of ToDos and probably
> >some bugs. This is a request for comments what do you thing about the
> >tool.
> >
> 
> Disclaimer: I have not tested it.
> 
> What I think, well I like that someone is working on this, and I like
> that you are using the wiki as "database", as with previous attempts
> part of the problem was that both a tool and a website needed to
> be developed simultaneously.
> 
> As for comments, see above.
> 
> Thanks & Regards,
> 
> Hans

Thanks,
Andre

PS: Sorry for the subject mismatch (RFC PATCH vs. PATCH RFC) :)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
