From: james.oden@gmail.com (James Olin Oden)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Memory leak in I2C (ticket #1898)
Message-Id: <ac921f99050215065965e2109b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <jG6nFvCq.1108465575.6408970.khali@localhost>
In-Reply-To: <jG6nFvCq.1108465575.6408970.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 15 Feb 2005 12:06:15 +0100 (CET), Jean Delvare
<khali@linux-fr.org> wrote:
> 
> Hi James,
> 
> I am moving this to the mailing-list since it is likely to require some
> investigation before we can find out what's going on, and our current
> ticket system is not meant for this. (Philip, Axel, where is the new
> Bugzilla system going?)
>
Fine by me.
 
> Most things in the i2c core in linux 2.4 are static, so I doubt that
> there can be a leak in i2c-core itself. i2c-proc OTOH is likely to
> allocate memory for various things, so this is a candidate. And, as you
> suggested yourself, individual drivers are candidates as well.
> 
> Please tell us:
> 
> * Which i2c drivers you are using.
>
Here is the list in the order they are loaded:

    i2c-core i2c-dev i2c-proc i2c-i801 lm87b lm93 eeprom pcf8574

When I found the appearant memory leak I was only loading and
unloading modules lm93, eeprom, pcf8574.

> * What your test script is. Which modules are you cycling exactly, in
> which order, at which rate? I'd be happy to do the same on my own
> machines (with different bus and chip drivers) and see if I can
> reproduce the problem.
I have attached the script.   As far as rate, I was trying to force an
oops (which I could do with a previous release) so the only throttling
was system itself.  Basically I ran the test sc ript with this shell
snippet:

    while test.i2c.oops
    do
         :
    done

As I said earlier in the bug report, its not a likely scenario, but
IMHO it is a valid test case, if only if it stresses the registration
deregistration process.   On the system I was running this on we have
a program that kicks off about every 30 seconds and  runs the sensors
command.  I don't think you needed that to produce the memory leak,
but it probably was requried to produce the oops that you guys seemed
to have fixed.

The test script is fairly simple.  It has an internal list of modules
that it loads in one order, and then unloads in the opposite order. 
You can pass the arg --modcount=$number to tell it starting from the
back only load and unload $number modules.   You can override its
default module list by using --modules=$mod1,...,$modN.   I use depmod
to load and unload the modules, if dependent modules are not loaded
they should be loaded (not tested that though).

> 
> Once we know in which kernel module the leak is, it shouldn't be too
> hard to find out where the leak is exactly. There aren't that many
> memory allocations in there.
> 
> BTW, thanks a lot for reporting.
Not a problem.  Thanks for looking into this.  One of these days I'll
get my head around the I2C and lm_sensors architecture in the kernel,
and maybe I can send you patches instead (-;

Cheers...james
-------------- next part --------------
A non-text attachment was scrubbed...
Name: test.i2c.oops
Type: application/octet-stream
Size: 3437 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050215/1adecdb4/test.i2c.obj
