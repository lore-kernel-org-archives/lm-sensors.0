From: <samu.p.onkalo@nokia.com>
Date: Tue, 02 Feb 2010 09:01:19 +0000
Subject: Re: [lm-sensors] API extensions (for IIO,
Message-Id: <62697B07E9803846BC582181BD6FB6B8257275A9B8@NOK-EUMSG-02.mgdnok.nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B65CC6C.7070605@cam.ac.uk>
In-Reply-To: <4B65CC6C.7070605@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>-----Original Message-----
>From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
>sensors.org] On Behalf Of ext Jonathan Cameron
>Sent: 31 January, 2010 20:31
>To: LM Sensors; Greg KH; Manuel Stahl; Torokhov; Hennerich, Michael;
>Jean Delvare
>Subject: [lm-sensors] API extensions (for IIO, matching hwmon as closely
>as possible)
>
>Dear All,
>
>We recently proposed an API specification for parts of the Industrial
>I/O
>subsystem in a thread on LKML.  Greg KH pointed out that a we ought to,
>where
>sensible keep as close as possible to API's of existing subsystems.  To
>that
>end we are working on an updated version of the original document.
>(original at http://lkml.org/lkml/2010/1/20/195, please note it has
>changed
>a lot in response to comments made in that thread!)

Hi

Based on the discussion in lkml, it seems that I'm working on "toy" side of the
sensors. I agree that we need to have standard interface for different kind
of sensors. It has been quite hard to decide what kind of interface is the correct one
for different sensors (accelerometers, magnetometers, ambient light sensors,
proximity sensors etc). When sensors are used for some kind of user interface control
(device orientation, lightning, movement, games, amusement applications),
historical or buffered data is not so important. Data is aging quite rapidly.
In battery powered devices, it is essential to turn off sensor HW whenever possible.
Does the proposed interface offer possibility to turn off the sensors when they
are not used?

Br, Samu

ps.
Jonathan, could you please keep me in CC when discussing about IIO.

>
>The big difference from hwmon is that we very rarely export processed
>values
>to user space.  The fundamental reason for this is that our primary
>access to
>data is via ring buffer interfaces accessed through related character
>devices
>rather than direct access through sysfs.  Speed is of the essence and
>often
>processed values are not actually what is required in any case.
>However,
>we do wish to provide sufficient information for a user space library to
>perform
>these calculations in the common case of a linear transform.
>
>Anyhow, taking just voltage channels (ADC's) as a starting point we are
>looking
>at the following and would appreciate comments / suggestions from the
>hwmon
>community.
>
>in0_raw     //raw access
>in0_offset
>in0_gain
>
>(in0_value equivalent would be obtained from (in0_raw +
>in0_offset)*in0_gain)
>
>In cases where all channels of type in share offset and gain we also
>allow (to
>reduce the large number identical sysfs entries):
>
>in_offset
>in_gain
>
>There are a couple of cases that I'm not sure how to sensibly handle,
>particularly
>differential pairs.  Here we want to indicate which input lines they
>refer to within
>the name and that we are dealing with a differential situation.
>
>Ideas that come to mind for a case which is corresponds to (in0_raw -
>in1_raw) are
>
>in0:1_raw
>diff0:1_raw
>in0-1_raw
>
>What do people think is clearest?  Obvious, as per hwmon the vast
>majority of users
>are going to access this through a user space library, but it would
>still be nice
>to get a sensible human readable layout in sysfs.  Also note that there
>are a number
>of other elements associated with each channel, but I have left them out
>of this
>discussion to keep things simple (for now!) They are primarily to do
>with the ring
>buffer access and so do not overlap so much with hwmon other than in
>base naming of
>channels.
>
>Note that there is no intention of adding the option to use these new
>interfaces to
>hwmon, merely an intent to avoid introducing incompatible interfaces
>should this
>functionality become of interest in the future and to take advantage of
>the experience
>of the developers on this list.
>
>Thanks,
>
>Jonathan Cameron
>
>p.s. I've thinned out the original list of ccs to those interested in
>this aspect.
>Please forward to any interested parties whom I have missed!
>
>_______________________________________________
>lm-sensors mailing list
>lm-sensors@lm-sensors.org
>http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
