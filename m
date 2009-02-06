From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 06 Feb 2009 08:44:53 +0000
Subject: Re: [lm-sensors] [RFC 0/4] Add support for multiple configuration
Message-Id: <20090206094453.5e172818@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090204225329.0ebb0fef@hyperion.delvare>
In-Reply-To: <20090204225329.0ebb0fef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

On Thu, 5 Feb 2009 20:10:35 -0600 (CST), Matt Roberds wrote:
> On Thu, 5 Feb 2009, Jean Delvare wrote:
> > On Wed, 4 Feb 2009 20:29:40 -0600 (CST), Matt Roberds wrote:
> 
> > We could have option "-v" to print this information, or maybe a
> > dedicated mode (--test-config) that would solely test that the
> > configuration files are OK, without actually reading sensor values.
> 
> There might even be two levels to this option.  The first would just
> test the config files and list their names; this is for user confidence
> and automated testing.  The second might print details of the decisions
> sensors is making as it parses through the various config files,
> something like "make -d" does.
> 
> Whatever the details, I think there needs to be *some* way to let the
> user know which config files are being examined.  (WARNING, potential
> religious debate: Have you ever tried to configure qmail?  :)  )

I see your point, and I agree it can be useful for debugging (both the
configuration files and the library itself). Whether we need this level
of power for something as simple as libsensors is an open question.
Whether we can implement this without API changes is another. Whether
I have any work time to invest in developing this feature is yet
another. If someone (you?) want to start working on this...

> > This however is somewhat beyond the scope of my patch set. I think it
> > is important to get support for multiple configuration files quickly,
> > because other improvements depend on that. The improvement of error
> > reporting can wait.
> 
> I agree.  It might be helpful to add a couple of lines to the
> documentation about what to do if problems with multiple config files
> are suspected (like tell the user to chmod 644 /etc/sensors.d/*.txt or
> similar),

I am a notorious hater of vague error messages which attempt to give
you general hints. Short but accurate error messages are much, much
better.

If the configuration files can't be read, we should return an error
code which says just that (SENSORS_ERR_ACCESS_R). Not that I expect
this to be a frequent problem: I can't remember a single case in the 4
or 5 years I've spent on the lm-sensors project.

> and that more debugging information about multiple config
> files is being worked on.

This is the kind of documentation which doesn't really help the user
and tend to get outdated quickly. For things that are being worked on,
the user should ask our ticket system.

> >> The basic problem seems to be that you fopen the file and then pass a
> >> FILE* down to the parser; I don't think you can work backwards to the
> >> file name once you have a FILE*.
> >
> > Correct. This is however not the primary problem I had in mind. What
> > worries me more is the prototype of sensors_default_parse_error(),
> > because it is part of the API so we can't change it.
> 
> Just call the new function sensors4_default_parse_error() and slowly
> deprecate the old one.  Should only take about 10 years.  :)

I'd rather avoid "sensors4" in the name. But something like
sensors_parse_error_wfn() (for "with file name") would make sense.
However the main problem IMHO is not to come up with a new function.
The problem is that we don't want to call both the original function
(sensors_parse_error) and the new one (sensors_parse_error_wfn or
whatever) on parse error. We should call just one. So there needs to be
some logic to decide which one. As I understand it, user-defined
functions should always be preferred, and the new function (with file
name) should be preferred over the old one (no file name). This should
be doable but we'll have to pay attention and make sure we don't
accidentally break any application.

> > The fact that the user-space programs pass a FILE* rather than a file
> > name is what makes it possible to read the configuration file from
> > stdin (in sensors) or virtually from anywhere the user wants (sandbox,
> > network...)
> 
> It makes "sensors -c /dev/null" work, which is sometimes useful if
> you've completely confused yourself, or are trying to get debug reports
> from users.  Maybe in lieu of this, there should be a debug command-line
> option to ignore all the config files.

Option "-c" is useful way beyond this. It lets the user test custom
configuration files before making them the system default. It can also
be used to have per-application configuration files.

One sad limitation of this mechanism is that you can only pass one
custom configuration file. This is a libsensors API limitation
(sensors_init takes only one file). Could be worked around with an
additional library function sensors_add_config(). This new function
could even take a file name rather than a FILE* as a parameter, to
solve the error reporting problem we have been discussing before.

That being said, I am not sure how needed this feature is in practice.
It's a little hard to tell right now, with support for multiple
configuration files at the library level being just in its early stage.

> > The need to let the user know in which configuration file a parse
> > error occurred only exists when the user did _not_ pass a FILE* for
> > the configuration. If he/she did, then libsensors will only process
> > that specific file (or whatever it actually is) so there is no need
> > for disambiguation.
> 
> I can think of a case where it might be useful to both pass in a FILE*
> and have libsensors read from existing files.  Say somebody has two
> files in the libsensors config directory, one for the motherboard and
> one for a graphics card with a temperature sensor on it.  Then they get
> a new graphics card.  They can move or chmod out the config file for
> their old graphics card, but maybe they want libsensors to still read
> the config file for their motherboard while they experiment with passing
> in the correct configuration for their new graphics card via a FILE*.
> (Of course, they can get the same effect by just putting trial versions
> of their new graphics card config file in the libsensors directory.)
> I don't know if this is common or something that should be supported,
> but it might be a possibility.

This example doesn't sound too relevant to me. During the test phase
you can certainly live without the rest of the configuration.

> > I don't really want to abuse sensors_error() for informative or debug
> > messages. But stderr isn't an option either. As I said above, the
> > problem is that we really lack the proper channel to return non-error
> > information down to the library user.
> 
> Maybe libsensors needs to develop something like errno/perror() from the
> C library.  You don't want to *waste* memory, but in these latter days
> you don't have to limit yourself to a single int, either.

We already have sensors_strerror() for this purpose. As I wrote above,
the problem isn't to report errors, this works fine already. The
problem is how to report informative messages.

> Or maybe it needs to make some kind of private log file (that is, not
> sent to syslog) that interested user programs can parse.  File locking
> and race conditions are annoying but at least it would get the
> information out there _somewhere_.

Libraries writing logs directly don't look terribly right. I believe
it's the application job to do that. What's missing is the channel
between the library and the application to carry the information and
debug messages.

Then again I'm fairly we can live without that. As a matter of fact we
did live without that for 10 years, and I can't remember anyone asking
for it. Now I'm not saying it can't be useful. I'm saying it's probably
something to write down and keep in mind for later, when we write the
next big, incompatible version of libsensors.

> Odd thought: Some C preprocessors support things like
> 
> #pragma emit "This is the debug version of foo.h"
> 
> which causes the message to print at preprocess time; would something
> like that be of any use for the libsensors config files?  OTOH, printing
> stuff is usually easier for humans to understand, not code that uses the
> library.  (I have to remember that a big use case of lmsensors is via
> user code linked to the library.  I don't use it that way myself - I
> just look at the output of 'sensors' - but many people do use it that
> way.)

I don't really want to touch the configuration file scanner and parser
if I can avoid it. That's really not an area I am familiar with.

> > The more critical problem is that errors might happen later.
> 
> Ah, this is a point I hadn't picked up on.  I agree that this makes the
> problem a little trickier.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
