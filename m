From: decibel8@charter.net (David)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: 1250
Message-Id: <200306251314.51483.decibel8@charter.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org




> This would make sense. David, correct me if I'm wrong, but I believe
> that you can actually write to the files (simply using "cat 1 2 >
> /proc/sys/dev/sensors/via686a-isa-6000/in1" for example). So, if
> "sensors -s" fails, this must be because of libsensors *thinking* it
> cannot write.
Actually no. Not using cat. I get this error if do that:

bash-2.05b# cat 1 2 > /proc/sys/dev/sensors/via686a-isa-6000/in1
cat: 1: No such file or directory
cat: 2: No such file or directory

I can though 'echo' to it:





Previous message:
On Wednesday 25 June 2003 08:52 am, you wrote:
> > I don't have my lm_sensors source handy right now, but I wanted to
> > reply so perhaps you or someone else could look into this...
> >
> > I notice that the adapter is registered at address 6000.  That's a bit
> > of a strange isa address.  I believe that the original ISA bus only
> > has I/O addresses up to 3fff.  Anything above that is either an alias
> > or a PCI bus address.
> >
> > Perhaps there is a test in the ISA write function that makes sure the
> > address you're attempting to write is in the range: 0-3fff or less and
> > if not, returns an error.
>
> This would make sense. David, correct me if I'm wrong, but I believe
> that you can actually write to the files (simply using "cat 1 2 >
> /proc/sys/dev/sensors/via686a-isa-6000/in1" for example). So, if
> "sensors -s" fails, this must be because of libsensors *thinking* it
> cannot write.
>
> David, maybe we already asked you and I'm sorry for that, but I can't
> remember (it's been so long):
>
> 1* Are you using i2c & lm_sensors 2.7.0 or CVS?
>
> 2* Are you using the mkpatch method or the traditional separated
> compilation tree method?
>
> Thanks.
