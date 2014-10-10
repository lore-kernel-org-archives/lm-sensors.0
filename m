From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Fri, 10 Oct 2014 14:53:12 +0000
Subject: Re: [lm-sensors] Fan Control on 6027R TRF running Debian Wheezy
Message-Id: <CAAek22F7ch8q9K=rCmn4c1gVFQSSePXy32Vmt+y1ujGB_FQrZA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5437E87B.8030206@truthbox.ch>
In-Reply-To: <5437E87B.8030206@truthbox.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday, October 10, 2014, Felix Schulthess <fsch@truthbox.ch> wrote:

> Dear lm-sensors Team,
>
> on a 6027R TRF, I run the latest Debian Wheezy. I have a problem with
> the server, because I cannot control fan speed anymore.


Your system has an onboard management processor which supports IPMI. You
should not use lm-sensors. Install IPMITOOL or FreeIPMI and use those tools
( or super doctor ) to read sensors.

You cannot control the fan speeds. They are managed by the onboard
controller. You can choose one of several profiles in the bios but that is
it.



> My plan was to control the drive bay LEDs via software, so I installed
> i2c-tools and ledmon packages. While I was at it, I also installed
> fancontrol and lm-sensors. As I now know, this was a very bad idea.
>
> Then I ran the proprietar Superdoctor program (distributed on the
> Supermicro website) that prints information on fan speed, temperatures
> and system voltages. I ran it only once by executing the command "sdt"
> as root. After the command completed, the 3 system fans started spinning
> at max RPM. And this is extremely noisy! Note, that the program ran
> flawlessly before I installed the packages listed above.
>
> Since then I didn't manage to regain control of the fans. Even after a
> reboot the fans start to speed. Also, removing the installed packages
> again does not help.
>
>
You probably need to reset the management controller. The easiest way is to
shutdown the system and unplug it for several MINUTES to discharge all the
capacitors and insure everything resets.  Then plug in and turn on again.

Best of luck,
Phil P.


-- 
Philip Pokorny, RHCE
Chief Technical Officer
PENGUIN COMPUTING, Inc
www.penguincomputing.com
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
