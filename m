From: sukhdeep@gmail.com (Sukhdeep Johar)
Date: Tue, 14 Jun 2005 17:13:30 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address 0x49
Message-Id: <2ef564dc05061408124135ad9a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05061302175b8427fd@mail.gmail.com>
In-Reply-To: <2ef564dc05061302175b8427fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> Well, there are two chips, what did you expect?
Hmmm.. 
The problem is that I can see only one W83697F chip on the
motherboard. I am puzzled where the two W83782D's are.

I booted the device using Win 2K HDD and ran SpeedFan over it. And the
results were the same.
At least the second chip is reading the fan speeds correctly. There
are 4 external fans, and 2nd chip is reading out the fan speeds for
the 3 of them.
 
>> Don't expect us to tell you, that's not
>> something we can guess.
Right. I guess I need to check with the HW gs.

Thanks a lot for helping out on this Jean. Things are in a better shape now. 

And one more question ... Is it possible to configure the fan1,
fan2... settings in sensors.conf for the two chips separately ?

regards,
Sukhdeep
