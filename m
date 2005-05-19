From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Adding support for vt1211 in kernel 2.6
Message-Id: <20031220135925.126279a6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <46951.192.176.33.6.1070287022.squirrel@firewall.isacson.dyndns.info>
In-Reply-To: <46951.192.176.33.6.1070287022.squirrel@firewall.isacson.dyndns.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> [Client data] I have not changed any register names. Do I have to do
> that?

You don't have to, the names as they are now look correct. Sometimes the
old names are different from what we are used to, that's why my guide
suggests to rename them in this case.

> [Function Prototypes] flages are gone. I have more than five
> prototypes is that something I have to modify?

No, there's nothing wrong with this. My advice was not to declare
utility fonctions that do not really belong to an interface to the chip.
But you are in fact free (technically) to declare the functions or not.

> [Sysctl] I now understand what I have to do to port this to sysfs
> instead of procfs. I have to write "show" functions to replace all the
> current functions that have a SENSORS_PROC_REAL_READ and a "set"
> function to replace every function that has a 
> SENSORS_PROC_REAL_WRITE.

Yes, you got it.

> I don't quite grasp what the SENSORS_PROC_REAL_INFO operation does,
> can it safely be ignored?

This was used to retrieve the magnitude associated with readings. As we
moved to sysfs, we also decided that magnitudes would be fixed once and
forever for each kind of readings (voltages, temperatures...). So you
don't have to define anything to replace this operation.

Not that this doesn't mean that you can ignore magnitudes completely.
The new, common magnitudes usually differ from the old, per-reading
magnitudes (that's what it takes to have a single magnitude for
everyone) so you will most likely have to change the conversion formulas
to reflect that. See the sysfs-interface document for details on new
magnitudes.

> Then I have to issue DEVICE_ATTR for every value the chip read to
> create the callback link to the "set" and "show" functions.

Correct.

> I have read the section on i2c sysfs filenames but I have some
> questions. Alarms have more then one value (all the alarms are
> accessed through it) in the file. Are the values in the current
> implementation scaled? Do I have to multiply everything by 1000?

I'm not sure I understand you. The alarm file is a bitvector, usually
matching one or more registers in the chips. The "total" value itself
has no meaning (only individual bits), so it is of course not scaled.

> What do I do with the vt1211_uch function? It's not specified in the
> sysfs-interface file.

As I understand it, the VT1211 can be configured to monitor either
voltages or temperatures on a number of (UCH) channels. This is
something unusual, I don't know how I would handle it myself. You may
ask Mark Studebaker about it, since he wrote the driver. Also, you could
take a look at the via686a driver, since it has already been ported and
the vt1211 driver is supposed to be derived from it.

I think I would not present the UCH (channel selector as I understand
it) register through sysfs. I would consider that the BIOS must have
configured it correctly, and just read from it at the time the module is
loaded to decide which files (tempN* or inN*) I should add to the sysfs,
for each channel N. But obviously that's done differently in the current
driver.

As a general rule, you have to stick to what sysfs-interface says. If
you come to a point where you just can't, then start a discussion thread
here about the new files you would need.

> [Attach] How do I know if my chip uses ISA only?

It obviously does, since 1* there is a comment that says so at the
beginning of the source code and 2* there are no I2C addresses defined.

> [Detect] There is only one ERRORX. Should I call it ERROR0?

I think my guide says "exit" in this case. But as usual you're
relatively free as long as the name you chose makes sense.

> Is it safe to remove the "sysctl stuff" that I commented out?

I don't know. I never ported an ISA chip and I don't remember quite well
what I did when porting the lm83 driver. You best chance is to take a
look at already ported drivers (via686a comes to mind). If they don't
have that stuff, then you can get rid of it.

> From what I can tell err is set correctly, is this true?

Looks correct.

> I have attached the files and the compilation result so far. I don't
> know what do to about this error:
> /home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c: In function
> `vt1211_detect':
> /home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:395: warning:
> `check_region' is deprecated (declared at include/linux/ioport.h:119)

Again, I would look at the via686a driver. Since I think it is similar
to the vt1211, you should find how the check_region call was replaced
there.

> Thank you for your help.

You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
