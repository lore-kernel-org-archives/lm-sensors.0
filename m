From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 25 Jan 2006 22:26:19 +0000
Subject: [lm-sensors] [patch 0/6] hwmon/pc87360: various locking touches
Message-Id: <43D7FB0B.9090108@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi Jean, everyone,

This patchset applies on 16rc1-mm3.  Individual descriptions
follow my series-file.  The 1st 3 patches are solid, and I think
ready for review and submission, 4-6 need discussion.
Also, 6 obsoletes 1.

$ more ../series-pc78360-next
# dont lock if data is fresh and valid
diff.pc-update-lock-only-when-refetching
# change all SENSOR_ATTRs to SENSOR_ATTR_2s,
hwmon-pc87360-use-sensor-attr-2.patch
# use the 2nd attr to combine show_X_Y callbacks to show_X
hwmon-pc87360-sysfs-combo-callbacks.patch
# add siolock module to make shared locks for Super-IO ports
diff.siolocks-beta2
# pc87360 should use shared Super-IO lock
#  diff.pc-use-siolocks
diff.uselocks.alpha1


1. diff.pc-update-lock-only-when-refetching

pc87360_update_device currently locks before checking that previously
sampled data is still fresh enough to use.  This patch does the check 1st,
and avoids the lock & unlock unless the data really is re-fetched.
Doing this early return also allows reducing indents thru the whole 
function,
modulo the out-dented function args. 

2. hwmon-pc87360-use-sensor-attr-2.patch

This converts SENSOR_ATTRs to SENSOR_ATTR_2s,
and add a bunch of #defines for the new 'property' of the attr.
This sets up the next patch.

3. hwmon-pc87360-sysfs-combo-callbacks.patch

This combines individual  (show|set)_Attr_Prop callbacks into
show|set)_Attr callbacks that handle all  Props of that Attr
(a dearth of good terminology here)

this results in a non-trivial size reduction (b4, after)
  14588    3224      16   17828    45a4 A-2/drivers/hwmon/pc87360.ko
  13124    3224      16   16364    3fec A-3/drivers/hwmon/pc87360.ko
ie about 10%


4. diff.siolocks-beta2

this patch adds new module, siolock(s?), a module which provides
a sharable lock for coordinated use of a Super-IO port amongst multiple 
drivers.

user-drivers call  get_superio_gate() or get_superio_gate_any(), 
identifying:
- the port addrs they expect to find a Super-IO port,
- the device-ids they are looking for,
- the super-io address where the device-id should be found.

they get back a struct gate*, which contains a mutex and the port-addr 
and device-id.
Multiple users of the device behind that port share this gate,
and can its lock it to preclude clashes.  (Its up to them to do so)


5. diff.uselocks.20060125.024521

This proto-patch uses the sio-lock-manager above.
Previous locks (read lock, update_lock) are unused and commented out.
All locking is now done in pc87360_read_value() and pc87360_write_value(),
using sio_lock(gate), sio_unlock(gate).

No distinction is made wrt update vs read (from sio pov, it doesnt matter).
What was your thinking wrt 2 separate locks ?

THis patch is quite rough - Ive // commented code rather than stripping it,
and left a lot of bits that would warrant some cleanup/refactoring.
(forex everywhere DEVID is checked)


6.   No-Code Proposal.

Having combined all the show/set-attr-prop callbacks in 3. it struck me
that the set- routines are calling pc87360_write_value() directly, and
the show- routines could do the same with pc87360_read_value()

By doing so, I could
- drop pc87360_update_device entirely
- allow reading of only 1 attr-prop
- drop stale/fresh choice, allowing much faster reading of 1 prop
- drastically reduce size of  struct pc87360_data, or remove it entirely.

Not a big conceptual change, and non-trivial gains, but it does mean 
code-churn,
and is sensitive to patches 1-5, so Im looking for an OK-in-principle.
This patch would obsolete patch 1, but depends on 2,3.



