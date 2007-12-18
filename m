From: Gary Funck <gary@intrepid.com>
Date: Tue, 18 Dec 2007 16:27:45 +0000
Subject: Re: [lm-sensors] sensors-detect: unecessary suggested change to
Message-Id: <20071218162745.GA16326@intrepid.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071217000316.GA27938@intrepid.com>
In-Reply-To: <20071217000316.GA27938@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 12/18/07 14:13:40, Jean Delvare wrote:
> 
> Agreed. I wanted to do that some times ago already, but could never
> find the time. This is done now, please give a try to the SVN version
> of sensors-detect and let me know what you think about it:
> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt

Jean, thanks.  Tried it out on FC8.  Replying 'yes' to all, the
following is printed:

: Now follows a summary of the probes I have just done.
: Just press ENTER to continue: 
: Driver `w83627hf' (should be inserted):
:   Detects correctly:
:   * ISA bus, address 0x290
:     Chip `Winbond W83627HF/F/HG/G Super IO Sensors' (confidence: 9)
: 
: Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): yes
: You should now start the lm_sensors service to load the required
: kernel modules.

Observations:

1. "(should be inserted):" may not be necessary, since either
sensors-detect will do that, or the user will be told to do that.

2. The output notes that "Driver" `w83627hf' was chosen, but
doesn't clearly say that was the module name written to
/etc/sysconfig/lm_sensors.  And the module/driver teminology may
be somewhat confusing here (a minor issue)?

3. The advice to start the service is good.  Should the user
also be advised to enable it via chkconfig, or is it enabled
by default in most distro packages?

The 'no' output follows:

: Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): no
: To load everything that is needed, add this to e.g. /etc/rc.d/rc.local:
: 
: #----cut here----
: # Chip drivers
: modprobe w83627hf
: # sleep 2 # optional
: /usr/bin/sensors -s # recommended
: #----cut here----
: 
: If you have some drivers built into your kernel, the list above will
: contain too many modules. Skip the appropriate ones! You really
: should try these commands right now to make sure everything is
: working properly. Monitoring programs won't work until the needed
: modules are loaded.

Observations:

1. Perhaps rephrase the suggestion as:

: To load everything that is needed, add this to
: the system init file (e.g. /etc/rc.d/rc.local):

2. If redundant modprobes are harmless, perhaps the suggestion
to check which modules are built into the kernel is unecessary
and might confuse a novice user/admin?

3. Not sure what to do with this line:
: # sleep 2 # optional
How does the user know if he/she should uncomment this line?
Is it necessary at all?

Thanks,
  - Gary

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
