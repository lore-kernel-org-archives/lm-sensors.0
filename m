From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 May 2011 08:31:55 +0000
Subject: Re: [lm-sensors] EMC6W201 module - Dell Sensors Testing
Message-Id: <20110522103155.6e5b4523@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DD30DD1.4080909@myamigos.us>
In-Reply-To: <4DD30DD1.4080909@myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 21 May 2011 17:04:28 -0600, Harry G McGavran Jr wrote:
> 
> I think the other windows sensors program I have is correct and
> that fan1 is the CPU fan and fan3 is the Case or Chassis fan.
> 
> I think that's they Rick found it, and I think that is the
> way it is on my system too.
> 
> So, that last .conf file I posted for Dell 670 and emc6w201
> should be correct.

OK, thanks for the information, I've updated my copy accordingly.

> It would be nice to know what "Remote Diode 5" is really
> temperature sensing.

I can think of only two ways to know:
1* Find the information in the documentation, or ask Dell.
2* Try to guess with physical experiments. Either by correlating the
   variations with specific system activity, or using a hair dryer :)
   I've done it once, and it works, but I'm not sure the motherboard
   really enjoyed it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
