From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 13 Jan 2009 18:45:58 +0000
Subject: Re: [lm-sensors] Updated initialization script, testers wanted
Message-Id: <496CE166.5060803@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090112140236.6b74302e@hyperion.delvare>
In-Reply-To: <20090112140236.6b74302e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
>=20
> On Tue, 13 Jan 2009 09:02:33 +0100, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> I have implemented and committed the sensors-detect side of ticket
>>> #2246. Now the lm_sensors initialization script needs to be updated as
>>> well, to make use of the new configuration file syntax. The
>>> initialization script in our repository is meant for Red Hat
>>> distributions but I don't have any, so I can't test my changes. The
>>> patch I intend to apply is attached, could you (or anyone with a Red
>>> Hat distribution) give it a try and confirm that it works OK?
>>> Beforehand, you'll need to download and run the latest version of
>>> sensors-detect:
>>>
>>> http://www.lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0/prog=
/detect/sensors-detect
>>>
>>> and let it regenerate /etc/sysconfig/lm_sensors.
>> Erm,
>>
>> Not tested, I'm not so happy with this change. I've read the ticker tryi=
ng to=20
>> find out why we would want this change, and I must say I'm not very conv=
inced=20
>> with the reasoning there.
>>
>> My problem with these changes is that to me it feels like changing the c=
onfig=20
>> file format without some very strong reasons, this will cause all kind o=
f pains=20
>> when upgrading from an lm_sensors version with the old format to that wi=
th the=20
>> new format. Do we really have to do this?
>=20
> The two reasons that motivated the change are explained in the ticket,
> there's not so much I can add:
>=20
> 1* Removing or adding a module manually is error-prone. Say you have
> the following configuration file:
>=20
> MODULE_0=3Dlm90
> MODULE_1=3Dk8temp
> MODULE_2=3Dit87
>=20
> Now you change your graphics adapter and the new one no longer has a
> thermal sensor, so you no longer need to load the lm90 driver. Simply
> removing the first line may or may not be enough, depending on how the
> initialization script is implemented. Apparently the one in openSUSE
> copes with that, but the one in our repository (which I think you use
> in Red Hat) doesn't.
>=20
> 2* The old format can't be edited with Yast's sysconfig editor, as the
> editor expects fixed variable names. I find it pretty convenient for
> the user to be able to edit all the system settings in a central place,
> with settings put in a function-oriented tree, and a help text for every
> setting. I don't know if Red Hat has an equivalent tool, but if it does
> then I expect it to have the same problem with the current lm-sensors
> configuration file format. It is much easier for me to tell a user to
> open the sysconfig editor and change the value of variable
> HWMON_MODULES to "foo bar" than to tell him/her to
> open /etc/sysconfig/lm_sensors with a text editor, check the highest
> MODULE_%d variable, and add a new line MODULE_%(d+1)=BAr.
>=20

Hmm, 1 is sort of silly IMHO if you are making changes renumbering really i=
sn't=20
that hard to do, 2 to me feels like causing pain for all distros for the=20
benefit of one.

Anyways if we are going to make changes to the format, yes we will need a=20
migration script and, I think we need to think this through more.

To be more specific in the future we might / will hopefully get support for=
=20
hwmon on graphics cards, then hopefully everything needed will autoload but=
 we=20
might need entries in /etc/sysconfig/lm_sensors, so I'm thinking that it wo=
uld=20
be good to have separate lines for things like motherboard sensors, gpu sen=
sors=20
and harddisk sensors. This will make it easier for both manual editing as f=
or=20
tools for (automatic) configuration.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
