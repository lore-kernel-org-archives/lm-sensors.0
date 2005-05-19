From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040206235950.7999b128.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Attached you'll find the changes for kernel 2.4.x. Updated
> documentation will follow later.

Great. I'll take a look. It's too late for lm_sensors 2.8.4, but I'll
commit it to CVS right after the release.

> Well, I could ask my contact person at FSC, but he is on vaccation
> till mid of February. Would you like a copy of the Poseidon spec
> too?

The more specs, the better, especially if we are to port these drivers
to Linux 2.6. See how many bugs we found already, there's no reason
there are not a few more hiding.

> The BIOS sets reasonable values and the default sensors.conf doesn't
> override them. Maybe a "WARNING: read documentation or you may damage
> your system!" might be useful to add to the configuration file, heading
> the supplied sample settings.

Yes, I is a good idea (already part of your patch as I can see). And you
even provided a patch for libsensors. Lovely :)

Right after 2.8.4 is released (which should happen really soon now),
I'll check your patch and commit it, then I'll review the 2.6 driver one
last time and send it to Greg KH for inclusion into Linux 2.6.3. One
more chip driver, yeehoo :)

Thanks a lot for the good work.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
