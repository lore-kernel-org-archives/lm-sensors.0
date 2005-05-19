From: kareemy@gmail.com (kareemy)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Question regarding ticket 1855
Message-Id: <c91ede1905010112173647c243@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c91ede190412311540bb02f54@mail.gmail.com>
In-Reply-To: <c91ede190412311540bb02f54@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank You. I e-mailed soyo and am waiting for a response. 

I tried some different compute temp lines in the mean time and 

compute temp2 (@*30/43)+25, (@-25)*43/30

gives me much better readings and is always within 1 to 4 C of the
BIOS readings after an initial boot up and then after a cpuburn. I
stole that line from the current sensors.conf which appears to work
for certain ASUS boards. Of course these tests are very non-scientific
and pretty much guesswork. I hope soyo will give me some better
information. I will pass it along to you guys, if you want to include
it in the sensors.conf as an option for my motherboard

Thanks for the quick response,
Kareem Dana

On Fri, 31 Dec 2004 20:02:04 -0500, Mark Studebaker <mds4@verizon.net> wrote:
> you're doing the right thing by looking at the BIOS and using cpuburn.
> The only way to know for sure which is which is to ask the motherboard maker.
> Perhaps temp3 is the CPU temp but you need to change the sensor type.
> V5SB, -12 and -5 probably aren't connected, you can ignore them.
> 
> kareemy wrote:
> > Hello,
> >
> > My problem ticket #1855 was just closed however I still have some
> > unanswered questions. If you could please give me some more advice
> > into my problem I would appreciate that.
> >
> >>From the problem detail, none of the 3 temperature readings seem to
> > coincide with my actual cpu temperature and the -12V, -5V, and V5SB
> > voltages are reported very incorrectly (-12 and -5V are reported as
> > being positive for one). Can you provide some insight into this
> > output?
> >
> > Also regarding the cpu temperature, the bios reports my cpu temp as
> > 44C but then temp1 and temp2 are only 28C and temp3 is way off at 68C.
> > How can I find out which output is supposed to be my cpu temperature
> > and then offset it correctly to the actual temperature?
> >
> > The original problem ticket is here for more information:
> >
> > http://secure.netroedge.com/~lm78/readticket.cgi?ticket55
> >
> >
> > Thank you for your quick replies!
> > Kareem Dana
> >
> >
> 
>
