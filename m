From: david.goodenough@btconnect.com (David Goodenough)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: soekris net4801, at your service.
Message-Id: <200406090911.04726.david.goodenough@btconnect.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <40C67B8C.8010109@divsol.com>
In-Reply-To: <40C67B8C.8010109@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 09 June 2004 03:53, Jim Cromie wrote:
> hey folks,
>
> I just got a soekris net4801, and Id like to offer it up as
> a test/development target.
>
> It has a Geode SC-1100 processor, an i2c/sms bus, a pc87366 super-IO, etc.
>
> Since Im new here, and new to LKM hacking generally,
> heres my (relevant) story, so you know what limits youre dealing with...
>
> I followed Mike Machado's recipe:
> http://www.innercite.com/~mike/soekris/
> so I have a small debian setup running there,
> either via NFS, or the CF onboard.
>
> Ive also got 2.4.26-adeos running on it, (adeos.o loads.. I havent tried
> anything else)
> an ov511 webcam, and a bunch of other {drivers/}net/* modules. (again,
> they load..)
>
> Ive patched pci.ids to add some Geode-Fu, which shows up in /proc/pci
> Where should I ask what 'good' identification strings are ? here ?
>
> I also forced scx200.c to recognize PCI DEV ID = 510 in addition to ID > 500,
> and the module loads. ( Ive gone no further yet, I dont want to burn my
> box )
>
> Im a perl geek, so hi Jean Delvare, Id love to get my hands on some of
> your test-scripts, theyll help a lot in giving me some context, use cases.
>
>
> thanks all, hope I can help,
>
> Jim Cromie

For the record, this chip (the SC1100) is also found on the Microtik 
RouterBoards.  They had a series of patches which did two things, firstly
they extended the scx200 support to include the SC1100, and then
they added in some lmsensors stuff (which works on 2.4 but not 2.6) for the
nscacb bus and the lm87 which microtik use.  The basic patches have now
been included in the mainstream kernel (as of 2.6.7-rc3), and while I did not
author them but merely brought them to Andrew Morton's attention they
have been entered in my name.

Someone else produced an lm87 driver for 2.6, and I am working on getting
the nscacb driver working (but I have had some other things I had to get done
first).

David
