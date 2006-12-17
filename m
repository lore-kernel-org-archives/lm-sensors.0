From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 17 Dec 2006 09:59:20 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20061217105920.2a5a09e8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Fri, 15 Dec 2006 00:05:40 -0500, David Holl wrote:
> Hey David, I figured out why running the "sensors" didn't produce any output
> for my DHG chip --- It wasn't added yet to svn:lm-sensors/trunk!  (or is
> there a different svn branch I should've checked out?)

Your analysis is correct.

> Anyhow, I attached a patch (svn diff) of the edits to add the DHG to
> libsensors, sensors, and sensord.  I basically copied the EHF driver but
> removed any reference to voltage sensor in9.  If you'd prefer, I could try
> to maximize the code overlap between the EHF & DHG if yall think that'll
> make the code easier to maintain in the long run.  But for now, I just made
> the DHG functions & constants completely separate from (but near identical
> to) their EHF equivalents.
> 
> So now, running sensors or sensord actually prints my temps / voltages / fan
> speeds.  :)

Good. However, as I answered in ticket #2157, I would prefer a much
smaller patch reusing all the w83627ehf structures rather than
duplicating them. Can you please submit a patch doing this?

Thanks,
-- 
Jean Delvare

