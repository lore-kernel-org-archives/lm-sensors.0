From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 15 Dec 2006 05:48:45 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <4dfa50520612142148n753321b9lfdfc082916574e4f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David,

I remember seeing some emails a few weeks ago where people
successfully detected the 627DHG using the latest sensors checked out
from the source repository at lm-sensors.org. I haven't verified
what's there, but I just thought I should point you in that direction.
(I'm not even sure who to contact about sensorsd, libsensors, and
sensors. Jean?)

Glad to hear you're getting good results.

David

On 12/14/06, David Holl <david at ad5ey.net> wrote:
> Hey David, I figured out why running the "sensors" didn't produce any output
> for my DHG chip --- It wasn't added yet to svn:lm-sensors/trunk!  (or is
> there a different svn branch I should've checked out?)
>
>  Anyhow, I attached a patch (svn diff) of the edits to add the DHG to
> libsensors, sensors, and sensord.  I basically copied the EHF driver but
> removed any reference to voltage sensor in9.  If you'd prefer, I could try
> to maximize the code overlap between the EHF & DHG if yall think that'll
> make the code easier to maintain in the long run.  But for now, I just made
> the DHG functions & constants completely separate from (but near identical
> to) their EHF equivalents.
>
> So now, running sensors or sensord actually prints my temps / voltages / fan
> speeds.  :)
>
> - David

