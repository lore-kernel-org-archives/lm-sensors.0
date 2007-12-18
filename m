From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Dec 2007 17:36:20 +0000
Subject: Re: [lm-sensors] sensors-detect: unecessary suggested change to
Message-Id: <20071218183620.5c949de2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071217000316.GA27938@intrepid.com>
In-Reply-To: <20071217000316.GA27938@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gary,

On Tue, 18 Dec 2007 08:27:45 -0800, Gary Funck wrote:
> On 12/18/07 14:13:40, Jean Delvare wrote:
> > 
> > Agreed. I wanted to do that some times ago already, but could never
> > find the time. This is done now, please give a try to the SVN version
> > of sensors-detect and let me know what you think about it:
> > http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
> 
> Jean, thanks.  Tried it out on FC8.  Replying 'yes' to all, the
> following is printed:
> 
> : Now follows a summary of the probes I have just done.
> : Just press ENTER to continue: 
> : Driver `w83627hf' (should be inserted):
> :   Detects correctly:
> :   * ISA bus, address 0x290
> :     Chip `Winbond W83627HF/F/HG/G Super IO Sensors' (confidence: 9)
> : 
> : Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): yes
> : You should now start the lm_sensors service to load the required
> : kernel modules.
> 
> Observations:
> 
> 1. "(should be inserted):" may not be necessary, since either
> sensors-detect will do that, or the user will be told to do that.

In some cases, the message in parentheses will be different, so the
message is valuable independently of what happens next.

> 
> 2. The output notes that "Driver" `w83627hf' was chosen, but
> doesn't clearly say that was the module name written to
> /etc/sysconfig/lm_sensors.  And the module/driver teminology may
> be somewhat confusing here (a minor issue)?

The driver name and the module name are, fortunately, always the same,
so there's not much room for confusion. And anyway, the user doesn't
really need to know what was written to /etc/sysconfig/lm_sensors.

> 
> 3. The advice to start the service is good.  Should the user
> also be advised to enable it via chkconfig, or is it enabled
> by default in most distro packages?

In openSuse, sensors-detect is modified to call /sbin/inserv at this
point. I don't know about the other distributions. Admittedly it would
be nice to automate this step as well, however I don't know for sure
how this can be done in a portable way. We could do:

    system("/sbin/insserv", "/etc/init.d/lm_sensors")
      if -x "/sbin/insserv" && -f "/etc/init.d/lm_sensors";

That would work for openSuse and presumably Fedora, but I don't know
about Debian. Aurelien?

> 
> The 'no' output follows:
> 
> : Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): no
> : To load everything that is needed, add this to e.g. /etc/rc.d/rc.local:
> : 
> : #----cut here----
> : # Chip drivers
> : modprobe w83627hf
> : # sleep 2 # optional
> : /usr/bin/sensors -s # recommended
> : #----cut here----
> : 
> : If you have some drivers built into your kernel, the list above will
> : contain too many modules. Skip the appropriate ones! You really
> : should try these commands right now to make sure everything is
> : working properly. Monitoring programs won't work until the needed
> : modules are loaded.
> 
> Observations:
> 
> 1. Perhaps rephrase the suggestion as:
> 
> : To load everything that is needed, add this to
> : the system init file (e.g. /etc/rc.d/rc.local):

There is no such thing as "the system init file". There are many such
files, and they are better qualified as "scripts" than just files.

> 
> 2. If redundant modprobes are harmless, perhaps the suggestion
> to check which modules are built into the kernel is unecessary
> and might confuse a novice user/admin?

modprobe will fail and display an error message if told to load a
module that doesn't exist. And anyway, a novice user/admin will
certainly be using a distribution where /etc/sysconfig exists, so he/she
won't see this message at all.

> 
> 3. Not sure what to do with this line:
> : # sleep 2 # optional
> How does the user know if he/she should uncomment this line?
> Is it necessary at all?

I don't think it is necessary. At least I can't find any reason why
sleeping at this point could be of any help. Originally the line was
not commented out, I changed this back in July 2003. It's probably time
to remove it completely. If nobody objects, I'll do that.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
