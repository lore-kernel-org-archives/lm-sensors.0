From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Dec 2007 18:16:30 +0000
Subject: Re: [lm-sensors] sensors-detect: unecessary suggested change to
Message-Id: <47680E7E.2040601@aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071217000316.GA27938@intrepid.com>
In-Reply-To: <20071217000316.GA27938@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare a =E9crit :
> Hi Gary,
>=20
> On Tue, 18 Dec 2007 08:27:45 -0800, Gary Funck wrote:
>> On 12/18/07 14:13:40, Jean Delvare wrote:
>>> Agreed. I wanted to do that some times ago already, but could never
>>> find the time. This is done now, please give a try to the SVN version
>>> of sensors-detect and let me know what you think about it:
>>> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-=
detect?format=3Dtxt
>> Jean, thanks.  Tried it out on FC8.  Replying 'yes' to all, the
>> following is printed:
>>
>> : Now follows a summary of the probes I have just done.
>> : Just press ENTER to continue:=20
>> : Driver `w83627hf' (should be inserted):
>> :   Detects correctly:
>> :   * ISA bus, address 0x290
>> :     Chip `Winbond W83627HF/F/HG/G Super IO Sensors' (confidence: 9)
>> :=20
>> : Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): yes
>> : You should now start the lm_sensors service to load the required
>> : kernel modules.
>>
>> Observations:
>>
>> 1. "(should be inserted):" may not be necessary, since either
>> sensors-detect will do that, or the user will be told to do that.
>=20
> In some cases, the message in parentheses will be different, so the
> message is valuable independently of what happens next.
>=20
>> 2. The output notes that "Driver" `w83627hf' was chosen, but
>> doesn't clearly say that was the module name written to
>> /etc/sysconfig/lm_sensors.  And the module/driver teminology may
>> be somewhat confusing here (a minor issue)?
>=20
> The driver name and the module name are, fortunately, always the same,
> so there's not much room for confusion. And anyway, the user doesn't
> really need to know what was written to /etc/sysconfig/lm_sensors.
>=20
>> 3. The advice to start the service is good.  Should the user
>> also be advised to enable it via chkconfig, or is it enabled
>> by default in most distro packages?
>=20
> In openSuse, sensors-detect is modified to call /sbin/inserv at this
> point. I don't know about the other distributions. Admittedly it would
> be nice to automate this step as well, however I don't know for sure
> how this can be done in a portable way. We could do:
>=20
>     system("/sbin/insserv", "/etc/init.d/lm_sensors")
>       if -x "/sbin/insserv" && -f "/etc/init.d/lm_sensors";
>=20
> That would work for openSuse and presumably Fedora, but I don't know
> about Debian. Aurelien?

On Debian, the end of sensors-detect is heavily modified, as the sensors
modules are written to /etc/modules instead, and the format is a bit
different. All modules from this file are loaded automatically at boot time.

Then the /etc/init.d/lm-sensors script corresponds to a simple script
that read the "sensors -s" twice, so that the alarms are set and
possibly cleared.

For the sensord daemon we have a separate package, and the daemon is
enabled by default (since the package is not installed by default). This
can be changed via /etc/default/sensord (usual path on Debian).

So in short I am not opposed to changed on this part, as anyway it is
already different :-)

Cheers,
Aurelien

--=20
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
