From: "Artem S. Tashkinov" <birdie@permonline.ru>
Date: Wed, 17 Feb 2010 09:55:57 +0000
Subject: Re: [lm-sensors] How to compile k10temp?
Message-Id: <4B7BBD2D.3000604@permonline.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B7B0265.30102@att.net>
In-Reply-To: <4B7B0265.30102@att.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/17/2010 01:39 AM, Mark Preston wrote:
>
> I have an MSI motherboard (K9N6PGM-V2) and AMD cpu Athlon II X4 620 (4
> core cpu). I have found that some people have LM-sensors for K10 working
> in Ubuntu (Karmic, v 9.10) and I downloaded the driver:
> lm_sensors-3.1.2.tar.bz2 and following the instructions, tried make all,
> but the terminal returned error messages.
>
> I read at the wiki about AMD
>
> Family 10h CPU, family 11h CPU
>
> and drive k10temp which is in kernel 2.6.33.
>
> My OS: Karmic:~$ uname -r = 2.6.31-19-generic
>
> so will k10 and LM work if I compile a .33 kernel, or will it be OK if I
> compile the K10 into the .31 kernel?
>
> I'm not a programmer, but I can do some compiling tasks, as I'm not
> unfamiliar with ./ and such. I just need to know what order to issue the
> commands in and which ones need 'sudo' in front of them.
>
> Can someone please point me to a tutorial or how-to and help me compile
> this into my OS?
>

First of all lm_sensors-3.1.2.tar.bz2 is not a driver, it's a user space 
package for querying and showing data from Linux kernel. Secondly, on 
Ubuntu you don't have to download compile and install lm-sensors 
package, 'cause it's already there:

Run any console application (like gnome terminal and konsole), then

$ sudo apt-get update
$ sudo apt-get install lm-sensors
$ sudo apt-get upgrade (reboot if you have a new kernel installed)

The next thing to do is to run in console:

$ sudo sensors-detect

and given that sensors-detect detects and installs its configuration you 
need to:

$ sudo /etc/init.d/lm_sensors restart (or something like that - I'm not 
a Debian/Ubuntu user).

-- 

Best wishes,

Artem

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
