From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 19 Dec 2007 17:38:27 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <191fb4ca0712190938j2559a49aw1d95d2776e37fcc8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Werner,

Please keep the list in the loop so others can profit from this information.


On Dec 19, 2007 8:30 AM, Werner Goebl <werner.goebl@mail.mcgill.ca> wrote:
> Hi Juerg,
>
> good point -- I relied on informations from the web about
> the Q965 chipset, but I learned that I was wrong!
>
> So: I have a SMSC SCH5514D-NS chip (which is not on the list
> unfortunately). I guess I am stuck now?

Good information, thanks. At least we can update sensors-detect to
correctly identify your chip. Unfortunately, this being a Dell
machine, SMSC won't provide technical information for this chip to me
since I'm an HP person :-)

Let's try to figure out if it's compatible to any other supported SMSC
chip before we give up. Can you run 'isadump -k 0x55 0x2e 0x2f 0xa'
and post the output?

...juerg


>
> Thanks for all your help!
> Werner
>
>
> > Silly question: What makes you think your system has a dme1737? The
> > device ID of the dme1737 is 0x78 or 0x77, not 0x83. Can you open up
> > the machine and look for an SMSC branded chip and tell us the chip
> > name?
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
