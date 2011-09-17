From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 17 Sep 2011 16:31:38 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110917163138.GB20709@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sat, Sep 17, 2011 at 06:20:24AM -0400, Jean Delvare wrote:
> Hi Guenter,
>=20
> Late reply...
>=20
no problem - me busy too ;).

> On Tue, 13 Sep 2011 08:20:06 -0700, Guenter Roeck wrote:
> > On Tue, 2011-09-13 at 10:13 -0400, Jean Delvare wrote:
> > > If anything, then the answer depends on the CPU, as it depends on
> > > TjMax. But more likely, no, we don't want to set these values, as we =
do
> > > NOT initialize limits in hwmon drivers [1]. The whole point of the
> > > hwmon sysfs interface is to let the user set the limits they want in
> > > sensors.conf. Ideally each CPU would have sane defaults, and failing
> > > that, the BIOS should set appropriate values.
> > >=20
> > Looking at the code again, we did have ttarget for max, didn't we ? Any
> > objections against using it ?
>=20
> It's pretty confusing. If we stick to the SDM, MSR_TEMPERATURE_TARGET
> is a register (MSR 0x1a2) and "Temperature Target" is a 7-bit read-only
> value at 23:16 in this register. This value is what the 2.6.39 driver
> is calling tjmax (a name the SDM never uses.)
>=20
> What the 2.6.39 driver calls ttarget is another, undocumented 7-bit
> value at 15:8 in the same register. We should definitely have used a
> different name for it, but finding the proper name for something which
> is undocumented isn't easy. Rudolf Marek documented this temperature as
> the "temperature at which all fans should spin full speed". I have no
> idea where he got the information from, all I can say is that the
> reported value is 10=B0C below TjMax on my Xeon E5520 and 16=B0C below
> TjMax on my wife's Core2 Duo E6400, which seems realistic. But I don't
> think we ever reached these limits so I have no idea what would happen
> then (if anything.)
>=20
> Reusing the name ttarget for threshold1 in kernel 3.1 was definitely a
> bad idea, as it only added to the confusion, and also hid the fact that
> we were removing a feature from the driver in the process.
>=20
I agree.

> > As for max_hyst, looks like we'll have the option to leave it at 0, or
> > to set it to something. You had a problem with leaving it at 0, so I
> > guess it will be up to you to suggest an alternative. Setting it to the
> > same value as max might be an alternative (and maybe keep interrupts
> > disabled in that case).
>=20
> My own experiments since then suggest that we shouldn't touch it at all
> (at least not at driver initialization time.)
>=20
Yes.

> > > > > Interrupts should be enabled, and you can send uevents and sysfs =
notifications
> > > > > whenever a threshold is crossed. All you would have to do is to k=
eep the old
> > > > > alarm
> > > > > state and send events whenever it changes.
> > >=20
> > > But who should enable interrupts? And who will receive them? It really
> > > sounds like a task for thermal management, NOT hardware monitoring.
> > > Seems the boundary is getting blurrier every day...
> > >=20
> > > I would like to avoid the case where merely loading the coretemp driv=
er
> > > results in CPU throttling or worse simply because the threshold
> > > settings are wrong.
> > >=20
> > That is not how it works. The hwmon driver doesn't actually do anything.
> > Best current example is gpio-fan.c: If thresholds are crossed,
> > sysfs_notify is called for the affected alarm attributes, and a uevent
> > is generated for the hwmon kobject. The new EXYNOS4 driver has a similar
> > mechanism, though I had them take out sysfs notifications since those
> > only covered 0->1 alarm transitions and we don't have guidelines for how
> > to handle that (see below).
> >=20
> > I don't see a problem with the notifications - it pretty much lets
> > userland decide what if anything to do, and does not handle anything in
> > the kernel. It enables the use of poll() on sysfs alarm attributes which
> > I think is useful and desirable, and it generates a uevent to enable
> > script handling, which I also think makes sense.
>=20
> Yes, I'm totally fine with this as well, it all seems pretty sane and
> useful. It would be good to have this documented somewhere under
> Documentation/hwmon, but I don't think this is the case at the moment?
>=20
I wanted to get some feedback before I start documenting it. I should just
submit a patch describing how I think it should be done instead.

> > But on the other side I _did_ ask a couple of times on the list (I am
> > sure I copied you) if we should have guidelines for the use of
> > sysfs_notify() and kobject_uevent() in hwmon drivers. Unfortunately, I
> > didn't get any replies.
>=20
> I'm sorry about that... I'm way too busy to be helpful, I am aware of
> that, but unfortunately I don't expect much improvement in the near
> future, and maybe not even in the not so near future :(
>=20
> > As for getting and handling interrupts, there another example for that.
> > The lm90 driver already implements alert handling. Today it only
> > generates a log message, but one could imagine generating a uevent
> > and/or sysfs notifications. Problem with sysfs notifications, though, is
> > that smbus alerts are only generated for 0->1 transitions, not for 1->0
> > transitions. This again leads to the question if and how to use
> > sysfs_notify() in such cases.
>=20
> My work on the lm90 driver was essentially a proof of concept, or an
> example of SMBus alert support implementation if you will. It wasn't
> meant to be terribly useful in its original implementation. I
> completely agree that the log messages could be replaced by uevents or
> sysfs notifications or both.
>=20
I understand - I'll need to make it useful for the max6696 in our HW, thoug=
h.

> The fact that only 0->1 transitions are reported by the hardware is
> likely to be a frequent case. If I understand correctly, the idea is
> that the monitoring software can be passive as long as no notification
> is received, but once a notification is received, it should switch to
> active mode, taking action to solve the problem and then repeatedly
> checking the temperatures (for example) until the bad condition is
> gone. At which point it can go to passive mode again.
>=20
> I don't think it makes sense to request that both 0->1 and 1->0
> transitions are reported by drivers. If the hardware doesn't do it,
> then it doesn't do it. Instead, whatever user-space tool is in charge
> should expect (at least as a default behavior) that 1->0 transitions
> aren't notified. Does it answer your question?
>=20
Not really, unfortunately. Like in the lm90 driver, there are devices=20
which don't handle SMBalerts correctly. For PMBus devices, ADM1275, ADM1276,
and the entire UCD92xx series are among those (ADM127x trigger SMBalert eve=
ry few
ms while there is an alarm condirion, and UCD92XX simply hold the SMBalert =
pin low).
As soon as an alarm is triggered, I have to disable alerts completely and r=
evert
to polling to catch state updates. While this conveniently covers the 1->0 =
state
change, I need it to be able to re-enable alerts after all alarms have gone=
 away.

The lm90 driver with its LM90_HAVE_BROKEN_ALERT flag has the same problem.
Sure, one can simply disable alerts forever after the first alert is trigge=
red,
as the driver does right now, but that is really just as helpful as having
no alerts at all.

My current solution is to revert to in-kernel polling while alarms are acti=
ve.
This way I can re-enable alerts after the alarms are no longer active,
and the additional overhead is quite low since the polling thread only runs
while there are active alarms.

If we declare that applications can only depend on 0->1 transitions, I would
still need in-kernel polling to be able to re-enable alerts. As a result, we
would end up with double polling - by the kernel _and_ by the application.
That would really be undesirable.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
