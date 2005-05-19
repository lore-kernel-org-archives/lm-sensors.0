From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <2538186705042422366584aff4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I'm sending this driver sysfs callback patch to the lm-sensors list to
get more of the sensor driver maintainer's comments on the patch
(specifically the type to be associated with each sysfs entry) before
submitting to LKML. Jean and Greg have already given me invaluable
feedback and are supportive of the general idea of the patch (the
problem of which is epitomized by the kludge the 2.6 bmcsensors driver
is at the moment - see previous discussions in the list archive).

Included is a patch against drivers/base/core.c and
include/linux/driver.h that adds a void * to the device attribute
struct and passes it back to the two sysfs callbacks show/store. Also
included is a simple perl script we can run against the source tree to
update drivers to use the correct callback pointer types (otherwise
warnings are generated on compile for each). Of course 'real' fixes in
the spirit of the new callbacks would be to use the void */passed type
to implement a single/few dynamic callback instead of the messy static
callbacks at present, but I leave that up to the individual driver
maintainer.

The original patch I sent out to Jean/Greg for comment just passed the
sysfs name of the corresponding sysfs entry, and Jean wisely suggested
that this was not ideal and suggested using an int instead. Greg
instead suggested we use a void pointer (apparently like most other
such linux callbacks), and I am also favourable to that idea, although
both ideas are better than the present callbacks.

I do believe Greg's suggestion to pass back a void * is probably the
best balance of generalization and efficiency for kernel device
drivers, thinking just in terms of bmcsensors it is actually ideal. An
IPMI BMC (baseboard management controller) represents sensors by SDRs
(sensor data records) each of which is read by bmcsensors through the
i2c-ipmi (and in turn through the kernel IPMI interface) and into a
struct, and thereafter all are referenced in a fixed length array (as
in the original 2.4 driver).

With the new callbacks I could actually associate each of these SDRs
with the sysfs entries by passing a pointer to each struct, nothing
could be simpler to use. I can then use a linked-list (rather than the
fixed array) to store the pointers to aid in the de-allocation of the
SDR struct memory (or maybe even find a way to find all the pointers
created by the driver from the sysfs system and thus not even need the
list? I have to look into it).

Compared to passing back an int this has a distinct advantage - giving
each sdr an id and getting the id from the sysfs callback I would have
to search through the linked list of sdrs (using an array would imply
a fixed number/upper limit to the number of sensors), while given a
pointer to the sdr entry we don't need the id or to search for the
sdr.

Of course the best point about void * is that if all you want is an in
you can of course use a reference to an int...I don't think that the
allocation of memory for these ints is a problem given the amount of
memory we already allocate in creating the sysfs entry names, etc. I
really do think that this added complexity is trivial compared to the
added flexibility of a void * callback. We don't want to have to
change these sysfs callbacks ever again if we can help it (once will
be quite enough trouble! ;-) ) so I believe we should do things with
other driver's future needs in mind, and get it right the first time.

Thus at present my plan for re-writing bmcsensors goes something along
the lines of:

- get this (or a similar) patch accepted into the kernel.
- remove i2c-ipmi, roll IPMI interface back into bmcsensors/remove
what can be done directly with the kernel IPMI system.
- add bmcsensors to the new hwmon class of hardware sensors removing
any reference to the fake i2c code.
- remove fixed sdr list and replace with linked list.
- using the dynamic device callbacks this patch would introduce,
associate each sysfs entry with the corresponding sdr, replace the
kludge of the 100 (!) macro defined static sysfs callbacks with one
single dynamic callback that uses the void * pointer to the sdr to
decide what to return, thus allowing a virtually unlimited number of
sensors.
- cross fingers and submit to this list for testing and later
(hopefully) inclusion in kernel.

Mind you at the moment my IPMI BMC isn't even working in newer
(2.6.11.5) kernels, and I've got no response from the Linux IPMI list
on my problems so this might be a bit difficult for me to
develop/test.

Yani
-------------- next part --------------
diff -uprN -X dontdiff linux-2.6.12-rc3/drivers/base/core.c linux-2.6.12-rc3-devdyncallback/drivers/base/core.c
--- linux-2.6.12-rc3/drivers/base/core.c	2005-04-23 14:55:03.000000000 -0400
+++ linux-2.6.12-rc3-devdyncallback/drivers/base/core.c	2005-04-23 15:10:46.000000000 -0400
@@ -41,7 +41,7 @@ dev_attr_show(struct kobject * kobj, str
 	ssize_t ret = 0;
 
 	if (dev_attr->show)
-		ret = dev_attr->show(dev, buf);
+		ret = dev_attr->show(dev, buf, dev_attr->ptr);
 	return ret;
 }
 
@@ -54,7 +54,7 @@ dev_attr_store(struct kobject * kobj, st
 	ssize_t ret = 0;
 
 	if (dev_attr->store)
-		ret = dev_attr->store(dev, buf, count);
+		ret = dev_attr->store(dev, buf, count, dev_attr->ptr);
 	return ret;
 }
 
diff -uprN -X dontdiff linux-2.6.12-rc3/include/linux/device.h linux-2.6.12-rc3-devdyncallback/include/linux/device.h
--- linux-2.6.12-rc3/include/linux/device.h	2005-04-23 14:55:11.000000000 -0400
+++ linux-2.6.12-rc3-devdyncallback/include/linux/device.h	2005-04-23 15:10:05.000000000 -0400
@@ -335,8 +335,13 @@ extern void driver_attach(struct device_
 
 struct device_attribute {
 	struct attribute	attr;
-	ssize_t (*show)(struct device * dev, char * buf);
-	ssize_t (*store)(struct device * dev, const char * buf, size_t count);
+	ssize_t (*show)(struct device * dev, char * buf, void * ptr);
+	ssize_t (*store)(struct device * dev, const char * buf, size_t count, void * ptr);
+	/* 
+	 * void pointer can be used by driver to identify sysfs entry 
+	 * for 'dynamic' callbacks.
+	 */
+	void * ptr;
 };
 
 #define DEVICE_ATTR(_name,_mode,_show,_store) \




-------------- next part --------------
A non-text attachment was scrubbed...
Name: updatedyncallback.9249DEFANGED-pl
Type: application/octet-stream
Size: 257 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050425/68cb3ba7/updatedyncallback.obj
