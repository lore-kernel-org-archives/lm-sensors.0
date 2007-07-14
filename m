From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Jul 2007 19:47:39 +0000
Subject: Re: [lm-sensors] Using libsensors in custom application
Message-Id: <20070714214739.3dc110ee@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c7bf4e$d7dce200$0500a8c0@LSSDESIGN>
In-Reply-To: <000001c7bf4e$d7dce200$0500a8c0@LSSDESIGN>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi John,

On Thu, 5 Jul 2007 16:52:52 -0500, John Beavers wrote:
> I'm trying to develop an application that can get the temperature of the CPU
> / MB and send it to another machine on the network for remote temperature
> monitoring.  I've managed to compile and run a program that successfully
> sends test data over the network, reads chip data like sensors (using the
> same code), but I cannot get it to do both together.  Basically, I cannot
> tell where / how sensors is getting the information it is outputting to the
> screen.  I've tracked it down to m->fn(&name); in the do_a_print() function,
> but I cannot see how that line prints out the chip information.

The callback function (m->fn) is chip-specific. The "matches" array
gives the correspondence between a chip name and its printing function.
All the printing functions are in a different source file (chips.c).
Yes, it's a mess.

>                                                                  My question
> is, is there a tutorial of how to use libsensors in an application
> somewhere,

sensors' source code is the tutorial. And you have the libsensors man
page for reference, too.

>            or can you give me a brief explanation of how to get the CPU  &
> MB temp from libsensors?

libsensors can't give you that, because it has no knowledge of what
sensor measures what. In its current incarnation, it doesn't even
know which sensors are temperature sensors, and which are, say, fan
sensors. This will be much better in the next (major) version, but for
now, libsensors is heavily chip-specific.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
