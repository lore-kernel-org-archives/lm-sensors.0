From: bob2@dsv.nl (Bob =?ISO-8859-1?Q?Schl=E4rmann?=)
Date: Mon, 16 Oct 2006 22:02:57 +0000
Subject: [lm-sensors] generic chip support in libsensors
Message-Id: <20061017000257.7baaaa98@ws01.atreidis.nl.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44C78622.8060808@hhs.nl>
In-Reply-To: <44C78622.8060808@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

We are currently almost done with modifying the library so that it
detects the chip's features from the sysfs entries, it now needs
some testing. One problem we had was finding a way to add the new
sensors_chip_features entry to the global list of known chips. This is
currently handled by making the last places of the global array empty
placeholders.

For step 2/3 (modify the sensors tool so the per chip print routines are
replaced by generic ones) we had some ideas. 

The first idea was to create a sort of object oriented approach by using
structs and function pointers, kind of how Gtk works. In the
OO-model a Sensor class/struct would be the root class and cpu,
voltage, etc. sensors would be implemented as subclasses. This has the
advantage (in our opinion) of a clear API and makes adding new sensor
types easier.

A simpler approach would be to just create a function that returns the
correct sensor type given a sensor_chip_feature struct. The sensors app
can then be restructured around this.

We have currently chosen to first implement the the last approach,
because this seems more 'incremental', and when there is enough time
left (there probably will be) implement the oo-model as an extra layer.

A patch will be available soon, to show our current progress and
hopefully to get some feedback whether we took the right path with step
1,

--
Bob

On Mon, 16 Oct 2006 22:43:26 +0200
Rudolf Marek <r.marek at assembler.cz> wrote:

> Hi Bob,
> 
> Any news on this?
> 
> Thanks,
> Rudolf
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 
> !DSPAM:4533ef46130231804284693!
> 

