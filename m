From: Timothy Normand Miller <theosib@gmail.com>
Date: Sat, 02 May 2009 15:21:36 +0000
Subject: Re: [lm-sensors] Ramp-up time for fan speed
Message-Id: <9871ee5f0905020821gabd258fj6e4d480e401d45c8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9871ee5f0905011459o3b8480a9j2a73845f5f84248a@mail.gmail.com>
In-Reply-To: <9871ee5f0905011459o3b8480a9j2a73845f5f84248a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 5/2/09, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Timothy,
>
>
>  On Fri, 1 May 2009 17:59:35 -0400, Timothy Normand Miller wrote:
>  > I've recently discovered lm_sensors, pwmcontrol, and fancontrol.
>  > IIUC, they're all part of the same package.  My CPU fan is under
>  > automatic control by the system hardware, but the case fans were
>  > fixed, and this system has allowed me to make the fan speeds vary with
>  > temperature, which has made my system a LOT quieter when it's
>  > relatively idle, yet I can launch compute-intensive apps and still
>  > maintain a cool system.
>  >
>  > Anyhow, I'm running into a problem with leaving the fans off.  The
>  > fans take too long to come up to speed from stop.  It's not a function
>  > of the fans themselves; when I power the system on, the snap from zero
>  > to full speed in less than a second.  So my best guess is that
>  > fancontrol won't just SET the duty cycle but wants to gradually ramp
>  > it up or down.
>  >
>  > If I leave the fans on all the time at a setting of 100/255, then it's
>  > okay.  But if I leave them off until they're needed, it takes way too
>  > long for the fans to even begin spinning.
>  >
>  > Is there a way I can control fancontrol's ramp-up rate?  I wasn't able
>  > to find anything on this in the documentation.
>
>
> The fancontrol script really isn't that smart. It doesn't implement any
>  form of ramp-up, the target speed (actually, output duty cycle) is
>  computed linearly based on the measured temperature, and applied
>  immediately.

I got the source code to fancontrol and discovered that, although I'm
not so great at reading either bash or perl.  It occurs to me that
whatever circuitry controls the duty cycle itself has slow reaction
time.  I'd love to know what makes it snap on full quickly at boot
time.  Actually, that I can get.  But how it so quickly drops to 50%
(under control of BIOS) would be interesting to know.  When fancontrol
sets 50%, it takes a while to slow down.

>
>  However it is known that fans need a relatively high duty cycle to
>  start spinning, and we do have a mechanism for that: MINSTART. I
>  suppose you didn't set its value high enough. Probably the best is that
>  you share your /etc/fancontrol configuration file with us and I'll tell
>  you what I think should be changed.

Actually, after 150 wasn't quick enough, I tried 255 for MINSTART.  It
didn't seem to help any.  I'll fiddle with it a bit more, but I'm
quite sure that it's not fancontrol's problem.  And besides, since
it's a script, I can easily alter it.

>
>  Please also tell us which version of lm-sensors you're running, to make
>  sure you aren't affected by an old bug.

sensors version 2.10.7 with libsensors version 2.10.7

Thanks for the help!

>
>  --
>  Jean Delvare
>  http://khali.linux-fr.org/wishlist.html
>


-- 
Timothy Normand Miller
http://www.cse.ohio-state.edu/~millerti
Open Graphics Project

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
