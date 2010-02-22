From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 22 Feb 2010 20:40:58 +0000
Subject: Re: [lm-sensors] [RFC PATCH v1 0/2] Add the sensors-config tool
Message-Id: <20100222204058.GC1937@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100219193821.GA1917@andre-laptop>
In-Reply-To: <20100219193821.GA1917@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 22, 2010 at 10:52:23AM +0100, Jean Delvare wrote:
> On Mon, 22 Feb 2010 10:04:17 +0100, Hans de Goede wrote:
> > Hi Andre,
> > 
> > On 02/19/2010 08:38 PM, Andre Prendel wrote:
> > > Hi Hans,
> > >
> > > here is an updated version of the sensors-config tool.
> > >
> > > Changes in v2:
> > >
> > > Now the tool parses the configuration pages from lm-sensors.org to
> > > determine the available config files.
> > >
> > > Further I've introduced some metadata to the config files. For the
> > > moment these are
> > >
> > > # board_vendor: BOARDVENDOR
> > > # board_name: BOARDNAME
> > >
> > > The related files are located under /sys/class/dmi/id. board_name can
> > > appear multiple times. So one config file can be used for several
> > > motherboards.
> > >
> > > The config files now will be installed under /var/lib and a matching
> > > config will be copied as automobo.conf to /etc/sensors.d.
> > >
> > 
> > Sounds good! Although I noticed that sensors-config.py still says:
> > config_dir = '/usr/local/share/sensors/conf
> > 
> > > And I added a short script for use at startup. The script looks for an
> > > suitable config and installs it otherwise it deletes an existing one.
> > >
> > > So, this should address most of your comments from last email.
> > >
> > 
> > Yes it does. Some remarks sofar (before answering your questions),
> > I would really like to see the initscript part of this not depend on
> > python. The last time this was discussed (in previous attempt to
> > come to a sensors-config tool), the idea was to (abuse) the database
> > a bit for this.
> > 
> > So for example my motherboard has:
> > board_vendor: "ASUSTeK Computer INC."
> > board_name: "M2N-SLI DELUXE"
> > 
> > /var/lib/sensors/conf could then contain a config file named:
> > "M2N-SLI Deluxe" (same name as on the wiki)
> > 
> > And then have a symlink (generated on the base of the metadata
> > in the config files):
> > "ASUSTeK Computer INC.-M2N-SLI DELUXE"
> > 
> > Then the whole dmi info -> config file matching can be done in a
> > simple sh script. This will not allow for the wildcard like
> > matching you have described, but in my experience that is not
> > really necessary. I've been doing a lot of dmi based quirks for
> > laptops, and I've seen only one case where the DMI data changed
> > on a BIOS update, and in that case we can simply have multiple
> > tags in the config file, what we could (and should) do is:
> > Strip all beginning and ending whitespace from the dmi info
> > 
> > This is easily doable in sh too.
> 
> If you really need to work on strings, this can be done in sh still,
> either using the shell expansion capabilities, or by using sed. But see
> below.
> 
> > > First question: What do you thing about the header keywords?
> > >
> > 
> > I think using the exact same names as under /sys/class/dmi/id
> > is a good idea.
> > 
> > > Maybe we could choose some of the available configs and add a
> > > header. So you and can test the tool by yourself.
> > >
> > 
> > Yes, I'll update them myself and give it a try. But before I do that
> > I wonder if I have the correct version of the script, above you write:
> >  > Now the tool parses the configuration pages from lm-sensors.org to
> >  > determine the available config files.
> > 
> > But in the sensors-config.py you attached I still see:
> > 
> > +configs = {
> > +    'ASRock' : ['AM2NF3-VSTA'],
> > +    'Abit' : ['AA8-DuraMAX', 'AA8XE-Fatal1ty', 'AI7', 'AN7',
> > +              'AN8-SLI', 'AV8', 'AX8', 'Aa7-Max', 'Ag7', 'KN9-Ultra',
> > +              'KV8-MAX3', 'Kv8Pro', 'VA-20'],
> > +    'Asus' : ['KFN4-DRE', 'M2N-SLI Deluxe'],
> > +    'DFI' : ['CFX3200-M2-G-infinity', 'Lanparty NF4 Expert',
> > +             'Lanparty UT 790FX'],
> > +    'Epox' : ['M1697', 'MF4-Ultra3'],
> > +    'Evga' : ['x58-SLI'],
> > +}
> > 
> > And this still gets used, did you perhaps accidentally send the old
> > version ?
> > 
> > > Second question: What should we use for the header data?
> > >
> > 
> > We should allow the following (for now):
> > board_vendor
> > board_name
> > board_version
> > 
> > sys_vendor
> > product_name
> > product_version
> > 
> > IOW, pretty much what you have already, and then if we
> > go the symlink route (I'm always open to suggestions to do
> > things differently), check for the following symlinks
> > (in order till one is found) :
> > $board_vendor-$board_name-$board_version
> > $sys_vendor-$product_name-$product_version
> > $board_vendor-$board_name
> > $sys_vendor-$product_name
> > 
> > > I'd suggest to only use a substring of the real dmi string. The
> > > sensors-config tool don't need an exact match of the string.
> > >
> > > For example
> > >
> > > # board_vendor: Asus
> > >
> > > matches for
> > >
> > > ASUS
> > > asus
> > > Asus
> > > ASUSTeK Computer INC.
> > > ...
> > >
> 
> I would be very cautious with substring matching. Some vendors have
> awfully short names (MSI, DFI or even HP or LG come to mind) and one of
> these will inevitably be a substring of another vendor's name someday,
> especially if you go for case-tolerant comparisons as suggested above.

You're totally right. See details in my reply to Hans' email.

> > 
> > That would work, but requires first reading all configuration
> > files into memory and extract the metadata before we can do the
> > matching, which as the database grows is going to become slow.
> > 
> > People won't like us reading say 200 files every startup, esp not
> > those people who try to get system startup time down to 5 seconds.
> > 
> > So I think a symlink like approach is better.
> > 
> > There is still one important piece missing here though, besides
> > automatically putting a config file in place, we also need to
> > make sure the necessary modules get loaded. IOW we need a metadata
> > keyword to specify which modules the config needs loaded (and with
> > which options if any), and then we need some init script to
> > load these modules (probably the same initscript as the
> > one doing the config file copying, or we could add the necessary
> > entries to /etc/sysconfig/lm_sensors from that script.
> 
> Beware that some device -> driver matching has changed over time, so
> you might have to take the kernel version into account. If you think
> this is overkill, then at least the driver needed for older kernel
> versions should be mentioned in a free comment. Or maybe we can
> introduce a specific syntax for fallback drivers (if the first driver
> doesn't exist then the second is tried... should cover most cases but
> maybe not all.)
> 
> > 
> > Regards,
> > 
> > Hans
> > 
> > p.s.
> > 
> > Note I have dmi data dumps for a lot of motherboards, ie for
> > all abituguru using motherboards. So once we have decided on
> > how to handle various things and on the metadata format, I can
> > update a lot of the config files in the wiki with the necessary
> > headers.
> 
> I have a lot of DMI data at hand, too.

Can you please send it to me?

Thanks,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
