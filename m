From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 May 2009 20:55:08 +0000
Subject: [lm-sensors] Kernel-provided labels
Message-Id: <20090512225508.7ab00c02@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Kernel-provided sensor labels can be problematic when the user tries to
apply a compute or ignore statement. In general, one can comment out
all label statements in the configuration file or run "sensors
-c /dev/null" to see the symbolic names of all inputs (in0, temp1
etc...) However, in the case where kernel-provided labels are
available, libsensors will process them nevertheless, so the user has
no way to see the symbolic name for the input.

I can think of different approaches to solve this issue. I wonder which
one other developers and users think should be implemented.

1* A new command line parameter to disable the processing of
   kernel-provided labels (say: --no-kernel-labels.)

2* A new command line parameter to disable the processing of
   kernel-provided labels and configuration files (say: --raw.)
   This is a shorter alternative to "sensors -c /dev/null
   --no-kernel-label".

3* A new sensors output format which would display all available
   symbolic names of a device, possibly with kernel-provided and
   user-provided labels in a table.

4* Allow kernel-provided labels to be used in compute statements
   instead of symbolic names.

5* Something else, speak up :)

Option 4 seems technically complex to me, and error-prone
(kernel-provided labels are not guaranteed to be unique.) Option 1 is
very specific, I tend to prefer option 2 which is more generic and can
evolve over time. Option 3 may be interesting for other reasons,
including debugging and a valuable alternative to walking the sysfs
tree.

As far as I can see, options 1, 2 and 3 all require that we extend the
libsensors API.

Opinion anyone?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
