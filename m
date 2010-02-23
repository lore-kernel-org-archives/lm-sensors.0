From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 23 Feb 2010 20:35:50 +0000
Subject: Re: [lm-sensors] [RFC PATCH v1 0/2] Add the sensors-config tool
Message-Id: <20100223203550.GD1928@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100219193821.GA1917@andre-laptop>
In-Reply-To: <20100219193821.GA1917@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 22, 2010 at 10:26:47PM +0100, Hans de Goede wrote:
> Hi,

Hello,

> On 02/22/2010 09:28 PM, Andre Prendel wrote:

> >Nevertheless, we can do the auto-config stuff from a shell script.
> >
> 
> Ack, I also advocate for 2 parts, well 3 parts using your division, what
> I envision is:
> 
> 1) A python tool to create / manipulate / download / print configuration
>    (archives).
> 
> 2) A sysv style initscript which does the actual autoconfiguration on boot
>    based on an installed, extracted database.

Ok, that's fine with me.

> >At the moment the tool is looking under CONFIG_DIR for a directory
> >BOARD_VENDOR and into this directory for a file BOARD_NAME. This could
> >be done as well as from shell script. Yes, we can use sed for regex
> >matching but with the python way installing the automobo.conf is a
> >one-liner encapsulated inside the config tool.
> >
> 
> I understand doing the installation of automobo.conf is easier from
> python, but we will get lots of complaints if we try to get distro
> to carry an initscript which depends on python as a default enabled
> initscript.

Now I'm convinced we shouldn't have a python dependency in the initscript.

> >>IOW, pretty much what you have already, and then if we
> >>go the symlink route (I'm always open to suggestions to do
> >>things differently), check for the following symlinks
> >>(in order till one is found) :
> >>$board_vendor-$board_name-$board_version
> >>$sys_vendor-$product_name-$product_version
> >>$board_vendor-$board_name
> >>$sys_vendor-$product_name
> >
> >Do we need the symlinks at all if we use the exact dmi vendor/board name?
> >
> 
> Well, we can have one config file which is valid for multiple versions /
> variants (think extra slots, extra onboard nic, whatever) boards, I
> think we should not have multiple copies of that file then, using
> a hierarchy with multiple levels is fine by me too, but then:
> 1) How will you deal with board / produty version (we are going to need
>    these to uniquely identify some boards)
> 2) Are you going to handle having multiple board_name's in the same
>    config file.

I like the multiple level directory layout because printing all
vendors or all boards for a specific vendor is a simple directory
listing (see -l and -b options). BTW I like a clean layout.

Of course we can encode the version by another directory level or in
the board name, couldn't we?

To avoid multiple files for the same board we could place the symlinks
into root directory. This layout would also avoid the problem of
identical board names of different vendors.

> >>>I'd suggest to only use a substring of the real dmi string. The
> >>>sensors-config tool don't need an exact match of the string.
> >>>
> >>>For example
> >>>
> >>># board_vendor: Asus
> >>>
> >>>matches for
> >>>
> >>>ASUS
> >>>asus
> >>>Asus
> >>>ASUSTeK Computer INC.
> >>>...
> >>>
> >>
> >>That would work, but requires first reading all configuration
> >>files into memory and extract the metadata before we can do the
> >>matching, which as the database grows is going to become slow.
> >
> >As mentioned above, the tool is looking for the directory BOARD_VENDOR
> >and a file BOARD_NAME into this directory. If found the file is copied
> >to /etc/sensors.d as automobo.conf. So if the directoy layout under
> >/var/lib once is made, the metadata isn't required.
> >
> 
> Ack, but if we do the sub string matching, then the autoconf part of the
> tool will need to build a database to search through to see if there are
> any substring matches, if the strings are encoded in the filenames, then
> the tool won't need to actually parse the files, but it will still need
> to do readdir call(s) to get the names from the filename, where as with
> a 1 on 1 relation (be it with or without translations for spaces), a single
> stat call suffices to see if there is a config file.

Ok, sub string matching is obsolete.

> About the translation of spaces to _ in the filenames, I'm not in favor
> of this. filenames with spaces will work fine if the sh script is
> properly written and I would like to avoid invoking numerous sub processes
> in the sysv shell script if possible. OTOH if this becomes too much of a
> pain we can go the replace whitespace by _ route, because it is not
> going to be that much of a penalty.
> 

Regards,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
