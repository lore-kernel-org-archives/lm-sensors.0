From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Question regarding ticket 1855
Message-Id: <41D5F68C.6080000@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <c91ede190412311540bb02f54@mail.gmail.com>
In-Reply-To: <c91ede190412311540bb02f54@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you're doing the right thing by looking at the BIOS and using cpuburn.
The only way to know for sure which is which is to ask the motherboard maker.
Perhaps temp3 is the CPU temp but you need to change the sensor type.
V5SB, -12 and -5 probably aren't connected, you can ignore them.

kareemy wrote:
> Hello,
> 
> My problem ticket #1855 was just closed however I still have some
> unanswered questions. If you could please give me some more advice
> into my problem I would appreciate that.
> 
>>From the problem detail, none of the 3 temperature readings seem to
> coincide with my actual cpu temperature and the -12V, -5V, and V5SB
> voltages are reported very incorrectly (-12 and -5V are reported as
> being positive for one). Can you provide some insight into this
> output?
> 
> Also regarding the cpu temperature, the bios reports my cpu temp as
> 44C but then temp1 and temp2 are only 28C and temp3 is way off at 68C.
> How can I find out which output is supposed to be my cpu temperature
> and then offset it correctly to the actual temperature?
> 
> The original problem ticket is here for more information:
> 
> http://secure.netroedge.com/~lm78/readticket.cgi?ticket55
> 
> 
> Thank you for your quick replies!
> Kareem Dana
> 
> 
