From: Gary Funck <gary@intrepid.com>
Date: Mon, 17 Dec 2007 00:03:16 +0000
Subject: [lm-sensors] sensors-detect: unecessary suggested change to
Message-Id: <20071217000316.GA27938@intrepid.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sensors-detect, prints the following:

    To load everything that is needed, add this to some /etc/rc* file:

    #----cut here----
    # Chip drivers
    modprobe w83627hf
    # sleep 2 # optional
    /usr/bin/sensors -s # recommended
    #----cut here----

    If you have some drivers built into your kernel, the list above will
    contain too many modules. Skip the appropriate ones! You really
    should try these commands right now to make sure everything is
    working properly. Monitoring programs won't work until the needed
    modules are loaded.

    Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):

But if the user replies 'yes' above, then appropriate
module name is written into /etc/sysconfig/lm_sensors,
_and_ /etc/init.d/lm_sensors will run the 'sensors -s'
command when lm_sensors starts up.

Suggestion: just print the module(s) that need to be loaded,
and if the user replies 'yes', take no further action.
Otherwise, print the suggestion to add the needed lines to an
/etc/rc* file.  Also, it would be helpful to suggest the
conventional name (such as /etc/rc.local) for the 'rc' file.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
