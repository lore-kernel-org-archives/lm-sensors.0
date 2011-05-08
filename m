From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 08 May 2011 08:39:21 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <4DC656B9.5020003@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 05/08/2011 08:27 AM, Jean Delvare wrote:
> Hi Jeff,
>
> On Sat, 07 May 2011 23:09:40 -0500, Jeff Rickman wrote:
>> I just tried out the "i8k.c" code from the link shown above. I still get
>> a crash in Syslog and messages on the Console when loading the new
>> module. The machine still runs so the crash doesn't appear to be "fatal".
>
> Well you had already tried exactly this version, hadn't you?
>
>>
>> My testing steps:
>> (1) Completely remove the "i8k" module supplied by Fedora to a "safe"
>> location. It is not being used on my machine per "lsmod".
>
> Did you try loading this original i8k driver? Did it work? What are the
> contents of /proc/i8k then?
>
> If the original works and mine fails, please send me the two .ko files
> in private and I'll try to figure out how they differ. Even better if
> you can get the exact kernel sources used by Fedora to build your
> running kernel so that I can also compare the source code (the source
> file is drivers/misc/i8k.c in the kernel tree.)
>

Note if you (Jeff) can give me the output of "uname -a" I can quite easily
get the matching kernel sources and send Jean the i8k.c from that exact
version (assuming you're not running some homebrewn kernel).

In case you're wondering how, what I would do is go to koji (the Fedora
buildsystem):
http://koji.fedoraproject.org/koji/

Search for kernel, go to the kernel you're running, download an install
the src.rpm, and do a "rpmbuild -bp kernel.spec", which will extract the
sources, apply all patches and then exit (it will do the %prep fase of
the spec file). And then I've an exploded source tree, with the exact
sources used to build your kernel.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
