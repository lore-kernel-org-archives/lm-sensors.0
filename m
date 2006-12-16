From: david@ad5ey.net (David Holl)
Date: Sat, 16 Dec 2006 05:48:05 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <6b59d5890612152148v60974e99y6cac4e8d0d57e564@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yes, I checked out the head branch (
http://lm-sensors.org/svn/lm-sensors/trunk) when the stock version
(2.10.1in my Linux distro) didn't work -- and I confirmed the code in
the
repository was also incapable of printing anything out from the "sensors"
command.  (or sensord)

In brief summary: sensors & sensord would query libsensors, which had no
idea what the string "w83627dhg" mapped to so the library would return error
codes.  So in my patch, I added w83627dhg using w83627ehf as a model, to
libsensors, sensord and sensors.

If some one was successful in getting repository code for "sensors" to print
out temps+fans+voltages from w83627dhg, then they weren't using
lm-sensors/trunk, or support was removed from the time they used trunk to
the time I checked it out.  <shrug>  Even without modifying the lm-sensors
svn code, I could still see temps using gkrellm via the /sys interface, but
it felt "unclean" that I had to tell gkrellm how to scale the raw numbers
into voltages, etc -- separately from ksensors, xsensors, etc... I like the
centrality of libsensors for that -- hence my motivation for updating my
sensors.conf and consequently, investigating why did the "sensors" command
did not print anything out for my chipset.

(I was originally wondering if I still had a syntax error in sensors.conf,
so I used gdb+ddd to step through the program execution -- that's how I
found there was No support for *dhg in the repository code.)

- David


On 12/15/06, David Hubbard <david.c.hubbard at gmail.com> wrote:
>
> David,
>
> I remember seeing some emails a few weeks ago where people successfully
> detected the 627DHG using the latest sensors checked out from the source
> repository at lm-sensors.org. I haven't verified what's there, but I just
> thought I should point you in that direction. (I'm not even sure who to
> contact about sensorsd, libsensors, and sensors. Jean?)
>
> Glad to hear you're getting good results.
>
> David
>
> On 12/14/06, David Holl <david at ad5ey.net> wrote:
> > Hey David, I figured out why running the "sensors" didn't produce any
> output
> > for my DHG chip --- It wasn't added yet to svn:lm-sensors/trunk!  (or is
> > there a different svn branch I should've checked out?)
> >
> >  Anyhow, I attached a patch (svn diff) of the edits to add the DHG to
> > libsensors, sensors, and sensord.  I basically copied the EHF driver but
> > removed any reference to voltage sensor in9.  If you'd prefer, I could
> try
> > to maximize the code overlap between the EHF & DHG if yall think that'll
> > make the code easier to maintain in the long run.  But for now, I just
> made
> > the DHG functions & constants completely separate from (but near
> identical
> > to) their EHF equivalents.
> >
> > So now, running sensors or sensord actually prints my temps / voltages /
> fan
> > speeds.  :)
> >
> > - David
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061216/0b4da146/attachment.html 
