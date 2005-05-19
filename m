From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: i2c and sensors for 2.4/2.5
Message-Id: <3E2C98E7.7040105@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0301171830420.22376-101000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0301171830420.22376-101000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On the sensors side, I think you have asked for help on:
	- all PCI drivers (I'll start with via686a)
	- mkpatch (which I consider low priority)

If you see anything on LKML about somebody volunteering for something
and they didn't copy our list, please forward it.

We should also remove check_region(), are you doing that
or do you need a volunteer.
Everything else in TODO I think you have tackled.

I'll copy into TODO the other mail you sent about
ACPI, etc.
If ACPI and sensors use the same address space or
even the same registers in a device, that could
be a problem. With the new PCI layer, will it let
two drivers claim the same region or not?



Ky?sti M?lkki wrote:
> Finally, i2c CVS is synced with 2.5.58 tree.
> 
> I believe we are ready to submit patches to both 2.4 and 2.5 trees
> in a week or so. In the mean time, please hold any non-critical i2c
> patches. Most of the 2.4 cleanup done in CVS already applies these.
> And some of the header file cleanups applied in 2.5.53+ evidently
> break i2c-proc and userland compiles for /dev/i2c-x ...
> 
> You can checkout i2c with "-r lk2-4" to get i2c code for 2.4 tree.
> Attached is non-CVS i2c code ported back from 2.5 to 2.4.21-pre3
> for the impatient, to use .owner refcounting.
> 
> As for lm_sensors, CVS head will work for both 2.5 and 2.4 after i2c
> patches. Currently CVS compiles but all of PCI probing takes time to
> convert. Post to LKML with a list of i2c busses you volunteer to fix.
> 
> Also, assistance on how to fix module refcounting is welcome.
> To my understanding, it does not handle client->adapter->owner
> correctly now, and it is possible to rmmod adapter while one of its
> clients is in use.
> 
> HTH.
> 
