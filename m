From: Matt Roberds <mattroberds@cox.net>
Date: Fri, 06 Feb 2009 02:10:35 +0000
Subject: Re: [lm-sensors] [RFC 0/4] Add support for multiple configuration
Message-Id: <Pine.LNX.4.64.0902051933220.16253@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090204225329.0ebb0fef@hyperion.delvare>
In-Reply-To: <20090204225329.0ebb0fef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 5 Feb 2009, Jean Delvare wrote:
> On Wed, 4 Feb 2009 20:29:40 -0600 (CST), Matt Roberds wrote:

> We could have option "-v" to print this information, or maybe a
> dedicated mode (--test-config) that would solely test that the
> configuration files are OK, without actually reading sensor values.

There might even be two levels to this option.  The first would just
test the config files and list their names; this is for user confidence
and automated testing.  The second might print details of the decisions
sensors is making as it parses through the various config files,
something like "make -d" does.

Whatever the details, I think there needs to be *some* way to let the
user know which config files are being examined.  (WARNING, potential
religious debate: Have you ever tried to configure qmail?  :)  )

> This however is somewhat beyond the scope of my patch set. I think it
> is important to get support for multiple configuration files quickly,
> because other improvements depend on that. The improvement of error
> reporting can wait.

I agree.  It might be helpful to add a couple of lines to the
documentation about what to do if problems with multiple config files
are suspected (like tell the user to chmod 644 /etc/sensors.d/*.txt or
similar), and that more debugging information about multiple config
files is being worked on.

>> The basic problem seems to be that you fopen the file and then pass a
>> FILE* down to the parser; I don't think you can work backwards to the
>> file name once you have a FILE*.
>
> Correct. This is however not the primary problem I had in mind. What
> worries me more is the prototype of sensors_default_parse_error(),
> because it is part of the API so we can't change it.

Just call the new function sensors4_default_parse_error() and slowly
deprecate the old one.  Should only take about 10 years.  :)

> The fact that the user-space programs pass a FILE* rather than a file
> name is what makes it possible to read the configuration file from
> stdin (in sensors) or virtually from anywhere the user wants (sandbox,
> network...)

It makes "sensors -c /dev/null" work, which is sometimes useful if
you've completely confused yourself, or are trying to get debug reports
from users.  Maybe in lieu of this, there should be a debug command-line
option to ignore all the config files.

> The need to let the user know in which configuration file a parse
> error occurred only exists when the user did _not_ pass a FILE* for
> the configuration. If he/she did, then libsensors will only process
> that specific file (or whatever it actually is) so there is no need
> for disambiguation.

I can think of a case where it might be useful to both pass in a FILE*
and have libsensors read from existing files.  Say somebody has two
files in the libsensors config directory, one for the motherboard and
one for a graphics card with a temperature sensor on it.  Then they get
a new graphics card.  They can move or chmod out the config file for
their old graphics card, but maybe they want libsensors to still read
the config file for their motherboard while they experiment with passing
in the correct configuration for their new graphics card via a FILE*.
(Of course, they can get the same effect by just putting trial versions
of their new graphics card config file in the libsensors directory.)
I don't know if this is common or something that should be supported,
but it might be a possibility.

> I don't really want to abuse sensors_error() for informative or debug
> messages. But stderr isn't an option either. As I said above, the
> problem is that we really lack the proper channel to return non-error
> information down to the library user.

Maybe libsensors needs to develop something like errno/perror() from the
C library.  You don't want to *waste* memory, but in these latter days
you don't have to limit yourself to a single int, either.

Or maybe it needs to make some kind of private log file (that is, not
sent to syslog) that interested user programs can parse.  File locking
and race conditions are annoying but at least it would get the
information out there _somewhere_.

Odd thought: Some C preprocessors support things like

#pragma emit "This is the debug version of foo.h"

which causes the message to print at preprocess time; would something
like that be of any use for the libsensors config files?  OTOH, printing
stuff is usually easier for humans to understand, not code that uses the
library.  (I have to remember that a big use case of lmsensors is via
user code linked to the library.  I don't use it that way myself - I
just look at the output of 'sensors' - but many people do use it that
way.)

> The more critical problem is that errors might happen later.

Ah, this is a point I hadn't picked up on.  I agree that this makes the
problem a little trickier.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
