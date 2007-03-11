From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 11 Mar 2007 21:47:42 +0000
Subject: [lm-sensors] libsensors patches
Message-Id: <45F478FE.9010508@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311152104.bd092ff9.khali@linux-fr.org>
In-Reply-To: <20070311152104.bd092ff9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Mark M. Hoffman wrote:
> Hi Hans, Axel:
> 
> And if we're going to put sensors 2.10.x in a deep freeze, then I don't want
> to have to make bugfixes in two places, like you say.  Thus, I wanted all of
> these new features to wait for 3.0.
> 

Now I understand your motivations better!, Thanks.

>> branches. Also in this scenario I think we should keep them atleast API 
>> compatible from the application pov, as some distros may want to ship 
>> 2.10 then while others ship 3.0. This is exactly why I've suggested to 
>> turn 2.4 support into an ifdef instead of ripping it out.
> 
> Non-sequitor?  I don't understand why distros *couldn't* choose as you say,
> or just ship both.  OK, so a kernel 2.4 distro can't ship sensors 3.0.  But
> that's just too bad.  They can't ship the most recent udev or modprobe either.
> 

Notice that I said application API this time not application ABI, if we 
are going to say that 2.10 will stay around in some form for kernel 2.4 
+ 2.6 users and that 3.0 is all shiny and new for 2.6 only users, then 
we need them to be API compatible if possible because:
-We don't want application programmers to have to put their code full
  of: #ifdef LM_SENSORS3 ... #else ... #endif
-Now assuming 3.0 becomes an instant smash hit then most appplications
  might just move over, thus requiring 3.0 to compile and run ->
  problem 2.4 kernel / 2.10 libsensors users are left in the cold / with
  older versions of these applications

Thus as I keep re-iterating breaking (not extending but breaking) the 
API for the single goal of moving from pass by value to pass by const 
reference one way or the other causes users pain and IMHO more pain then 
gain.

Regards,

Hans

