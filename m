From: david@ad5ey.net (David Holl)
Date: Fri, 15 Dec 2006 05:05:40 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <6b59d5890612142105g58a06942head4db3fd88993b7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey David, I figured out why running the "sensors" didn't produce any output
for my DHG chip --- It wasn't added yet to svn:lm-sensors/trunk!  (or is
there a different svn branch I should've checked out?)

Anyhow, I attached a patch (svn diff) of the edits to add the DHG to
libsensors, sensors, and sensord.  I basically copied the EHF driver but
removed any reference to voltage sensor in9.  If you'd prefer, I could try
to maximize the code overlap between the EHF & DHG if yall think that'll
make the code easier to maintain in the long run.  But for now, I just made
the DHG functions & constants completely separate from (but near identical
to) their EHF equivalents.

So now, running sensors or sensord actually prints my temps / voltages / fan
speeds.  :)

- David
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061215/00518f33/attachment-0001.html 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm-sensors_w83627dhg.patch
Type: text/x-patch
Size: 20369 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061215/00518f33/attachment-0001.bin 
