From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 11 Jun 2012 13:49:04 +0000
Subject: Re: [lm-sensors] VIA Epia ML6000EAG vt1211 CPU temperature wrong value
Message-Id: <20120611134904.GA14712@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <f7590e64826c8ddac9804d2bc428f9c9.squirrel@www.sexychickz.net>
In-Reply-To: <f7590e64826c8ddac9804d2bc428f9c9.squirrel@www.sexychickz.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jun 11, 2012 at 09:39:38AM -0400, Guenter Roeck wrote:
> On Mon, Jun 11, 2012 at 03:55:07AM -0400, kernel@noltedennis.de wrote:
> > Hello and thank you for helping.
> > 
> > The raw readings on following config settings:
> > 
> > compute temp1 (@ - 83.869) / 0.9528, (@ * 0.9528) +83.869
> > 
> > # cat /sys/devices/platform/vt1211.24576/temp1_input
> > 99000
> > # cat /sys/devices/platform/vt1211.24576/temp2_input
> > 41000
> > 
> > for comparison the sensor output:
> > #sensors
> > ...                                                                       
> >  fan1:    0 RPM  (min =    0 RPM, div = 2)
> > fan2:          0 RPM  (min =    0 RPM, div = 2)
> > temp1:       +15.9 C  (high = +179.6 C, hyst = -88.0 C)
> > SIO Temp:    +41.0 C  (high = +204.0 C, hyst =  +0.0 C)
> > cpu0_vid:   +1.750 V
> > 
> temp1 is too low. Just don't have a good idea how to adjust it. Maybe measure
> at low and high load and come up with a better approximation.
> 
> > 
> > without the compute line the hyst value seems to be ok, but the temp is
> > pretty high.
> > 
> > temp1:      +102.0 C  (high = +255.0 C, hyst =  +0.0 C)
> > Raw value: 104000
> > 
> I think I know the problem. hyst is supposed to show report absolute temperature,
> not the hysteresis value itself. Looks like displays the hysteresis value itself
> (ie the temperature difference/variance) here. The equation is applied to hyst,
> which results in the negative value. The raw hysteresis value should be 104000,
> just like the raw temperature (assuming no hysteresis is programmed).
> 
Correction: hyst is related to max, not to the current temperature. So the raw
reported value should be 255000, not 104000. Sorry for the confusion.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
