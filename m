From: david.w.madsen@intel.com (Madsen, David W)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <A652FD396F42E94BA29B9EB35404E7A3038EE796@azsmsx405.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I am in the same position as David Hoffman with this.  It is just a
personal project and is not a necessity for me either.  I can offer my
time and testing.  I originally hoped to find the spec for the chip to
start working on a driver myself, but I was never able to dig up any
information on it anywhere.  Congrats to you David for getting the
datasheet!

Since my original correspondence I have purchased another motherboard to
run in my linux box and moved the ASUS P5AD2 to my desktop which
unfortunately only has Windows installed at the moment.  I swapped out
the boards as the P5AD2 has more features that would be useful to me on
the desktop rather than in the linux machine such as built in wireless
and 1394b.  The vanilla Intel board that replaced the asus in the linux
server has a different sensor chip (which also doesn't have support
AFAIK :) ) so I won't be able to provide any feedback for a few days
until I can get linux installed on my desktop again. 

With that said I am still interested in supporting this effort and can
help with coding / testing of the driver as needed.  Are you free to
distribute that datasheet to me as well?

On a side note, in this message 

http://archives.andrew.net.au/lm-sensors/msg28603.html

I described the result I had by changing W627THF_DEVID to 0x88 to match
the id of the W83627EHF.  I was able to get data from the chip though
the voltages were incorrect.  This could be explained by the differences
that Jean described.  The fan RPM data seemed accurate as well as the
temperatures.

I will send my results as soon as I have a Linux install up on the Asus
board again, which should be sometime in the next few days.   


--
David Madsen
david.w.madsen@intel.com
 
-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Tuesday, February 08, 2005 11:48 AM
To: David Hoffman
Cc: LM Sensors; Madsen, David W
Subject: Re: I have information on Winbond W83627EHF Chip

Hi David,

> I would be happy to run any tests and provide whatever information I
> can. Unfortunately, this is not any work that I am doing on behalf of
> my employer or any customer, so it's not so much of a "need to have"
> as much as it is a "nice to have". That being said, I am not in a
> position to contribute any hardware or financial support.

No problem.

> For right now, I can tell you that I am running Fedora Core 3 with
> kernel 2.6.10-1.760_FC3smp. My motherboard is an ASUS P5P800.

OK, so it's a different board, which means that at least two boards have
the W83627EHF chip. And the driver would need to be written for 2.6
primarily.

> I started looking to run i2cdump, but apparently there are no busses
> found in my system, or at least there are no /dev/i2c* devices.

You'd have to load some bus driver, most probably i2c-i801. The
"sensors-detect" script should tell.

> I tried isadump, but I'm not sure what you are expecting the output to
> look like, or if the output I'm getting is valid data.

Hexadecimal numbers ;) But maybe the address is different.
sensors-detect will tell too.

> I'd be happy to test any new versions you have, just let me know the
> best way to retrieve them, and how you would like me to run them, and
> what output or results you would like me to report back to you.

I've update the sensors-detect script so that it detects the W83627EHF
in the three possible ways: as an I2C client, as an ISA chip and as a
Super-I/O chip. Please give it a try:
http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/prog/detect/sensors-de
tect

Download, chmod +x sensors-detect, ./sensors-detect, and send us the
full output.

David Madsen, please do too if possible! The more feedback, the better.

With the output of sensors-detect I'll tell you how to dump the chip
contents.

Thanks!
-- 
Jean Delvare
