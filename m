From: "George Joseph \(dev\)" <gtj.devel@peakin.com>
Date: Sun, 02 Mar 2008 01:53:02 +0000
Subject: Re: [lm-sensors] lm_sensors v2 asc7621 support
Message-Id: <22E26940476D1E48AA6F292B5316C9C305EAD6@bes1.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <47C9A8B9.20501@kenm.demon.co.uk>
In-Reply-To: <47C9A8B9.20501@kenm.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There's an updated version of the driver at 
http://www.peakin.com/x38/asc7621.zip

It's been cleaned up a little and handles both the asc7621 on the Intel
D975XBX2 Bad Axe 2 motherboard and the asc7621a which is found on the
Intel DX38BT Bonetrail motherboard.

I guess I should get off my butt and submit the driver for review now.
:)

george

-----Original Message-----
From: lm-sensors-bounces@lm-sensors.org
[mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of Ken Milmore
Sent: Saturday, March 01, 2008 12:04 PM
To: lm-sensors@lm-sensors.org
Cc: George Joseph
Subject: [lm-sensors] lm_sensors v2 asc7621 support

I've had a go at implementing support for George Joseph's experimental 
Adigilog asc7621 driver in lm_sensors 2.10.5.  Find patch attached.

I've been running this for a while with the asc76xx driver on an Intel 
D975XBX2 board.  It works just fine for reading the sensors, although 
writing the alarm limits and such doesn't seem to work quite right.

Hopefully this might be a starting point for someone else to add 
official support for these chips to lm_sensors.

Kind regards,

Ken Milmore


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
