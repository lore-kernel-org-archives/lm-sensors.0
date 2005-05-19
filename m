From: david.goodenough@btconnect.com (David Goodenough)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: LM87 support in LK2.6
Message-Id: <200407071420.02826.david.goodenough@btconnect.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <406C6981.6060306@mascorp.com>
In-Reply-To: <406C6981.6060306@mascorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Right, I now have the code compiled and installed on a Debian unstable
2.6.7 kernel system, with the latest lm87 code with the scx200_acb
patch and all, and it loads and sensors finds it.

The output I get ( and I have no way to verify whether those numbers
that are there are correct is:-

<<<<<<<<<<<<<<<<<<<
david@microtik:-$sensors
eeprom-i2c-1-50
Adapter: SCX200 ACB1
Memory type:		SDR SDRAM DIMM
Memory size(MB):	64

lm87-i2c-1-2e
Adapter: SCX200 ACB1
Error: Can't get IN1 data!
Error: Can't get IN2 data!
Error: Can't get IN3 data!
fan1:	0 RPM (min = -1 RPM, div = 2)		ALARM
fan2:	0 RPM (min = -1 RPM, div = 2)		ALARM
temp1:	+37C  (low = 	+0 C, high = 	+0)	ALARM
Error: Can't get TEMP2 data
<<<<<<<<<<<<<<<<<<<<

Now looking at this the fan speeds of 0 are right, this system has
no fans.  Why an alarm is thought to be necessary when the min = -1
and the value is 0 I am uncertain.

For temp1 the value is plausable, but the low and high values are
obviously wrong (at least the high one).

The documentation is wonderfully vague as to what sensors there
are, and there is no BIOS function to read and display them as far
as I can see.  However it does say:-

Temperative sensors: CPU area, PCI area, LM87 health monitoring area
Voltage Monitor: CPU core, +3.3V +5V +12V voltage monitoring

This would suggest that there should be four voltages and three 
temperatures.  We seem to have just one temperature.

Looking at the data in /sys/bus/i2c/device/1-002e I get a slightly
different picture.

Ignoring the ones I am not expecting:-
                       input	min		max
in0			0		0		0
in1			1800	0		0
in2			3300	0		0
in3			5000	0		0
in4			12125	0		0
temp1		37000	0		0
temp2		0		0		0
temp3		31000	0		0

For completeness the vrm value is 82, vid is 0, analog_out is 255,
detach_state is 0 and alarms is 4606.

Now this looks as though in0 is unused, in1 is the core, in2 is +3,
int3 is +5 and in4 is +12, temp1 is the CPU temperature and temp3
is the PCI area temperature.  Why sensors could not read IN1, IN2
and IN3 confuses me.

Where do the min and max values come from, if from the chip then
there is something amis, if from a control file obviously I do not have
that file installed (correctly).

Any thoughts?

David

On Friday 02 July 2004 10:41, David Goodenough wrote:
> Jeff,
>
> I finally got around to testing your LM87 code, and I am having a few
> problems.
>
> Let me describe my hardware environment first as it may help.  This
> LM87 is on a Microtik Routerboard 230, which uses a SC1100 system
> on a chip unit.  I am therefore using the scx200_acb driver (as
> patched in the LM77 discussion thread to enable hardware
> monitoring device detection).
>
> sensors-detect finds the ACB buss, and finds the LM87.  So I then
> load the lm87 module but then nothing.  sensors finds the other
> device (eeprom) and correctly reports the installed memory size,
> but nothing from the LM87.
>
> Any ideas as to where to start looking?
>
> David
>
> On Friday 02 April 2004 19:06, you wrote:
> > Sure, here's the patch.
> >
> > Let me know how it works...
> >
> > Jeff
> >
> > David Goodenough wrote:
> > >Jeff,
> > >
> > >Could you send me the driver and I will give it a go if I get time
> > > before I go skiing, otherwise I will do it as soon as I get back.  That
> > > was I can spend time on the i2c_nscacb driver instead of duplicating
> > > your effort.
> > >
> > >David
> > >
> > >On Thursday 01 April 2004 23:33, Jeff Oliver wrote:
> > >>I already have the driver compiling clean...after spending a day with
> > >>the conversion document and the old 2.4 driver.  I have not yet tested
> > >>it since I dont have my hardware yet.  I can send you guys the driver
> > >> if you'd like to check it out and play with it.  I'm going on vacation
> > >> as well, and hope to have hardware when I get back late next week.
> > >>
> > >>I've been working against the stock 2.6.4 kernel.  Moving to a newer
> > >>kernel can be done when the first port is verified.
> > >>
> > >>Jeff Oliver
> > >>
> > >>P.S. Can I be added to the mailing list as well?
> > >>
> > >>David Goodenough wrote:
> > >>>On Thursday 01 April 2004 20:30, Jean Delvare wrote:
> > >>>>>I searched through the mail archives and found that the LM87 chip
> > >>>>> had no plans to convert to the 2.6 kernel at the moment.  First I
> > >>>>> wanted to get an update on that status,  and second, I'm going to
> > >>>>> be using it on a project im working on, so if there is nothing
> > >>>>> ported at the moment, I'll probably end up porting it myself. 
> > >>>>> Actually, the port is in progress, unfortunately, I don't have my
> > >>>>> hardware to test it out on yet.  The driver porting directions have
> > >>>>> been very helpful on getting started on the conversion.
> > >>>>
> > >>>>Two other persons have deplored the lack of support of the LM87 in
> > >>>>Linux 2.6, I just invited them into this thread ;)
> > >>>>
> > >>>>I invite you to work together so as not to waste your time and
> > >>>> instead share your forces on porting the driver. I think David was
> > >>>> wanting to port the driver as well, while Chris was "only" wanting
> > >>>> to test it once done.
> > >>>>
> > >>>>If you have questions while porting the driver, just ask on this
> > >>>> list.
> > >>>>
> > >>>>Once the port is considered ready, post it here in the form of a
> > >>>> patch against the latest -mm kernel, and we (most likely I) will
> > >>>> review it.
> > >>>>
> > >>>>Thanks.
> > >>>
> > >>>I am going to do some work on this next week (I am going skiing, and I
> > >>>will do this in the evening).  I hope to come back with something that
> > >>> at least compiles cleanly.  I will not have the kit to test with me
> > >>> on the trip, but I will start testing when I get back.  I have no
> > >>> idea now well connected I will be next week, so if I hit a problem it
> > >>> may have to wait until I return.
> > >>>
> > >>>I am working against a Debianised 2.6.4 kernel in the first instance,
> > >>>I will move to a later one when I have done the basic conversion.
> > >>>
> > >>>David
> > >>>
> > >>>BTW, I am still only getting mail that is explictly addressed to me,
> > >>> not mail that is for the list in general
> > >>
> > >>Disclaimer: The information contained in this transmission, including
> > >> any attachments, may contain confidential information of Matsushita
> > >> Avionics Systems Corporation.  This transmission is intended only for
> > >> the use of the addressee(s) listed above.  Unauthorized review,
> > >> dissemination or other use of the information contained in this
> > >> transmission is strictly prohibited. If you have received this
> > >> transmission in error or have reason to believe you are not authorized
> > >> to receive it, please notify the sender by return email and promptly
> > >> delete the transmission
> >
> > Disclaimer: The information contained in this transmission, including any
> > attachments, may contain confidential information of Matsushita Avionics
> > Systems Corporation.  This transmission is intended only for the use of
> > the addressee(s) listed above.  Unauthorized review, dissemination or
> > other use of the information contained in this transmission is strictly
> > prohibited. If you have received this transmission in error or have
> > reason to believe you are not authorized to receive it, please notify the
> > sender by return email and promptly delete the transmission
