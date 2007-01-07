From: vz-sensors@zeitlins.org (Vadim Zeitlin)
Date: Sun, 07 Jan 2007 01:33:56 +0000
Subject: [lm-sensors] Tyan S2696 and ADT7470
Message-Id: <E1H3Mv6-0001uJ-00@smtp.tt-solutions.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1H1lxZ-0002Zb-00@smtp.tt-solutions.com>
In-Reply-To: <E1H1lxZ-0002Zb-00@smtp.tt-solutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 05 Jan 2007 23:50:28 +0100 Rudolf Marek <r.marek at assembler.cz> wrote:

RM> Thanks for the reports.

 Hello Rudolf,

 Thanks for your reply!

RM> Unfortunately none of us - Me, Jean or David does not have any time to
RM> write new drivers. We may help answering the questions or give the
RM> hints to start the development but that is all we can do now.

 As I work on a few free projects on my own, this is a situation I
understand only too well...

RM> Maybe you or your company can fund the driver devel? Hw/Money/whatever?

 Well, I have hardware and am definitely available to do any (preferably
non destructive :-) tests on it. And I can contribute some of my own time.
Unfortunately not much in the way of money.

RM> > 	# sensors-detect
RM> > 	...
RM> > 	Now follows a summary of the probes I have just done.
RM> > 	Just press ENTER to continue:
RM> > 
RM> > 	Driver `to-be-written' (should be inserted):
RM> > 	  Detects correctly:
RM> > 	  * Bus `SMBus I801 adapter at 18c0'
RM> > 	    Busdriver `i2c-i801', I2C address 0x2e
RM> > 	    Chip `Analog Devices ADT7470' (confidence: 5)
RM> > 	  * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)
RM> 
RM> Wow :) Even the FB-DIMM are there.

 Yes, I was quite impressed by sensors-detect seeing them too. Too bad I
can't see their temperature as then I could try simply running the machine
without the (rear) fan, but I'm too afraid to fry the DIMMs -- they seem to
be quite hot.

RM> > Unfortunately it looks that the case fans -- which create the deafening
RM> > noise making the machine all but unusable currently -- are connected to
RM> > ADT7470 and not the W83627EHG

 FWIW, I got a reply from Tyan and this is indeed the case.


RM> If you know how to code in C it should not be a problem to write a driver.

 Is there any sufficiently clean and simple driver I could use as an
example/starting point by chance?

RM> You can use also following commands to reprogram the fans to manual mode:
RM> 
RM> http://www.analog.com/en/prod/0,2877,ADT7470,00.html
RM> 
RM> CHeck page 23 of datasheet.

 Ah, I started reading the datasheet but didn't reach the most interesting
part, thanks for the page link! I'm going to try it out and report back.

 Thanks,
VZ


