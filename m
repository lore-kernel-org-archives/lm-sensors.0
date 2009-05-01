From: Timothy Normand Miller <theosib@gmail.com>
Date: Fri, 01 May 2009 21:59:35 +0000
Subject: [lm-sensors] Ramp-up time for fan speed
Message-Id: <9871ee5f0905011459o3b8480a9j2a73845f5f84248a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, everyone.

I've recently discovered lm_sensors, pwmcontrol, and fancontrol.
IIUC, they're all part of the same package.  My CPU fan is under
automatic control by the system hardware, but the case fans were
fixed, and this system has allowed me to make the fan speeds vary with
temperature, which has made my system a LOT quieter when it's
relatively idle, yet I can launch compute-intensive apps and still
maintain a cool system.

Anyhow, I'm running into a problem with leaving the fans off.  The
fans take too long to come up to speed from stop.  It's not a function
of the fans themselves; when I power the system on, the snap from zero
to full speed in less than a second.  So my best guess is that
fancontrol won't just SET the duty cycle but wants to gradually ramp
it up or down.

If I leave the fans on all the time at a setting of 100/255, then it's
okay.  But if I leave them off until they're needed, it takes way too
long for the fans to even begin spinning.

Is there a way I can control fancontrol's ramp-up rate?  I wasn't able
to find anything on this in the documentation.

Thanks!

-- 
Timothy Normand Miller
http://www.cse.ohio-state.edu/~millerti
Open Graphics Project

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
